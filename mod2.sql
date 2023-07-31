-- 1) What is the Highest Number of copies sold by a Package?
select TITLE,max(SOLD) from software group by SOLD, TITLE order by SOLD DESC;
-- 2) Display lowest course Fee.
select MIN(COURSE_FEE) as min_course_fee from studies 
-- 3) How old is the Oldest Male Programmer.
SELECT        PNAME, DOB, DOJ, GENDER, PROF1, PROF2, SALARY
FROM            programmer
WHERE        (DATEDIFF(year, DOB, GETDATE()) =
                             (SELECT        MAX(DATEDIFF(year, DOB, GETDATE())) AS ages
                               FROM            programmer
                               WHERE        (GENDER = 'M')))
--4 What is avg age of female programmer
select AVG(DATEDIFF(year, DOB, GETDATE())) from programmer where GENDER='F'
--5) Calculate the Experience in Years for each Programmer and Display with their names in Descending order.
select datediff(year,DOJ,GETDATE()) as yrs_of_exp ,PNAME from programmer order by PNAME DESC
--6) How many programmers have done the PGDCA Course?
select * from studies where course='PGDCA'
-- 7) How much revenue has been earned thru sales of Packages Developed in C.
select  PNAME, ((scost*sold)-DCOST) as REVENUE from software where DEVELOPIN='C'
-- 8) How many Programmers Studied at Sabhari?
select count(*) as NUM_OF_PROGRAMMER from studies where INSTITUTE='Sabhari'

-- 9) How many Packages Developed in DBASE?
select count(*) as NUM_OF_PACKAGE  from software where DEVELOPIN='dbase'

-- 10) How many programmers studied in Pragathi?
select count(*) as NUM_OF_PROGRAMMER from studies where INSTITUTE='Pragathi'


-- 11) How many Programmers Paid 5000 to 10000 for their course?

select count(*) as NUM_OF_PROGRAMMER,COURSE,COURSE_FEE from studies where COURSE_FEE between 5000 and 10000 GROUP BY COURSE,COURSE_FEE

-- 12) How many Programmers know either COBOL or PASCAL?

select count(*) as NUM_OF_PROGRAMMER from software where DEVELOPIN='COBOL' OR DEVELOPIN='PASCAL'

-- 13) How many Female Programmers are there?

select count(*) as NUM_OF_FEMALE_PROGRAMMER from programmer where GENDER='F'

-- 14) What is the AVG Salary?

select avg(salary) as AVG_SALARY from programmer

-- 15) How many people draw salary 2000 to 4000?

select count(*) as NUM_OF_PROGRAMMER from programmer where salary between 2000 and 4000 

-- 16) Display the sales cost of the packages Developed by each Programmer Language 
select SCOST,DEVELOPIN from software  group by SCOST,DEVELOPIN

-- 17) Display the details of the software developed by the male students of Sabhari.

select studies.PNAME,software.TITLE from studies inner join programmer on programmer.PNAME=studies.PNAME
inner join
software on software.PNAME=programmer.PNAME
where programmer.GENDER='M' and studies.INSTITUTE='SABHARI'
 
-- 18) Who is the oldest Female Programmer who joined in 1992?
select * from programmer where year(DOJ)='1992' and GENDER='F'

-- 19) Who is the youngest male Programmer born in 1965?
select * from programmer where year(DOB)='1965' and GENDER='M'
-- 20) Which Package has the lowest selling cost?
select * from software where SCOST=(select min(scost) from software)
-- 21) Which Female Programmer earning more than 3000 does not know C, C++,ORACLE or DBASE?
select * from programmer where GENDER='F' and  SALARY>3000 and (PROF1 not in ('C','C++','ORACLE','DBASE') and PROF2 not in ('C','C++','ORACLE','DBASE'))
-- 22) Who is the Youngest Programmer knowing DBASE?
 select * from programmer where datediff(year,dob,GETDATE())=(select min(DATEDIFF(year, DOB, GETDATE())) from programmer where (PROF1 ='DBASE' or PROF2='DBASE'))
-- 23) Which Language is known by only one Programmer?
select PROF1 from programmer group by PROF1 having PROF1 not in (select PROF2 from programmer) and count(*)=1
union
select PROF2 from programmer group by PROF2 having PROF2 not in (select PROF1 from programmer) and count(*)=1
-- 24) Who is the most experienced male programmer knowing PASCAL?
select * from programmer where datediff(year,doj,getdate())=(select max(datediff(year,doj,GETDATE())) from programmer where GENDER='M' and (PROF1='PASCAL' or PROF2='PASCAL')) and GENDER='M' and (PROF1='PASCAL' or PROF2='PASCAL')
-- 25) Who is the least experienced Programmer?
select * from programmer where datediff(year,doj,GETDATE())=(select min(DATEDIFF(year,doj,getdate())) from programmer)
-- 26) Display the Number of Packages in Each Language for which Development Cost is less than 1000.
select count(TITLE),DEVELOPIN from software where DCOST<1000 group by DEVELOPIN
-- 27) Display Highest, Lowest and Average Salaries for those earning more than 2000. 
select max(salary) as highest,min(SALARY) as lowest,avg(salary) as average from programmer where SALARY>2000