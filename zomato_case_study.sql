USE zomato_case_study;

# Q1. Find the customers who have never oredered
SELECT name 
FROM users 
WHERE user_id NOT IN (SELECT user_id FROM orders);


# Q2. Average  Price of per Dish
SELECT f.f_id, f.f_name, AVG(m.price) AS Avg_Price
FROM menu AS m
JOIN foods AS f ON m.f_id = f.f_id
GROUP BY f.f_id, f.f_name
LIMIT 1000;


# Q3. Find top restaurants in terms of number of orders for a given month.
#SELECT *,monthname(date) FROM zomato.orders # Extract Month Name from date column

#SELECT *,monthname(date) AS 'month' 
#FROM zomato.orders 
#WHERE monthname(date) Like 'June'; # Extract date column where it is June

SELECT r.r_name,count(*) AS 'month' 
FROM orders AS o
JOIN restaurants AS  r
ON o.r_id = r.r_id 
WHERE monthname(o.date) Like 'July'
group by o.r_id
order by count(*) DESC 
LIMIT 1;

# Q4. Restaurants with monthly sales greater than 800 for restaurant

SELECT o.r_id,r.r_name,sum(o.amount) AS 'revenue'
FROM orders AS o
JOIN restaurants AS r
ON o.r_id = r.r_id
WHERE monthname(o.date) Like 'June'
group by o.r_id, r.r_name
having revenue > 500;

# Q5. Show all orders with order details for a particular customer in a particular date range.

SELECT o.order_id, r.r_name, f.f_name
FROM zomato_case_study.orders AS o
JOIN zomato_case_study.restaurants AS r ON o.r_id = r.r_id
JOIN zomato_case_study.ordered_details AS od ON o.order_id = od.order_id
JOIN zomato_case_study.foods AS f ON f.f_id = od.f_id
WHERE o.user_id = (SELECT user_id FROM zomato_case_study.users WHERE name LIKE 'Ankit')
AND (o.date > '2022-06-10' AND o.date < '2022-07-10');


#Q6. Find restaurants with maximum number of repeated customers.

SELECT r.r_name, COUNT(*) AS loyal_customers
FROM (
    SELECT r_id, user_id, COUNT(*) AS 'visits'
    FROM zomato_case_study.orders 
    GROUP BY r_id, user_id
    HAVING visits > 2
) AS t
JOIN zomato_case_study.restaurants r ON t.r_id = r.r_id
GROUP BY r.r_id, r.r_name
ORDER BY loyal_customers DESC LIMIT 1;


# Q7. Month over month revenue growth of Zomato

WITH sales AS (
    SELECT MONTHNAME(date) AS month, DATE_FORMAT(date, '%Y-%m') AS month_order,SUM(amount) AS revenue
    FROM orders
    GROUP BY month, month_order
    ORDER BY month_order
)
SELECT month,revenue,LAG(revenue, 1) OVER (ORDER BY month_order) AS previous_month_revenue,((revenue - LAG(revenue, 1) OVER (ORDER BY month_order)) / LAG(revenue, 1) OVER (ORDER BY month_order)) * 100 AS percentage_change
FROM sales;

#Q8. Find favourite food of customer

WITH temp AS (
    SELECT o.user_id, od.f_id, COUNT(*) AS freq
    FROM zomato_case_study.orders AS o
    JOIN zomato_case_study.ordered_details AS od ON o.order_id = od.order_id
    GROUP BY o.user_id, od.f_id
)
SELECT u.name, f.f_name, freq
FROM temp AS t1
JOIN zomato_case_study.users AS u ON u.user_id = t1.user_id
JOIN zomato_case_study.foods AS f ON f.f_id = t1.f_id
WHERE t1.freq = (SELECT MAX(freq) FROM temp AS t2 
                WHERE t2.user_id = t1.user_id);
