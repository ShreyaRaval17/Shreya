create database shreya;
use shreya;

create table city
(
id int primary key, 
city_name varchar (50), 
lat float (9,6), 
long_ float (9,6) ,
country_id int
);

insert into city values
(1,"Berlin",52.520008,13.404954,1),
(2,"Belgrade",44.787197,20.457273,2),
(3,"Zagreb",45.815399,15.966568,3),
(4,"new_York",40.730610,-73.935242,4),
(5,"Los_Angeles",34.052235,-118.243683,4),
(6,"Warsaw",52.237049,21.017532,5);

create table customer
(id int primary key,
customer_name varchar(30),
city_id int,
customer_address varchar(50),
next_call_date date,
ts_inserted datetime
);

insert into customer values
(1,"Jewelry_Store",4,"Long_Street_120",'2020-01-21','2020-01-09 14:01:20.000'),
(2,"Bakery",1,"Kurfurstendamn_25",'2020-01-21','2020-01-09 17:52:15.000'),
(3,"Cafe",1,"TauentzienstraBe_44",'2020-01-21','2020-01-10 08:02:49.000'),
(4,"Restaurant",3,"ulica_Lipa_15",'2020-01-21','2020-01-10 09:20:21.000');


create table country
(id int primary key,
country_name varchar(30),
country_name_eng varchar(30),
country_code varchar(20)
);

insert into country values

(1,"Deutschland","Germany","DEU"),
(2,"Srbija","Seebia","SRB"),
(3,"Hrvatska","croatia","HRV"),
(4,"United_States_of_America","United_States_of_America","USA"),
(5,"Polska","Poland","POL"),
(6,"Espana","Spain","ESP"),
(7,"Rossiya","Russia","RUS");


-- Task : 1 (join multiple tables using left join)

-- List all city and customers related to these city.

select c.customer_name,s.city_name,s.id 
from customer as c
left join city as s
on c.city_id=s.id;

-- For each country displaying its name in English, the name of the city customer is located in as well as the name of the customer. 


SELECT country.country_name_eng,city.city_name,customer.customer_name
FROM country 
LEFT JOIN city on country.id = city.country_id
LEFT JOIN customer ON city.id = customer.city_id
where city_name is not null and customer_name is not null;


-- Return even countries without related cities and customers.

SELECT distinct country.country_name,country.id
FROM country
left JOIN city ON city.country_id = country.id
left JOIN customer ON city.id = customer.city_id
where country.id % 2 = 0;

-- Task : 2 (join multiple tables using both left and inner join)

-- Return the list of all countries that have pairs(exclude countries which are not referenced by any city). For such pairs return all customers.

SELECT country.country_name,customer.customer_name
FROM country
inner JOIN city ON city.country_id = country.id
LEFT JOIN customer ON city.id = customer.city_id
where customer_name is not null;


-- Return even pairs of not having a single customer.

select distinct c.country_name 
from country as c
inner join city as s on c.id=s.country_id
left join customer as p ON s.id = p.city_id
where c.id % 2 = 0 
and customer_name is null;


