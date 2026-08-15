import sqlite3

conn = sqlite3.connect("data/retail_sales.db")

query = """
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(DISTINCT "Order ID") AS total_orders,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin_percent
FROM sales
GROUP BY Region
ORDER BY total_profit DESC;
"""

cursor = conn.execute(query)

for row in cursor:
    print(row)

conn.close()