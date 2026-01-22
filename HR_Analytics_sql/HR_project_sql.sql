create database hr;
use hr;
/* KPI 1 : Average attrition rate for all departments */
call proc_attrition_rate();

/* KPI 2 :Average hourly rate of male research scientist*/
select round(Avg(hourlyrate),2) as Hourly_Rate from hr1 where jobrole="research scientist" and gender="male";

/* KPI 3: Attriton rate vs monthly income stats */
select h1.Department,concat(round(avg(attrition_rate)*100,2),"%") as Attrition_Rate ,concat(round(avg(h2.monthlyincome)/1000,2),"K") as MonthlyIncome 
from hr1 as h1 inner join hr2 as h2 
on h1.EmployeeNumber=h2.`Employee ID` group by h1.department;

/*KPI 4:Average working years for each department */
select h1.Department,round(avg(h2.totalworkingyears),2) as TotalWorkingYears 
from hr1 as h1 inner join hr2 as h2
on h1.Employeenumber=h2.`employee id` group by h1.department;

/*KPI 5: Job role vs worklife balance */
select JobRole,
case
when worklifebalance = 4 then 'excellent'
when worklifebalance = 3 then 'good'
when worklifebalance = 2 then 'average'
when worklifebalance = 1 then 'poor'
else 'null'
end as worklife_balance,
count(*) as employee_count
from hr1
join hr2
on hr1.EmployeeNumber = hr2.`Employee ID`
group by JobRole,worklifebalance
order by JobRole;

/* KPI 6:Attrtion rate vs Yearsincelastpromotion */
select Jobrole,concat(round(avg(attrition_rate)*100,2),"%") as Attrition_rate,avg(YearsSinceLastPromotion) as YearsSinceLastPromotion
from hr1 join hr2 on hr1.EmployeeNumber=hr2.`Employee ID` group by jobrole;





