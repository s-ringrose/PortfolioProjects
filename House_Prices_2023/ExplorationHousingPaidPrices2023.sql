--Data Exploration

--Av cost of newBuilds

SELECT newBuild, ROUND(AVG(price),0)  AS average_price, county, propertyType
FROM HousePrices2023..['pp-2023$']
WHERE newBuild = 'yes'
GROUP BY county, newBuild, propertyType;

CREATE VIEW AverageCostNewBuildsByCounty as
SELECT newBuild, ROUND(AVG(price),0)  AS average_price, county
FROM HousePrices2023..['pp-2023$']
WHERE newBuild = 'yes'
GROUP BY county, newBuild;

CREATE VIEW AverageCostNewBuildsByCountyPropertyType as
SELECT newBuild, ROUND(AVG(price),0)  AS average_price, county, propertyType
FROM HousePrices2023..['pp-2023$']
WHERE newBuild = 'yes'
GROUP BY county, newBuild, propertyType;

--number of houses under 250k
SELECT COUNT(ID) AS propertiesUnder250k, [town/city]
FROM HousePrices2023..['pp-2023$']
WHERE price <= 250000 AND estateType = 'Freehold' AND county = 'East Riding of Yorkshire'
GROUP BY [town/city];

--% of properties under 250k

SELECT ROUND((COUNT(CASE WHEN price <= 250000 THEN 1 END) * 100.0) / COUNT(*), 0) AS percentageUnder250k, county
FROM HousePrices2023..['pp-2023$']
GROUP BY county;

CREATE VIEW PercentageHousesUnder250k as
SELECT ROUND((COUNT(CASE WHEN price <= 250000 THEN 1 END) * 100.0) / COUNT(*), 0) AS percentageUnder250k, county
FROM HousePrices2023..['pp-2023$']
GROUP BY county;

CREATE VIEW PercentageHousesUnder450k as
SELECT ROUND((COUNT(CASE WHEN price <= 450000 THEN 1 END) * 100.0) / COUNT(*), 0) AS percentageUnder250k, county
FROM HousePrices2023..['pp-2023$']
GROUP BY county;

--%freehold vs leasehold for flats

SELECT ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0) AS percentageLeasehold, (100 - ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0)) AS percentageFreehold, propertyType
FROM HousePrices2023..['pp-2023$']
GROUP BY propertyType;

CREATE VIEW estateTypeByPropertyType as
SELECT ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0) AS percentageLeasehold, (100 - ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0)) AS percentageFreehold, propertyType
FROM HousePrices2023..['pp-2023$']
GROUP BY propertyType;

SELECT ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0) AS percentageLeasehold, (100 - ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0)) AS percentageFreehold, propertyType, county
FROM HousePrices2023..['pp-2023$']
GROUP BY propertyType, county;

CREATE VIEW estateTypeByPropertyTypeCounty as
SELECT ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0) AS percentageLeasehold, (100 - ROUND((COUNT(CASE WHEN estateType = 'Leasehold' THEN 1 END) * 100) / COUNT(*), 0)) AS percentageFreehold, propertyType, county
FROM HousePrices2023..['pp-2023$']
GROUP BY propertyType, county;

Create View PriceByPropertyType as
SELECT ROUND(AVG(price),0) as averagePrice , propertyType
FROM HousePrices2023..['pp-2023$']
GROUP BY propertyType;

--Average cost by postcode HU10-15

SELECT  startPostcode, COUNT(startPostcode) AS numberOfPropertiesUnder250k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price <= 250000
GROUP BY startPostcode;

SELECT  startPostcode, COUNT(startPostcode) AS numberOfPropertiesOver250k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price > 250000
GROUP BY startPostcode;

CREATE VIEW HU10Under250k AS
SELECT  startPostcode, COUNT(startPostcode) as numberOfPropertiesUnder250k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price <= 250000
GROUP BY startPostcode;

CREATE VIEW HU10Over250k AS
SELECT  startPostcode, COUNT(startPostcode) as numberOfPropertiesOver250k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price > 250000
GROUP BY startPostcode;

CREATE VIEW HU10Between250450k AS
SELECT  startPostcode, COUNT(startPostcode) as numberOfPropertiesBetween250k450k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price BETWEEN 250000 AND 450000
GROUP BY startPostcode;


CREATE VIEW PropertiesHU10Merge250k as
SELECT U.startPostcode AS startPostcode, U.numberOfPropertiesUnder250k, O.numberOfPropertiesOver250k
FROM HU10Under250k AS U
INNER JOIN HU10Over250k AS O 
ON U.startPostcode = O.startPostcode;


--450k HU10

CREATE VIEW HU10Under450k as
SELECT  startPostcode, COUNT(startPostcode) as numberOfPropertiesUnder450k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price <= 450000
GROUP BY startPostcode;


CREATE VIEW HU10Over450k AS
SELECT  startPostcode, COUNT(startPostcode) as numberOfPropertiesOver450k
FROM HousePrices2023..['pp-2023$']
WHERE (startPostcode = 'HU10' OR 
	startPostcode = 'HU11' OR
	startPostcode = 'HU12' OR
	startPostcode = 'HU13' OR
	startPostcode = 'HU14' OR
	startPostcode = 'HU15') AND
	price > 450000
GROUP BY startPostcode;

CREATE VIEW PropertiesHU10Merge450k as
SELECT U.startPostcode AS startPostcode, U.numberOfPropertiesUnder450k, O.numberOfPropertiesOver450k
FROM HU10Under450k AS U
FULL JOIN HU10Over450k AS O 
ON U.startPostcode = O.startPostcode;


--Seasonal trends

SELECT county, 
    CASE 
        WHEN MONTH(saleDate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(saleDate) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(saleDate) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Winter'
    END AS season,
    ROUND(AVG(price), 2) AS average_price
FROM 
    HousePrices2023..['pp-2023$']
GROUP BY county,
    CASE 
        WHEN MONTH(saleDate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(saleDate) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(saleDate) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Winter'
    END;


CREATE VIEW seasonalTrends as
SELECT county, 
    CASE 
        WHEN MONTH(saleDate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(saleDate) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(saleDate) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Winter'
    END AS season,
    ROUND(AVG(price), 2) AS average_price
FROM 
    HousePrices2023..['pp-2023$']
GROUP BY county,
    CASE 
        WHEN MONTH(saleDate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(saleDate) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(saleDate) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Winter'
    END;

CREATE VIEW seasonalTrendspropertyType as
SELECT propertyType,
    CASE 
        WHEN MONTH(saleDate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(saleDate) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(saleDate) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Winter'
    END AS season,
    ROUND(AVG(price), 2) AS average_price
FROM 
    HousePrices2023..['pp-2023$']
GROUP BY propertyType,
    CASE 
        WHEN MONTH(saleDate) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(saleDate) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(saleDate) IN (9, 10, 11) THEN 'Autumn'
        ELSE 'Winter'
    END;

