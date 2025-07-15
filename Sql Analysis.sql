-- How many customers are enrolled in the loyalty program yearly
SELECT 
      enrollment_year,
      count(loyalty_number) as total_enrollment
FROM 
      customer_loyalty_history
GROUP BY enrollment_year
ORDER BY enrollment_year;


-- How many customers enrolled each month in 2018?
SELECT
	  enrollment_month, 
	  count(loyalty_number) as total_enrollment
FROM 
	  customer_loyalty_history
WHERE enrollment_year = 2018
GROUP BY enrollment_month
ORDER BY enrollment_month;
 
 
-- What is the total number of enrollments during the campaign period (Feb–Apr 2018)? OR How many customers enrolled through the 2018 promotion?
SELECT 
      count(loyalty_number) as Total_enrollment
FROM 
	  customer_loyalty_history
WHERE enrollment_type = "2018 Promotion";


-- Which provinces had the most loyalty enrollments in 2018?
SELECT 
      province,
	  count(loyalty_number) AS Enrollment_count
FROM 
      customer_loyalty_history
WHERE enrollment_year = 2018
GROUP BY province
ORDER BY Enrollment_count DESC
LIMIT 1;


-- How many customers cancelled their membership after joining through the promotion?
SELECT 
      count(loyalty_number) as Total_Cancellation
FROM 
      customer_loyalty_history
WHERE 
	  enrollment_type = "2018 Promotion"
      And cancellation_year is not null;


-- What is the monthly trend of total flights booked in 2018?
SELECT 
      Month, 
	  sum(Total_flights) as Total_flights
FROM 
      customer_activity
WHERE YEAR = 2018
GROUP BY Month
ORDER BY Month;


-- What is the CLV difference between customers who enrolled via promotion vs standard enrollment?
SELECT 
      enrollment_type, 
	  round(sum(clv),2) as Total_clv, round(Avg(CLV),2) as avg_clv
FROM 
      customer_loyalty_history
WHERE enrollment_year = 2018
GROUP BY enrollment_type;


-- Which marital status group showed the highest average flight bookings post-campaign (May–Aug 2018)?
SELECT 
      h.marital_status, 
	  round(avg(a.total_flights),2)
FROM 
	 customer_loyalty_history h
JOIN customer_activity a 
     ON h.loyalty_number = a.loyalty_number
WHERE a.year = 2018 and a.month between 5 and 8
GROUP BY h.marital_status;


-- Which education level had the highest average points accumulated during the campaign?
SELECT 
      h.Education, 
	  round(avg(a.points_accumulated),2) as Total_points
FROM 
      customer_loyalty_history h
JOIN customer_activity a 
        ON h.loyalty_number = a.loyalty_number
WHERE enrollment_type = "2018 Promotion"
GROUP BY h.Education
ORDER BY Total_points DESC;


-- What percentage of customers enrolled during the campaign cancelled their membership later?
SELECT Round(100 * COUNT(loyalty_number)/
			(SELECT COUNT(loyalty_number) FROM customer_loyalty_history 
			WHERE enrollment_type = "2018 Promotion"),2)  as Total_cancellation_percent
FROM 
     customer_loyalty_history
WHERE 
      enrollment_type = "2018 Promotion"
      And cancellation_year is not null;


-- How does average salary vary between customers who cancelled and those who didn't?
SELECT
     ROUND(
           AVG(CASE WHEN CANCELLATION_YEAR IS NULL THEN SALARY END),2) AS AVG_SALARY_NOT_CANCELLED,
     ROUND(
           AVG(CASE WHEN CANCELLATION_YEAR IS NOT NULL THEN SALARY END),2) AS AVY_SALARY_CANCELLED
FROM 
	 CUSTOMER_LOYALTY_HISTORY;


-- Which gender has high no of enrollment through promotion
SELECT 
	  Gender, 
	  count(loyalty_number) as Total_member
FROM 
	  customer_loyalty_history
WHERE 
	  enrollment_type = "2018 Promotion"
      And cancellation_year is not null
GROUP BY Gender;


-- How does cancellation behavior vary across different salary groups?
WITH CTE AS (
SELECT
     loyalty_number, 
     cancellation_year,
     salary,
     CASE WHEN salary is null then 'Unknown'
          WHEN salary < 50000 then 'Low'
          WHEN salary < 150000 then 'Mid'
          ELSE 'high'
     END as Salary_group
     FROM customer_loyalty_history
)
SELECT 
	 salary_group, 
	 count(loyalty_number) as Total_members,
     sum(CASE WHEN cancellation_year is not null then 1 else 0 end) as Total_cancellations,
     round(100 * sum(CASE WHEN cancellation_year is not null then 1 else 0 end)/ count(loyalty_number),2) as cancellations_percent
FROM 
    CTE
GROUP BY Salary_group
ORDER BY cancellations_percent desc;


-- what is the net growth of loyalty memberships from Jan to Dec 2018 using monthly running totals?
WITH monthly_enrollments as (
SELECT 
       enrollment_month,
       count(loyalty_number) as monthly_new_enrollments
FROM 
       customer_loyalty_history
WHERE 
       enrollment_year = 2018
Group by enrollment_month
)
SELECT 
	   enrollment_month,
       monthly_new_enrollments,
       sum(monthly_new_enrollments) OVER(ORDER BY enrollment_month) as running_total_enrollments
FROM 
       monthly_enrollments;


-- Average flight change per customer before vs after campaign”
With cte as (
SELECT 
       loyalty_number, 
       month, 
       total_flights 
from 
       customer_activity
where year = 2018),
cte2 as (
select
     loyalty_number,
     SUM(CASE WHEN month = 1 then Total_flights Else 0 end) as jan_flights,
     SUM(CASE WHEN month in (2,3,4) then Total_flights else 0 end)/ 3.0 as during_campaign,
     SUM(CASE WHEN month > 4 then Total_flights else 0 end)/ 8.0 as post_campaign
FROM 
     cte
group by loyalty_number)
SELECT
   round(AVG(jan_flights),1) as avg_flights_before_campaign,
   round(AVG(during_campaign),1) as avg_flights_during_campaign,
   round(AVG(post_campaign),1) as avg_flights_post_campaign
from cte2;
      

-- Among promotion enrollees, which cities had the highest post-campaign engagement (flights booked)
SELECT
       h.province,h.city, 
       sum(total_flights) AS total_flights_booked
FROM 
       customer_loyalty_history h
JOIN customer_activity a 
         ON h.loyalty_number = a.loyalty_number
WHERE 
	 enrollment_type = "2018 Promotion" 
	 And a.year = 2018
     And a.month in(5,6,7)
GROUP BY h.province,h.city
ORDER BY total_flights_booked desc
LIMIT 10;


-- Identify the top 10 loyal customers (by CLV) and analyze their points redemption behavior.
SELECT
     h.loyalty_number, 
     max(h.CLV) as clv, 
     sum(a.points_redeemed) as total_points_redeemed
FROM 
	  customer_loyalty_history h
JOIN customer_activity a
             on h.loyalty_number = a.loyalty_number
Group by h.loyalty_number
ORDER BY CLV desc
limit 10;


-- Using rolling 3-month totals, how did flight activity change during and after the campaign?
WITH CTE AS (
SELECT 
     year, 
     month,
     sum(Total_flights) as Total_flights
FROM 
    customer_activity
WHERE year = 2018
GROUP BY year, month
)
SELECT 
      year,
      month,
      total_flights,
     sum(total_flights) OVER(order by month 
	 rows between 2 preceding and current row) as rolling_3_month_flights
from CTE
Order by month;






