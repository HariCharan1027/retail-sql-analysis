-- ============================================================
-- RETAIL SALES SQL ANALYSIS
-- ============================================================

-- 1. Overall performance
SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_units,
    COUNT(DISTINCT "Order ID") AS total_orders,
    ROUND(SUM(Sales) / COUNT(DISTINCT "Order ID"), 2) AS average_order_value,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM sales;


-- 2. Category performance
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM sales
GROUP BY Category
ORDER BY total_profit DESC;


-- 3. Sub-category performance
SELECT
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM sales
GROUP BY "Sub-Category"
ORDER BY total_profit DESC;


-- 4. Top 10 most profitable products
SELECT
    "Product Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold
FROM sales
GROUP BY "Product Name"
ORDER BY total_profit DESC
LIMIT 10;


-- 5. Top 10 loss-making products
SELECT
    "Product Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold
FROM sales
GROUP BY "Product Name"
ORDER BY total_profit ASC
LIMIT 10;


-- 6. Top 10 customers by profit
SELECT
    "Customer Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "Customer Name"
ORDER BY total_profit DESC
LIMIT 10;


-- 7. Bottom 10 customers by profit
SELECT
    "Customer Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "Customer Name"
ORDER BY total_profit ASC
LIMIT 10;


-- 8. Regional performance
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM sales
GROUP BY Region
ORDER BY total_profit DESC;


-- 9. Discount impact
SELECT
    Discount,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100, 2)
        AS profit_margin_percent
FROM sales
GROUP BY Discount
ORDER BY Discount;


-- 10. Shipping method usage
SELECT
    "Ship Mode",
    COUNT(*) AS shipment_records,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "Ship Mode"
ORDER BY total_orders DESC;


-- 11. Average shipping time
SELECT
    "Ship Mode",
    ROUND(
        AVG(
            julianday("Ship Date") -
            julianday("Order Date")
        ), 2
    ) AS average_shipping_days
FROM sales
GROUP BY "Ship Mode"
ORDER BY average_shipping_days;


-- 12. Monthly sales and profit
SELECT
    strftime('%Y-%m', "Order Date") AS month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY month
ORDER BY month;


-- 13. Highest sales month
SELECT
    strftime('%Y-%m', "Order Date") AS month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales
GROUP BY month
ORDER BY total_sales DESC
LIMIT 1;


-- 14. Lowest sales month
SELECT
    strftime('%Y-%m', "Order Date") AS month,
    ROUND(SUM(Sales), 2) AS total_sales
FROM sales
GROUP BY month
ORDER BY total_sales ASC
LIMIT 1;


-- 15. Highest profit month
SELECT
    strftime('%Y-%m', "Order Date") AS month,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY month
ORDER BY total_profit DESC
LIMIT 1;


-- 16. Lowest profit month
SELECT
    strftime('%Y-%m', "Order Date") AS month,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY month
ORDER BY total_profit ASC
LIMIT 1;


-- 17. Month-over-month sales
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', "Order Date") AS month,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM sales
    GROUP BY month
)

SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY month
    ) AS previous_month_sales,
    ROUND(
        (
            total_sales -
            LAG(total_sales) OVER (ORDER BY month)
        )
        / NULLIF(
            LAG(total_sales) OVER (ORDER BY month),
            0
        ) * 100,
        2
    ) AS month_over_month_growth_percent
FROM monthly_sales
ORDER BY month;


-- 18. State-level performance
SELECT
    State,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY State
ORDER BY total_profit DESC
LIMIT 10;


-- 19. Segment performance
SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Customer ID") AS customers
FROM sales
GROUP BY Segment
ORDER BY total_profit DESC;


-- 20. Profitability by discount category
SELECT
    CASE
        WHEN Discount = 0 THEN '0%'
        WHEN Discount <= 0.10 THEN '1-10%'
        WHEN Discount <= 0.20 THEN '11-20%'
        WHEN Discount <= 0.30 THEN '21-30%'
        WHEN Discount <= 0.40 THEN '31-40%'
        ELSE '40%+'
    END AS discount_category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_percent
FROM sales
GROUP BY discount_category
ORDER BY MIN(Discount);