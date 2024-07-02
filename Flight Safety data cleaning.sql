--Selecting all the values from the flight safety table 
select * 
from flight_safety.dbo.flightsafety
order by [Date of accident_new] asc; 

--Rename the columns 
use flight_safety;
exec sp_rename 'dbo.flightsafety.type', 'Aircraft model','column';
--- name of the database.old column , new column name and specify its the column we are changing at the end 
use flight_safety;
exec sp_rename 'dbo.flightsafety.operator', 'Operator', 'column';

use flight_safety
exec sp_rename 'dbo.flightsafety.location', 'Location', 'column';

use flight_safety
exec sp_rename 'dbo.flightsafety.dmg' , 'Damage', 'column';

use flight_safety
exec sp_rename 'dbo.flightsafety.reg#','Registration', 'column';

EXEC sp_rename 'dbo.flightsafety."[Date of accident].flightsafety"', '[Date of accident]', 'COLUMN';

EXEC sp_rename 'dbo.flightsafety."[Date of accident]"', 'Date of accident', 'COLUMN';

exec sp_rename 'dbo.flightsafety.fat#' , 'fatalities', 'column';

--Remove columns where all the values are null 
alter table dbo.['2014-2024$']
drop column [F7], [F9];

--Change Date format
select cast ([Date of accident] as date) as accident_date 
from flight_safety.dbo.flightsafety;

select format(cast ([Date of accident] as date),'dd-mm-yyyy') as formatted_date 
from flight_safety.dbo.flightsafety;


--Adding new column with the new date format 
alter table flight_safety.dbo.flightsafety
Add [Date of accident_new] Date;

--Updating new date column with the date of accidents 
update flight_safety.dbo.flightsafety
set [Date of accident_new] = format(cast ([Date of accident] as date), 'dd-mm-yyyy');

--Delete rows with null values 
delete from flight_safety.dbo.flightsafety
where [Aircraft model] is null and
[Registration] is null and 
[Operator] is null and
[fatalities] is null and
[location] is null and
[Damage] is null and
[Date of accident] is null and
[Date of accident_new] is null;

--Delete rows with these specific values 
delete from flight_safety.dbo.flightsafety
where [Aircraft model] = 'type' and
[Registration] = 'reg' and 
[Operator] = 'operator' and
[fatalities] is null and
[location] = 'location' and
[Damage] = 'dmg' and
[Date of accident] is null or
[Date of accident_new] is null;

--Checking if the column has been updated 
select [Date of accident_new]
from flight_safety.dbo.flightsafety;

--Delete all records where date of accident is =1970 
delete from flight_safety.dbo.flightsafety
where year([Date of accident])= 1970 or  
 year([Date of accident_new])= 1970 ;

 --Populating the null values in fatalities
select *
from flight_safety.dbo.flightsafety
where [fatalities] is null
ORDER BY [Date of accident_new] DESC;


 --Delete original date of accident column 
 alter table flight_safety.dbo.flightsafety
 drop column [Date of accident];

select isnull (cast ([fatalities] as varchar(10)), '') 
from flight_safety.dbo.flightsafety;

--Creating column for crew fatalities 
alter table flight_safety.dbo.flightsafety 
add [Crew fatalities] int ; 

--Populating each row of with the amount of fatalies where there is a null value 
update flight_safety.dbo.flightsafety
set fatalities = case
when fatalities is null and Registration = 'JA13XJ'then 5 
when fatalities is null and Registration = 'N80GE'then 1 
when fatalities is null and Registration = '5Y-SLK'then 2
when fatalities is null and Registration = 'PH-EZL'then 1 
when fatalities is null and Registration = '5Y-EMM'then 1 
when fatalities is null and Registration = 'SP-WAW' then 5 
when fatalities is null and Registration = 'N28JV' then 2 
when fatalities is null and Registration = 'CS-TVI' then 2
when fatalities is null and Registration = 'HK-5342G' then 1
when fatalities is null and Registration = 'N7227C' then 1
when fatalities is null and Registration = 'CC-BHB' then 2
when fatalities is null and Registration = 'N264NN' then 1
when fatalities is null and Registration = '5125' then 50
when fatalities is null and Registration = 'N1116N' then 1
when fatalities is null and Registration = 'AP-BLD' then 97
when fatalities is null and Registration = 'N752RV' then 3
when fatalities is null and Registration = 'A-1310' then 122
when fatalities is null and Registration = 'OM-ODQ' then 4
when fatalities is null and Registration = 'N442RM' then 4
when fatalities is null and Registration = 'OM-SAB' then 3
when fatalities is null and Registration = '46553' then 11
when fatalities is null and Registration = 'PT-MEO' then 0
when fatalities is null and Registration LIKE 'N77%' then 0
when fatalities is null and Registration = '9N-AMH' then 1
when fatalities is null and Registration = 'N484AR' then 1
when fatalities is null and Registration = '9S-GNH' then 21
when fatalities is null and Registration = '766' then 5
when fatalities is null and Registration = 'N959PA' then 1
when fatalities is null and Registration = '9N-AMH' then 1
when fatalities is null and Registration = '08-3174' then 11
when fatalities is null and Registration = 'N100EQ' then 3
when fatalities is null and Registration = 'N52SZ' then 1
ELSE fatalities
end;

--Updating the crew fatalities column where there is a null value 
update flight_safety.dbo.flightsafety
set [Crew fatalities] = case
when [Crew fatalities] is null and Registration = 'SP-WAW'then 1 
when [Crew fatalities] is null and Registration = 'N28JV' then 8 
when [Crew fatalities] is null and Registration = 'N7227C' then 5
when [Crew fatalities] is null and Registration = '5125' then 3
when [Crew fatalities]  is null and Registration = '8R-GFA' then 1
when [Crew fatalities]  is null and Registration = 'N996LM' then 8
when [Crew fatalities]  is null and Registration = 'N1116N' then 1
when [Crew fatalities] is null and Registration = 'AP-BLD' then 1
when [Crew fatalities]  is null and Registration = 'D-ABQB' then 1
when [Crew fatalities]  is null and Registration = 'A6-EMW' then 1
when [Crew fatalities] is null and Registration = 'N752RV' then 2
when [Crew fatalities] is null and Registration = 'A-1310' then 17
when [Crew fatalities]  is null and Registration = 'OM-ODQ' then 3
when [Crew fatalities] is null and Registration = 'N442RM' then 1
when [Crew fatalities]  is null and Registration = 'OM-SAB' then 4
when [Crew fatalities] is null and Registration = '46553' then 11
when [Crew fatalities] is null and Registration = '9N-AMH' then 2
when [Crew fatalities] is null and Registration = '9S-GNH' then 6
when [Crew fatalities]  is null and Registration = '766' then 14
when [Crew fatalities]  is null and Registration = 'N959PA' then 5
when [Crew fatalities]  is null and Registration = '9N-AMH' then 2
when [Crew fatalities]  is null and Registration = '9M-TST' then 1
when [Crew fatalities] is null and Registration = 'VP-BCG' then 1
when [Crew fatalities] is null and Registration = 'N511AC' then 2
when [Crew fatalities] is null and Registration = '5H-FJI' then 1
when [Crew fatalities] is null and Registration = '5Y-FDC' then 1
when [Crew fatalities] is null and Registration = 'OE-GKA' then 1
when [Crew fatalities] is null and Registration = 'TC-MCL' then 35
when [Crew fatalities] is null and Registration = 'A6-EMW' then 1
when [Crew fatalities] is null and Registration = 'D-ABQB' then 1
when [Crew fatalities] is null and Registration = '9Q-CVH' then 8
when [Crew fatalities] is null and Registration = 'TC-CPV' then 1
when [Crew fatalities] is null and Registration = 'VT-SCQ' then 1
when [Crew fatalities] is null and Registration = '08-3174' then 3
when [Crew fatalities] is null and Registration = 'N100EQ' then 3
when [Crew fatalities] is null and Registration = 'N52SZ' then 3
ELSE [Crew fatalities] 
end;

--Updating registration 
update flight_safety.dbo.flightsafety
set Registration = case
when Registration  = '465533'then '08-3174'
ELSE Registration 
end;


select *
from flight_safety.dbo.flightsafety
where [Crew fatalities] is not null
and Registration in(
select Registration
from flight_safety.dbo.flightsafety
where [Crew fatalities] is not null
group by Registration
having count (*)>1 );

UPDATE flight_safety.DBO.flightsafety
SET [Crew fatalities]=CASE
when [Crew fatalities] is null and Registration = 'N100EQ' and damage='sub'then 0
ELSE fatalities
END;

--Replacing all null values in the fatalities column with the number 0
UPDATE flight_safety.DBO.flightsafety
SET fatalities=CASE
WHEN fatalities IS NULL THEN 0
ELSE fatalities
END;

select *
from flight_safety.dbo.flightsafety
where Registration is null;

--Setting nulll values in registration column to unknown 
update flight_safety.dbo.flightsafety
set Registration=case 
when Registration is null then 'Unknown' 
else Registration
end;

select *
from flight_safety.dbo.flightsafety
where Operator is null;

--Setting null values in operator column to unknown 
update flight_safety.dbo.flightsafety
set Operator=case 
when Operator is null then 'Unknown' 
else Operator
end;

--Add new column for airport code
alter table flight_safety.dbo.flightsafety
add [Airport code_1] varchar(250); 

--Updating the new airpot code column by extracting value from the location column 
update flight_safety.dbo.flightsafety
set [Airport code_1]=case 
	when charindex ('(' , [Location])>0 AND charindex (')', [Location]) > charindex('(', [Location])
	then SUBSTRING([Location],
		charindex('(', [Location]) +1, 
		CHARINDEX(')', [Location]) - charindex ('(', [Location])-1)
	else 'unknown'
	end;

alter table flight_safety.dbo.flightsafety
drop column [Airport code];

select Location, [airport code_1] 
from flight_safety.dbo.flightsafety
order by [airport code_1];

select * 
from flight_safety.dbo.[airportcode];

--Data cleaning the Airport code table by dropping irrelevant columns 
alter table flight_safety.dbo.[airportcode]
drop column
longitude,
[World Area Code],
[City Name geo_name_id],
[Country Name geo_name_id],
coordinates; 

alter table flight_safety.dbo.[airportcode]
drop column latitude; 

alter table flight_safety.dbo.flightsafety
add country varchar(250); 

--Join Airport code table with the flight safety table and update the country column with the country name from the Airport code table 
update fs 
set fs.country=ac.[Country Name]
from flight_safety.dbo.flightsafety fs
join flight_safety.dbo.airportcode  ac 
on fs.[Airport code_1]=ac.[Airport code]
where fs.[Airport code_1] is not null and fs.[Airport code_1]!='unknown';

update fs 
set fs.country=coalesce (ac.[Country Name], ac_by_name.[Country Name])
from flight_safety.dbo.flightsafety fs
left join flight_safety.dbo.airportcode  ac
on fs.[Airport code_1]=ac.[Airport Code]
left join flight_safety.dbo.airportcode ac_by_name
on fs.[Location] like '%' + ac_by_name.[Airport Name] + '%'
where (fs.[Airport code_1] is not null and fs.[Airport code_1]!='unknown')
or fs.country is null;

update flight_safety.dbo.flightsafety
set country = case
when country is null then 'Unknown'
else country
end;

--Replacing null values in the country column 
update flight_safety.dbo.flightsafety
set country = case
when country is null then 'Unknown'
else country
end;


SELECT 
    [Aircraft model],
    CASE
        WHEN PATINDEX('%[0-9]%', [Aircraft model]) > 0 THEN LEFT([Aircraft model], PATINDEX('%[0-9]%', [Aircraft model]) - 1)
        ELSE [Aircraft model]
    END AS Manufacturer
FROM 
    flight_safety.dbo.flightsafety;



ALTER TABLE flight_safety.dbo.flightsafety
ADD Manufacturer VARCHAR(255);

--Update manufacturer column bysearching the Aircraft model column and printing out all the characters before any numbers 
UPDATE flight_safety.dbo.flightsafety
SET Manufacturer = REPLACE(
    CASE
        WHEN PATINDEX('%[0-9]%', [Aircraft model]) > 0 THEN LEFT([Aircraft model], PATINDEX('%[0-9]%', [Aircraft model]) - 1)
        ELSE [Aircraft model]
    END,
    '-', ''
);

--Updating the names of rows 
UPDATE flight_safety.dbo.flightsafety
SET Damage = CASE
    WHEN Damage = 'non' THEN 'None'
    WHEN Damage = 'sub' THEN 'Substantial'
    WHEN Damage = 'w/o' THEN 'Write-Off'
    WHEN Damage = 'min' THEN 'Minor'
	WHEN Damage = 'unk' THEN 'Unknown'
	WHEN Damage = 'mis' THEN 'Missing'
	WHEN Damage is null THEN 'Unknown'
    ELSE Damage  -- In case there are other values not covered by the CASE
END;