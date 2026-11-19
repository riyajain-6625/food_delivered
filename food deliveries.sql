
--  Validate missing links and invalid timestamps.

-- Q1. Duplicate and Missing Value Analysis
-- Identify karo:
-- - Har table mein total records.
select count(*) from customers as total_records;
select count(*) from deliveries total_records;
select count(*) from orders total_records;
select count(*) from  restaurants total_records;
select count(*) from riders total_records;
-- - Customers ki missing signup dates.
select sum(isnull(signup_date)) as missing_signups from customers ;
-- - Restaurants ki missing ratings.
select sum(isnull(rating)) as missing_ratings from restaurants ;
-- Calculate weekly order demand.
SELECT
    MONTH(order_time) AS month,
    SUM(order_amount) AS monthly_sales
FROM orders
GROUP BY MONTH(order_time)
ORDER BY month;
-- Calculate average delivery time.
select avg(delivered_time) from deliveries; 
-- Rank restaurants by revenue.
select r.restaurant_id ,sum(o.order_amount) as total_sales from restaurants r 
 join  orders  o
 on  r.restaurant_id=o.restaurant_id
 group  by  restaurant_id ,order_amount
 order by total_sales desc ;
 
 --  Compare cuisines by volume and cancellation.
SELECT
    r.cuisine,
    SUM(o.order_amount) AS total_sales
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.cuisine
ORDER BY total_sales DESC;
-- Identify the top 5 hours with the highest order demand.
SELECT
    HOUR(order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC
LIMIT 5;
-- -Calculate rider productivity.
select rider_id from deliveries 
where delivery_status='Delivered - Complaint';
-- Flag late deliveries
select * from deliveries  where delivery_status='Delivered Late';