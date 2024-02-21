

--Standardise Dates

Select saleDate
From HousePrices2023..['pp-2023$']

UPDATE ['pp-2023$']
SET date = CONVERT(Date, date)

ALTER TABLE ['pp-2023$']
ADD saleDate Date;

UPDATE ['pp-2023$']
SET saleDate = CONVERT(Date, date)


--Property Address Data *use CONCAT over || as null values

SELECT CONCAT_WS( ' ', PAON, SAON, street, locality, [town/city], postcode) AS Address
From HousePrices2023..['pp-2023$'];

ALTER TABLE ['pp-2023$']
ADD Address nvarchar(255);

UPDATE['pp-2023$']
SET Address = CONCAT_WS( ' ', PAON, SAON, street, locality, [town/city], postcode)

SELECT *
FROM ['pp-2023$']
order by county

SELECT 
SUBSTRING(postcode, 1, CHARINDEX(' ', postcode) -1) as StartPostcode
FROM HousePrices2023..['pp-2023$']

ALTER TABLE ['pp-2023$']
ADD startPostcode nvarchar(255);

UPDATE ['pp-2023$']
SET startPostcode = SUBSTRING(postcode, 1, CHARINDEX(' ', postcode) -1)

SELECT * 
FROM HousePrices2023..['pp-2023$']

SELECT
PARSENAME(REPLACE(postcode, ' ', '.'), 2),
PARSENAME(REPLACE(postcode, ' ', '.'), 1)
FROM HousePrices2023..['pp-2023$']

ALTER TABLE ['pp-2023$']
ADD endPostcode nvarchar(255);

UPDATE ['pp-2023$']
SET endPostcode = PARSENAME(REPLACE(postcode, ' ', '.'), 1)

--Property Type Data

SELECT Distinct(propertyType), count(propertyType)
FROM HousePrices2023..['pp-2023$']
GROUP BY propertyType
Order by 2

SELECT propertyType,
	CASE When propertyType = 'O' THEN 'Other'
		 When propertyType = 'F' THEN 'Flat'
		 When propertyType = 'D' THEN 'Detached'
		 When propertyType = 'S' THEN 'SemiDetached'
		 When propertyType = 'T' THEN 'Terraced'
		 END
FROM HousePrices2023..['pp-2023$']

UPDATE ['pp-2023$']
SET propertyType = CASE When propertyType = 'O' THEN 'Other'
		 When propertyType = 'F' THEN 'Flat'
		 When propertyType = 'D' THEN 'Detached'
		 When propertyType = 'S' THEN 'SemiDetached'
		 When propertyType = 'T' THEN 'Terraced'
		 END

--New Builds 

SELECT newBuild,
	CASE When newBuild = 'y' THEN 'Yes'
		 When newBuild = 'n' THEN 'No'
		 END
FROM HousePrices2023..['pp-2023$']

UPDATE ['pp-2023$']
SET newBuild = CASE When newBuild = 'y' THEN 'Yes'
		 When newBuild = 'n' THEN 'No'
		 END

select *
from HousePrices2023..['pp-2023$']

--estateType

Select estateType,
	CASE WHEN estateType = 'F' THEN 'Freehold'
		 WHEN estateType = 'L' THEN 'Leasehold'
		 END
FROM HousePrices2023..['pp-2023$']

UPDATE ['pp-2023$']
SET estateType = CASE WHEN estateType = 'F' THEN 'Freehold'
		 WHEN estateType = 'L' THEN 'Leasehold'
		 END


--Delete Columns 

ALTER TABLE HousePrices2023..['pp-2023$']
DROP COLUMN F15, F16

ALTER TABLE HousePrices2023..['pp-2023$']
DROP COLUMN date
