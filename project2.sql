-- q1 
create database alumni ; 
use alumni  ; 

-- q2 import done useing gui
-- answer=> we created database then cilck on the table then you will get
-- get option to table dataimport wilzard cilck on there then you will get option to 
-- you file in the fom of csv file then select then you will get many opetion 
-- to change data type but we will cilck  nest and so on nest our data will be import 

-- q3
 desc college_a_hs ;
 desc college_a_se ;
 desc college_a_sj ;
 desc college_b_hs ;
 desc college_b_se ;
 desc college_b_sj ;
 
 
select * from  college_a_hs ;
select * from  college_a_se ;
select * from  college_a_sj ;
select * from  college_b_hs ;
select * from  college_b_se ;
select * from  college_b_sj ;


select * from  College_A_HS where name is null or lastupdate is null or mothername;

delete  from college_a_hs where name  is null ; 

 -- q6 
 create view College_A_HS_View as (
 select 
 RollNo , LastUpdate,Name,FatherName,MotherName,Batch,
 Degree,PresentStatus,HSDegree,EntranceExam,Institute,Location
 from  College_A_HS where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null and batch is not null and degree is not null and presentstatus is not null 
 and hsdegree is not null and EntranceExam is not null and Institute is not null and location is not null 
) ;
 
 select * from College_A_HS_View ;
 
 -- q7 
 create view College_A_SE_viewc as (
 select * from College_A_SE 
 where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null and batch is not null and degree is not null and presentstatus is not null 
 and organization is not null and location is not null and location is not null 
) ; 

-- q8 
create view College_A_sj_viewc as (
 select * from College_A_sj 
 where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null  and batch is not null and degree is not null and presentstatus is not null 
 and organization is not null and designation is not null and location is not null 
) ; 

 -- q9 
 -- we checked there is no null value 
 create view College_b_sj_viewc as (
 select * from College_b_sj 
 where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null  and branch is not null and  batch is not null and degree is not null and presentstatus is not null 
 and organization is not null and designation is not null and location is not null 
) ; 

-- q10
 -- we checked there is no null value 
create view College_b_SE_viewc as (
 select * from College_b_SE 
 where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null  and branch is not null and batch is not null and degree is not null and presentstatus is not null 
 and organization is not null and location is not null and location is not null 
) ; 

-- q11
 -- we checked there is no null value 
create view College_A_sj_viewc as (
 select * from College_A_sj 
 where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null  and batch is not null and degree is not null and presentstatus is not null 
 and organization is not null and designation is not null and location is not null 
) ; 

-- q11
create view College_A_sj_viewc as (
 select * from College_b_sj 
 where RollNo   is not null and   LastUpdate is not null and Name is not null  and fathername is not null 
 and motherName is not null  and branch is not null and batch is not null and degree is not null and presentstatus is not null 
 and organization is not null and designation is not null and location is not null 
) ; 

-- q12

delimiter / 
create procedure table_con_lower() 
begin
select lower(name)name ,  lower(fathername)father , lower(mothername)
from  College_A_HS_View ;

select lower(name)name ,  lower(fathername)father , lower(mothername)
from  College_A_SE_viewc ;
select lower(name)name ,  lower(fathername)father , lower(mothername)
from  College_A_sj_viewc ;
end / ;
delimiter ;
call table_con_lower()  ;



USE sakila;
DELIMITER $
CREATE PROCEDURE getaddress(INOUT lastname1 VARCHAR(16000))
BEGIN 
    DECLARE finished INTEGER DEFAULT 0; 
    DECLARE lastnamelist VARCHAR(400) DEFAULT "";
    DECLARE addressdetail CURSOR FOR SELECT address FROM address;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    OPEN addressdetail;
    get_address_detail : LOOP 
        FETCH addressdetail INTO lastnamelist; 
        IF finished = 1 THEN 
            LEAVE get_address_detail; 
        END IF;
        SET lastname1 = CONCAT(lastnamelist, ":", lastname1);
    END LOOP get_address_detail;
    CLOSE addressdetail; 
END $
SET @lastname1 = '';
CALL getaddress(@lastname1);





-- q14 
delimiter /
create  procedure get_name_collegeA(inout lastname1 text(40000) )
begin
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE lastnamelist VARCHAR(400) DEFAULT "";
    DECLARE addressdetail CURSOR FOR select name from college_a_hs union select name from college_a_se union select name from college_a_sj;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    OPEN addressdetail;
    get_address_detail : LOOP
        FETCH addressdetail INTO lastnamelist;
        IF finished = 1 THEN
            LEAVE get_address_detail;
        END IF;
        SET lastname1 = CONCAT(lastnamelist, ":", lastname1);
    END LOOP get_address_detail;
    CLOSE addressdetail;
    
end /
delimiter ;
SET @lastname1 = '';
CALL get_name_collegeA(@lastname1);
select @lastname1  get_name_collegeA; 


delimiter /
create  procedure get_name_collegeb(inout lastname1 text(40000) )
begin
    DECLARE finished INTEGER DEFAULT 0;
    DECLARE lastnamelist VARCHAR(400) DEFAULT "";
    DECLARE addressdetail CURSOR FOR select name from college_b_hs union select name from college_b_se union select name from college_b_sj;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    OPEN addressdetail;
    get_address_detail : LOOP
        FETCH addressdetail INTO lastnamelist;
        IF finished = 1 THEN
            LEAVE get_address_detail;
        END IF;
        SET lastname1 = CONCAT(lastnamelist, ":", lastname1);
    END LOOP get_address_detail;
    CLOSE addressdetail;
    
end /
delimiter ;
SET @lastname1 = '';
CALL get_name_collegeb(@lastname1);
select @lastname1  get_name_collegeb; 

select 'career choice' , count(*) college_a_percentage  from  college_a_hs
union

 SELECT 'total salary', SUM(salary) totalsalary FROM salaries
    UNION
    SELECT 'average salary', AVG(salary) averagesalary FROM salaries
    UNION 
    SELECT 'minimum salary', MIN(salary) minimum FROM salaries
    UNION 
    SELECT 'maximum salary', MAX(salary) maximumsalry FROM salaries 
    UNION 
    SELECT 'standard deviation', STD(salary) std FROM salaries 