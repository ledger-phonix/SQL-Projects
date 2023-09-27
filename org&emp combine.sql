--To Display databases.
show databases

--using a database
use PortfolioProject

--Display tables
show tables

--selecting every thing from a table
select * from employees

--selecting some columns which has spaces in column name.
select `First Name`, sex , `Job Title` from employees
order by 1 

--selecting by groups
select sex, count(sex) total_people from employees group by sex

- -selecting people who have same job titlle
select * from employees where `Job Title` = "Dentist"
select * from employees where `Job Title` = "Dancer"

- - using like 
select * from employees where `First Name` like "%ia"
select * from employees where Email like "%.org"

- - updating a name 
select * from employees where `First Name` = 'Jo'
update employees set `First Name` = "Jerry" where `Job Title` = "Dancer"

- -changing the table....
show tables

select * from organizations

select country, count(country) as total_comp_in_country from organizations group by country

select country, Organization_Name ,count(country) from organizations group by country, Organization_Name
- -Using between clause
select * from organizations where Founded between 1980 and 2000 order by Founded

select * from organizations order by country


- -selecting by country name.
select * from organizations where country = "Pakistan"


select Organization_Name, country, Founded, 'Number of employee' from organizations

-- chnaging a  column name  with spaces
alter table organizations rename column `Number of employees` to num_of_emp;

select Organization_Name, Founded , country,num_of_emp from organizations order by num_of_emp desc

-- using case statement 
select  Organization_Name, Country, num_of_emp, Founded,
case 
	when Founded > 2010 then "New Company"
	when Founded > 2000 then "Medium Company"
	else "Old Company"
end as Company_Age 
from organizations

- -joining 2 tables
select `First Name` , sex , country , Organization_Name, `Job Title` from PortfolioProject.employees e 
join PortfolioProject.organizations o on e.index = o.index


-- Creating temporary table
create temporary table tmp_tb (Id int, Name varchar(50), JobTitle varchar(80), company varchar(255),
 country varchar(100) )
 
 -- inserting into temporary table by other tables
 
 insert into tmp_tb 
 select e.index, e.`First Name`, e.`Job Title`, o.Organization_Name, o.country from 
 employees e join organizations o on 
 e.index = o.index
 
 -- Displaying temporary table
 
 select * from tmp_tb
 
 -- Deleting temporary tables
 drop table if exists tmp_tb
 create temporary table tmp_tb (Id int, Name varchar(50), JobTitle varchar(80), company varchar(255),
 country varchar(100) )
 
 insert into tmp_tb 
 select e.index, e.`Last Name`, e.`Job Title`, o.Organization_Name, o.country from 
 employees e join organizations o on 
 e.index = o.index
 
 


