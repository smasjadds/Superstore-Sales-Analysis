--Add a column, named profit_type.
ALTER TABLE supermarket_sales
ADD Profit_type VARCHAR(50)



--Insert values in it by using case statement.
UPDATE Supermarket_sales
SET profit_type =
CASE 
WHEN profit >=1 THEN 'Profitable'
when profit <0 THEN 'Non Profitable' END




--ROUND THE VALUES OF : PROFIT, SALES AND DISCOUNT.

UPDATE Supermarket_sales
SET PROFIT= ROUND(PROFIT,2)

----
UPDATE Supermarket_sales
SET SALES= ROUND(SALES,2)

----
UPDATE Supermarket_sales
SET DISCOUNT= ROUND(DISCOUNT,2)





--1.How many unique countries, states and cities we have?
SELECT
COUNT(DISTINCT COUNTRY) AS 'Unique country',
COUNT(DISTINCT STATE) AS 'Unique state',
COUNT(DISTINCT CITY) AS 'Unique city'
FROM Supermarket_sales


--2.Total sales values?
SELECT ROUND(SUM(SALES),2) AS 'Total sales'
FROM Supermarket_sales



--3.Total sales by region?
SELECT Region , ROUND(SUM(SALES),2) AS 'Total sales'
FROM Supermarket_sales
GROUP BY REGION
order by 'Total sales' desc



--4.Top 10 states by sales?
SELECT  top 10 state, round(sum(sales),2) as 'Total sales'
from supermarket_sales
group by state
order by 'Total sales' desc


--5.Total Profit by Region.
SELECT Region, ROUND(SUM(PROFIT),2) AS 'Total Profit'
FROM Supermarket_sales
GROUP BY REGION
ORDER BY 'Total Profit' DESC


--6.Top 5 cities with highest sales.
SELECT TOP 5 CITY , ROUND(SUM(SALES),2) AS 'Total Sales'
from Supermarket_sales
group by City
order by 'Total Sales'desc


--7.Which shipping mode generates the highest profit.
SELECT ship_mode, ROUND(SUM(profit),2) as 'Total Profit'
from Supermarket_sales
group by ship_mode
order by 'Total Profit' desc


--8.Which sub_category are running at a loss.
SELECT DISTINCT SUB_CATEGORY
from supermarket_sales
WHERE Profit_type = 'Non Profitable'


--9.Show ship mode that has highest average discount.
SELECT * FROM
(SELECT SHIP_MODE, ROUND(AVG(DISCOUNT),2) 'Average Discount',
ROW_NUMBER() OVER (ORDER BY  AVG(DISCOUNT) DESC ) RN
FROM Supermarket_sales
GROUP BY ship_mode) XYZ
WHERE RN = 1


--10.Bottom 5 States by profit.
SELECT TOP 5 State, ROUND(SUM(PROFIT),2) AS 'Profit'
FROM Supermarket_sales
GROUP BY STATE
ORDER BY 2 ASC


--11.Top 3 sub categories per category by sales.
SELECT * FROM (SELECT SUB_CATEGORY, CATEGORY, ROUND(SUM(SALES),2) 'Sales',
RANK() OVER (PARTITION BY CATEGORY ORDER BY SUM(SALES) DESC) RN
FROM Supermarket_sales
GROUP BY sub_category, category) XYZ
WHERE RN <=3


--12.Rank cities by total sales within each region.
SELECT CITY,REGION, ROUND(SUM(SALES),2) AS 'Sales',
DENSE_RANK() OVER (PARTITION BY REGION ORDER BY SUM(SALES) DESC ) DR
FROM Supermarket_sales
GROUP BY City, region





--Business Impact Questions--

--13.Which category causes the most losses.
SELECT TOP 1 CATEGORY ,ROUND(SUM(PROFIT),2) AS 'Sales Loss'
FROM SUPERMARKET_SALES
WHERE PROFIT < 0 
GROUP BY category 
ORDER BY 'Sales Loss' Asc


--14.Which cities has high sales but not profitable.
SELECT CITY, SUM(SALES) AS 'Sales' , SUM(PROFIT) AS 'Profit'
FROM Supermarket_sales
WHERE profit < 0
GROUP BY CITY
ORDER BY 'Sales' DESC































