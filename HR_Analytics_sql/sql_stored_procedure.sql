CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_attrition_rate`()
BEGIN
declare continue handler for sqlexception
begin
select "Attrition_rate column already exist" as X;
end;
alter table hr1 add attrition_rate integer;
set sql_safe_updates=0;
update hr1 set attrition_rate= case when attrition="yes" then 1 else 0 end;
set sql_safe_updates=1;
select department,concat(round(avg(attrition_rate)*100,2),"%") as Attrition_Rate from hr1 group by department;
END