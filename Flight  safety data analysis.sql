--Total number of accidents since 2014 by year 
select year ([Date of accident_new]) as year,count(*) as num_accidents
from flight_safety.dbo.flightsafety
group by year ([Date of accident_new])
order by year;

--Total number of accidents per month (seasonal patterns)
select month ([Date of accident_new]) as month,count(*) as num_accidents_per_month
from flight_safety.dbo.flightsafety
group by month ([Date of accident_new])
order by month;

--Total number of accidents per season 
SELECT
    CASE
        WHEN MONTH([Date of accident_new]) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH([Date of accident_new]) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH([Date of accident_new]) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH([Date of accident_new]) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Unknown'
    END AS season,
    COUNT(*) AS num_accidents
FROM flight_safety.dbo.flightsafety
GROUP BY
    CASE
        WHEN MONTH([Date of accident_new]) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH([Date of accident_new]) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH([Date of accident_new]) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH([Date of accident_new]) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Unknown'
    END;

-- Amount of flights per flight type 
SELECT COUNT(*) AS total_commercial_flights
FROM flight_safety.dbo.flightsafety
WHERE flight_type = 'commercial';

SELECT COUNT(*) AS total_private_flights
FROM flight_safety.dbo.flightsafety
WHERE flight_type = 'private';


--Identify aircrat types most frequently involoved in accidents
select ([Aircraft model]) ,count(*) as num_accidents
from flight_safety.dbo.flightsafety
group by ([Aircraft model])
order by num_accidents desc;

---Number of Accidents by Manufacturer 
select (Manufacturer) ,count(*) as num_accidents
from flight_safety.dbo.flightsafety
group by (Manufacturer)
order by num_accidents desc;


select * 
from flight_safety.dbo.flightsafety
order by [Date of accident_new] asc; 

-- Level of damage per operator 
select operator, Damage, count(*) as [Number of accidents]  
from flight_safety.dbo.flightsafety
group by operator, Damage
order by operator, [Number of accidents] desc; 

--level of damage per flight type
select flight_type, Damage, count(*) [Number of accidents]
from flight_safety.dbo.flightsafety
group by flight_type, Damage
order by flight_type, [Number of accidents]desc; 

--Level of damage per Aircraft model
select [Aircraft model], Damage, count(*) [Number of accidents]
from flight_safety.dbo.flightsafety
group by [Aircraft model], Damage
order by [Aircraft model], [Number of accidents]desc; 

--Level of damage per Manufacturer
select Manufacturer, Damage, count(*) [Number of accidents]
from flight_safety.dbo.flightsafety
group by Manufacturer, Damage
order by Manufacturer, [Number of accidents]desc;


update flight_safety.dbo.flightsafety
set flight_type=
    CASE 
        WHEN operator LIKE '%Air Force' THEN 'military'
        ELSE flight_type
    END ;

	select Operator, count(*) as [Number of Accidents]
	from  flight_safety.dbo.flightsafety
	group by Operator 
	order by [Number of accidents]desc;

	--Number of fatalities over time 
	select year ([Date of accident_new]) as year, sum(fatalities) as total_fatalities
	from flight_safety.dbo.flightsafety
	group by year ([Date of accident_new])
	order by year; 

	--location analysis
	select country, count(*) as num_of_accidents 
	from flight_safety.dbo.flightsafety
	group by country
	order by country, num_of_accidents desc; 

	select Location, count(*) as num_of_accidents 
	from flight_safety.dbo.flightsafety
	group by Location
	order by num_of_accidents desc; 


	select country, damage, sum(fatalities) as total_fatalities 
	from flight_safety.dbo.flightsafety
	group by country, damage
	order by country,total_fatalities desc;

