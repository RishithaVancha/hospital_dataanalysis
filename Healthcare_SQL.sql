create database healthcare_data;
use healthcare_data;
-- create hospitalisation_details table 
create table hospitalisation_details(
Customer_ID	varchar(20) primary key,
year int,
month varchar(20),
date int,	
children int,
charges	int,
Hospital_tier varchar(20),
City_tier varchar(20),	
State_ID varchar(20)
);

select * from hospitalisation_details;

-- create medical_examinations table
create table medical_examinations(
Customer_ID varchar(20) primary key,
BMI decimal(5,2),
HBA1C decimal(5,2),
Heart_Issues varchar(20),
Any_Transplants varchar(20),
Cancer_history varchar(20),
NumberOfMajorSurgeries	varchar(20),
smoker varchar(20)
);

select * from medical_examinations;

-- create names table
create table names(
customer_id varchar(20) primary key,
name varchar(50)
);
select * from names;
select * from hospitalisation_details;

select count(*) from hospitalisation_details ;
select count(*) from names ;
select count(*) from medical_examinations ;
select year from hospitalisation_details
where Customer_ID between 'id1' and 'id10';
 select * from  hospitalisation_details;
drop table  hospitalisation_details;
create table hospital_data(
Customer_ID	varchar(20) primary key,
year int,
month varchar(20),
date int,	
children int,	
charges	int,
Hospital_tier varchar(20),
City_tier varchar(20),
State_ID varchar(20)
);
select count(*) from hospital_data;
select * from hospital_data;
delete from hospital_data 
where year = 2004 and 
month= 'nov' and date = 6 and children = 0 and charges = 1137 and hospital_tier = 'tier-3'and city_tier = 'tier-1'and
state_id = 'R1013';
select * from hospital_data ;

-- Business Problems
-- 1. List all patients with their names and BMI
select n.name, m.BMI 
from medical_examinations as m
inner join names as n 
on m.patient_id = n.patient_id;

-- 2. Find all patients who are smokers
select patient_id 
from medical_examinations
where smoker = 'yes';


-- 3. Show all patients who had any heart issues
select customer_id 
from medical_examinations
where Heart_Issues = 'yes';


-- 4. Retrieve all hospital visits in the year 1970.
select * 
from hospital_data
where year = 1970;

-- 5. Display the total charges for each hospital tier
select sum(charges) as total_charges, Hospital_tier
from hospital_data
group by hospital_tier;


-- 6.Find the number of children admitted by each city tier
select sum(children) as admitted_children, City_tier
from hospital_data
group by city_tier;

-- 7. show patients who had major surgeries(more than 0)
select * from medical_examinations
where NumberOfMajorSurgeries > 0;


-- 8. list patients who have both cancer history and heart issues
select patient_id 
from medical_examinations
where Cancer_history = 'yes' and Heart_Issues = 'yes';

-- 9.get the total number of patients from each state ID
select count(patient_id) as no_of_patients, state_id
from hospital_data
group by state_id;

-- 10.Find all visits where the charges were above $5000
select * from hospital_data
where charges > 5000;

-- 11.Find the average BMI of smokers vs non-smokers 
 select avg(BMI) as avg, smoker 
 from medical_examinations
 group by smoker;
 
 -- 12. Identify patients who had transplants and more than one major surgery
  select patient_id 
  from medical_examinations
  where Any_Transplants = 'yes' and
  cast(NumberOfMajorSurgeries as unsigned) > 1;
  
  -- 13. calculate the total hospital charges grouped by hospital tier and city tier
select sum(charges) as total_hospital_charges, hospital_tier, City_tier
from hospital_data
group by Hospital_tier, City_tier;

-- 14. Find the month with the highest number of hospitalizations
select count(*) as total_hospitalizations, month
from hospital_data
group by month
order by total_hospitalizations desc
limit 1;

-- 15. List patients who were hospitalizied more than 3 times in the database.
select patient_id , count(*) as count
from hospital_data
group by patient_id
having count(*) > 3;

-- 16. Find patients who have been hospitalised in every year from 1966 to 1970
select patient_id
from hospital_data
where year between 1966 and 1970
group by patient_id
having count(distinct year) = 5;

-- 17. Show the top 3 cities with the highest average charges
select city_tier, 
avg(charges) as average_charges
from hospital_data
group by city_tier
order by average_charges desc
limit 3;

-- 18. calculate the percentage of patients who are smokers
select 
(count(case when smoker = 'yes' then 1 End) * 100)/count(*) as percentage
from medical_examinations;

-- 19. Dispaly patients who have both heart issues and high HBA1C(>6.5)
select patient_id
from medical_examinations
where Heart_Issues = 'yes' and HBA1C > 6.5;

-- 20. Find the total hospital charges collected per state, per year
select state_id, year,
sum(charges) as total_charges
from hospital_data
group by state_id, year;

-- 21. For each patient calculate the total number of hospitalisations, total charges and average BMI
select h.patient_id, 
count(*) as total_hospitalisations, 
sum(h.charges) as total_charges, 
avg(m.BMI) as average_BMI
from hospital_data as h
inner join medical_examinations as m
on h.patient_id = m.patient_id
group by h.patient_id
order by h.patient_id;

-- 22. Find patients who have undergone major surgeries but do not have any cancer history
select patient_id
from medical_examinations
where NumberOfMajorSurgeries > 0 and Cancer_history = 'no' ;

-- 23. Find the top 3 hospital tiers where patients with heart issues are most commonly admitted
select h.hospital_tier, count(*) as Heart_issues_patients
from hospital_data as h 
inner join medical_examinations as m
on h.patient_id = m.patient_id
where Heart_Issues = 'yes'
group by h.Hospital_tier
order by hospital_tier desc
limit 3 ;
