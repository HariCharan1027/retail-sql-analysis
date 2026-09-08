-- ============================================================
-- RETAIL SALES SQL ANALYSIS
-- ============================================================


-- ============================================================
-- 1. BASIC DATASET OVERVIEW
-- ============================================================

SELECT
    COUNT(*) AS total_rows
FROM sales;

SELECT
    COUNT(DISTINCT "Order ID") AS total_orders,
    COUNT(DISTINCT "Customer ID") AS unique_customers,
    COUNT(DISTINCT "Product ID") AS unique_products
FROM sales;


-- ============================================================
-- 2. DATE RANGE
-- ============================================================

SELECT
    MIN("Order Date") AS first_order_date,
    MAX("Order Date") AS last_order_date
FROM sales;


-- ============================================================
-- 3. KEY BUSINESS KPIs
-- ============================================================

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS total_units_sold,
    COUNT(DISTINCT "Order ID") AS total_orders,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT "Order ID"),
        2
    ) AS average_order_value,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales;


-- ============================================================
-- 4. SALES BY CATEGORY
-- ============================================================

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY Category
ORDER BY total_sales DESC;


-- ============================================================
-- 5. SALES BY SUB-CATEGORY
-- ============================================================

SELECT
    Category,
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY Category, "Sub-Category"
ORDER BY total_sales DESC;


-- ============================================================
-- 6. MOST PROFITABLE SUB-CATEGORIES
-- ============================================================

SELECT
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY "Sub-Category"
ORDER BY total_profit DESC;


-- ============================================================
-- 7. LOSS-MAKING SUB-CATEGORIES
-- ============================================================

SELECT
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY "Sub-Category"
HAVING SUM(Profit) < 0
ORDER BY total_profit ASC;


-- ============================================================
-- 8. TOP 10 PRODUCTS BY SALES
-- ============================================================

SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY "Product ID", "Product Name"
ORDER BY total_sales DESC
LIMIT 10;


-- ============================================================
-- 9. TOP 10 PRODUCTS BY PROFIT
-- ============================================================

SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY "Product ID", "Product Name"
ORDER BY total_profit DESC
LIMIT 10;


-- ============================================================
-- 10. WORST 10 PRODUCTS BY PROFIT
-- ============================================================

SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY "Product ID", "Product Name"
ORDER BY total_profit ASC
LIMIT 10;


-- ============================================================
-- 11. TOP CUSTOMERS BY SALES
-- ============================================================

SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY total_sales DESC
LIMIT 10;


-- ============================================================
-- 12. TOP CUSTOMERS BY PROFIT
-- ============================================================

SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "Customer ID", "Customer Name"
ORDER BY total_profit DESC
LIMIT 10;


-- ============================================================
-- 13. SALES BY REGION
-- ============================================================

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY Region
ORDER BY total_sales DESC;


-- ============================================================
-- 14. SALES BY STATE
-- ============================================================

SELECT
    "State/Province",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "State/Province"
ORDER BY total_sales DESC
LIMIT 20;


-- ============================================================
-- 15. SALES BY CITY
-- ============================================================

SELECT
    City,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY City
ORDER BY total_sales DESC
LIMIT 20;


-- ============================================================
-- 16. SALES BY COUNTRY / REGION
-- ============================================================

SELECT
    "Country/Region",
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders
FROM sales
GROUP BY "Country/Region"
ORDER BY total_sales DESC;


-- ============================================================
-- 17. SALES BY CUSTOMER SEGMENT
-- ============================================================

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Customer ID") AS customers,
    COUNT(DISTINCT "Order ID") AS orders
FROM sales
GROUP BY Segment
ORDER BY total_sales DESC;


-- ============================================================
-- 18. SALES BY SHIP MODE
-- ============================================================

SELECT
    "Ship Mode",
    COUNT(DISTINCT "Order ID") AS orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY "Ship Mode"
ORDER BY total_sales DESC;


-- ============================================================
-- 19. AVERAGE SHIPPING TIME
-- ============================================================

SELECT
    "Ship Mode",
    ROUND(
        AVG(
            julianday("Ship Date") -
            julianday("Order Date")
        ),
        2
    ) AS average_shipping_days
FROM sales
GROUP BY "Ship Mode"
ORDER BY average_shipping_days;


-- ============================================================
-- 20. DISCOUNT ANALYSIS
-- ============================================================

SELECT
    ROUND(Discount, 2) AS discount_rate,
    COUNT(*) AS transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY ROUND(Discount, 2)
ORDER BY discount_rate;


-- ============================================================
-- 21. PROFITABILITY BY DISCOUNT CATEGORY
-- ============================================================

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
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS profit_margin_percentage
FROM sales
GROUP BY discount_category
ORDER BY MIN(Discount);


-- ============================================================
-- 22. HIGH-DISCOUNT TRANSACTIONS
-- ============================================================

SELECT
    COUNT(*) AS high_discount_transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
WHERE Discount >= 0.50;


-- ============================================================
-- 23. MONTHLY SALES AND PROFIT
-- ============================================================

SELECT
    strftime('%Y-%m', "Order Date") AS month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    SUM(Quantity) AS units_sold,
    COUNT(DISTINCT "Order ID") AS orders
FROM sales
GROUP BY month
ORDER BY month;


-- ============================================================
-- 24. MONTH-OVER-MONTH SALES GROWTH
-- ============================================================

WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', "Order Date") AS month,
        SUM(Sales) AS total_sales
    FROM sales
    GROUP BY month
)

SELECT
    month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        LAG(total_sales) OVER (ORDER BY month),
        2
    ) AS previous_month_sales,
    ROUND(
        (
            total_sales -
            LAG(total_sales) OVER (ORDER BY month)
        ) * 100.0 /
        NULLIF(
            LAG(total_sales) OVER (ORDER BY month),
            0
        ),
        2
    ) AS month_over_month_growth_percentage
FROM monthly_sales
ORDER BY month;


-- ============================================================
-- 25. YEARLY SALES
-- ============================================================

SELECT
    strftime('%Y', "Order Date") AS year,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS orders
FROM sales
GROUP BY year
ORDER BY year;


-- ============================================================
-- 26. PROFITABLE VS LOSS-MAKING ORDERS
-- ============================================================

WITH order_profit AS (
    SELECT
        "Order ID",
        SUM(Profit) AS order_profit
    FROM sales
    GROUP BY "Order ID"
)

SELECT
    CASE
        WHEN order_profit > 0 THEN 'Profitable'
        WHEN order_profit < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS order_type,
    COUNT(*) AS number_of_orders
FROM order_profit
GROUP BY order_type
ORDER BY number_of_orders DESC;


-- ============================================================
-- 27. REGION AND CATEGORY PERFORMANCE
-- ============================================================

SELECT
    Region,
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales
GROUP BY Region, Category
ORDER BY Region, total_sales DESC;


-- ============================================================
-- 28. DATA QUALITY CHECK
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN "Order ID" IS NULL
              OR "Customer ID" IS NULL
              OR "Product ID" IS NULL
              OR Sales IS NULL
              OR Profit IS NULL
            THEN 1
            ELSE 0
        END
    ) AS rows_with_missing_critical_values
FROM sales;