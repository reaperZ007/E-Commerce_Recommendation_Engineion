select * from Products;
select * from Interactions;
select * from Past_Purchases;

-- Analysis Started
-- 1. Select all records from the Products table:
select * from Products;
-- 2. Filter products by category 'Electronics':
select * from Products where category = 'Electronics'
-- 3. Sort products by price in descending order:
select * from Products
order by Price DESC;
-- 4. Count the number of interactions:
select count(*) as interaction_count from interactions;
-- 5. Calculate the total purchase amount for each user
select user_id,sum(total_amount) as total_purchase_amount
from Past_purchases
group by user_id
order by total_purchase_amount asc;
-- 6. Retrieve the oldest purchase date:
select min(purchase_date) as oldest_purchase_date from Past_Purchases;
-- 7. Join Products and Interactions to get product details with interaction type:
select p.*,i.interaction_type
from Products p join Interactions i on p.product_id = i.product_id;
-- 8. Subquery to find products with more than 10 interactions:
select product_id from Interactions group by product_id having count(*) > 10;
select *
from Products
where product_id in (select product_id from Interactions group by product_id having count(*) > 10);
-- 9. Update product price for a specific product:
update Products set price = 1500 where product_id = 'P001';
-- 10. Delete an interaction record:
delete from Interactions where interaction_id = 3;
-- 11. Retrieve the top 5 users with the highest total purchase amount:
select user_id,total_amount from Past_Purchases
order by total_amount desc
limit 5;
-- 12. Count the number of unique brands in the Products table:
select count(distinct brand) as unique_brands from Products;
-- 13. Window function to rank products by price within each category:
SELECT product_id, product_name, category, price, 
       RANK() OVER (PARTITION BY category ORDER BY price) AS price_rank
FROM Products;
-- 14. Common Table Expression (CTE) to find the average price of products:
with AvgPrice as (
select avg(price) as average_price from Products
)
select * from products where price > (select average_price from AvgPrice );
-- 15. Retrieve the product with the highest total purchase amount:
select product_id,max(total_amount) as highest_purchase_amount
from Past_Purchases
group by product_id
limit 1;
-- 16. Create a view to show interactions with product details:
create view InteractionsDetail as
select i.*,p.product_name, p.category, p.brand from Interactions i inner join Products p on i.product_id = p.product_id;
select * from InteractionsDetail;
-- 17. Rollback a transaction if an error occurs while updating interactions:
START TRANSACTION;
UPDATE Interactions SET interaction_type = 'Click' WHERE interaction_id = 10;
SAVEPOINT before_commit;
UPDATE Interactions SET interaction_type = 'View' WHERE interaction_id = 11;
ROLLBACK TO before_commit;
COMMIT;
-- 18. Count the number of interactions per product.
select product_id,count(interaction_type) as interaction_count
from Interactions
group by product_id;
-- 19. List top N most popular products based on interactions
select product_id,count(interaction_type) as interaction_count
from Interactions 
group by product_id
limit 3;
-- 20. Retrieve product details along with user interactions
select p.*,i.interaction_id,i.user_id,i.interaction_type
from Products p inner join Interactions i on p.product_id = i.product_id;
-- 21. Find products with no interactions:
select p.*,i.interaction_type
from Products p left join Interactions i on p.product_id = i.product_id
where i.product_id is null;
-- 22. Rank products by price within each category using window functions:
select product_id,product_name,category,price,
rank() over (partition by category order by price ) as price_rank
from Products;
-- 24. Calculate the cumulative sum of total purchases by user:
select user_id,purchase_id,total_amount,
sum(total_amount) over (partition by user_id order by purchase_id) as cumlative_sum
from Past_Purchases;
-- 25. Find products purchased more than once:
select * 
from Products
where product_id in (
select product_id
from Past_Purchases
group by product_id
having count(quantity) > 1);
-- 26. Retrieve interactions for products with prices above the average price:

select * from Interactions
where product_id in (select product_id from Products where price > (select avg(price) from Products) )
-- 27. Create a CTE to calculate average product price by category:
WITH AvgPriceByCategory AS (
    SELECT category, AVG(price) AS avg_price
    FROM Products
    GROUP BY category
)
SELECT p.product_id, p.product_name, p.category, p.price, c.avg_price
FROM Products p
JOIN AvgPriceByCategory c ON p.category = c.category;
-- 28. Use a CTE to find the top 3 users with the highest total purchase amounts:
WITH UserPurchaseTotals AS (
    SELECT user_id, SUM(total_amount) AS total_purchase_amount
    FROM Past_Purchases
    GROUP BY user_id
)
SELECT user_id, total_purchase_amount
FROM UserPurchaseTotals
ORDER BY total_purchase_amount DESC
LIMIT 3;
-- 29. Calculate the percentage contribution of each product to the total sales amount:
WITH ProductSales AS (
    SELECT product_id, SUM(total_amount) AS total_sales
    FROM Past_Purchases
    GROUP BY product_id
)
SELECT p.product_id, p.product_name, p.price, ps.total_sales,
       (ps.total_sales / (SELECT SUM(total_amount) FROM Past_Purchases)) * 100 AS sales_percentage
FROM Products p
JOIN ProductSales ps ON p.product_id = ps.product_id;
-- 30. Identify users who made purchases of more than $500 in a single transaction:
select user_id,product_id,total_amount from Past_Purchases 
where total_amount > 500;
-- 31. Calculate the average time between consecutive purchases for each user:
WITH UserPurchaseTimes AS (
    SELECT user_id, 
           purchase_date - LAG(purchase_date, 1) OVER (PARTITION BY user_id ORDER BY purchase_date) AS time_diff
    FROM Past_Purchases
)
SELECT user_id, AVG(time_diff) AS avg_time_between_purchases
FROM UserPurchaseTimes
GROUP BY user_id;
-- Above  query uses a window function to calculate the time difference between consecutive purchases for each user. Then, it calculates the average time between purchases for each user.
-- 32. Identify products that have been interacted with but not purchased:
select p.*,i.interaction_type
from Products p inner join Interactions i on p.product_id = i.product_id
where i.interaction_type <> 'Purchase';
-- 33. Find users who made purchases in the first and last quarter of the year:
select user_id
from Past_Purchases
where extract(QUARTER from purchase_date  ) = 1
or extract(QUARTER from purchase_date  ) = 4;
-- 34. Calculate the average quantity of products purchased by users who interacted with products priced above the average price:
WITH InteractedProducts AS (
    SELECT DISTINCT user_id, product_id
    FROM Interactions
),
AvgProductPrice AS (
    SELECT AVG(price) AS avg_price
    FROM Products
)
SELECT ip.user_id, AVG(pp.quantity) AS avg_quantity
FROM InteractedProducts ip
JOIN Products p ON ip.product_id = p.product_id
JOIN Past_Purchases pp ON ip.user_id = pp.user_id AND ip.product_id = pp.product_id
CROSS JOIN AvgProductPrice avgp
WHERE p.price > avgp.avg_price
GROUP BY ip.user_id;
-- 35. Find users who have interacted with products across multiple categories:
SELECT user_id
FROM (
    SELECT user_id, COUNT(DISTINCT category) AS num_categories
    FROM Interactions i
    JOIN Products p ON i.product_id = p.product_id
    GROUP BY user_id
) AS user_categories
WHERE num_categories > 1;
































