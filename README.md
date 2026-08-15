\# Retail Sales SQL Analysis



\## Project Overview



This project analyzes retail sales data using \*\*SQL and SQLite\*\* to identify revenue trends, profitability drivers, customer behavior, product performance, regional differences, discount impact, and shipping performance.



The project demonstrates practical SQL skills including aggregation, grouping, filtering, date analysis, window functions, profitability calculations, and business-oriented analysis.



\## Business Questions



The analysis answers questions such as:



\* What are the overall sales, profit, orders, and average order value?

\* Which categories and sub-categories generate the most profit?

\* Which products are the most and least profitable?

\* Which customers generate the highest and lowest profit?

\* How does discounting affect profitability?

\* Which regions perform best?

\* How does sales performance change month by month?

\* Which months have the highest and lowest sales and profit?

\* Which shipping methods are most commonly used?

\* How long does each shipping method take?



\## Key Findings



\### Overall Performance



\* Total Sales: \*\*$2.33M\*\*

\* Total Profit: \*\*$292.30K\*\*

\* Total Units Sold: \*\*38,654\*\*

\* Total Orders: \*\*5,111\*\*

\* Average Order Value: \*\*$455.20\*\*

\* Overall Profit Margin: \*\*12.56%\*\*



\### Category Performance



| Category        |    Sales |   Profit | Profit Margin |

| --------------- | -------: | -------: | ------------: |

| Technology      | $839,893 | $146,543 |        17.45% |

| Furniture       | $754,748 |  $19,730 |         2.61% |

| Office Supplies | $731,893 | $126,023 |        17.22% |



Technology generates the highest sales and profit, while Furniture has a significantly lower profit margin.



\### Sub-Category Insights



The strongest sub-categories include:



\* \*\*Copiers:\*\* $56.09K profit, 37.21% margin

\* \*\*Phones:\*\* $45.05K profit

\* \*\*Accessories:\*\* $41.94K profit

\* \*\*Paper:\*\* $34.51K profit, 43.39% margin



Major loss-making sub-categories include:



\* \*\*Tables:\*\* -$17.75K profit

\* \*\*Bookcases:\*\* -$3.63K profit

\* \*\*Supplies:\*\* -$1.17K profit



\### Product Performance



The most profitable product was:



\*\*Canon imageCLASS 2200 Advanced Copier\*\*



\* Sales: $61,599.82

\* Profit: $25,199.93

\* Units Sold: 20



The largest product-level loss was:



\*\*Cubify CubeX 3D Printer Double Head Print\*\*



\* Sales: $11,099.96

\* Profit: \*\*-$8,879.97\*\*



\### Customer Insights



The most profitable customer was \*\*Tamara Chand\*\*:



\* Sales: $19,052.22

\* Profit: $8,981.32

\* Orders: 5



The largest customer-level loss was \*\*Cindy Stewart\*\*:



\* Sales: $5,690.06

\* Profit: \*\*-$6,626.39\*\*

\* Orders: 6



This demonstrates that high sales do not necessarily translate into high profitability.



\### Regional Performance



| Region  |    Sales |   Profit | Profit Margin |

| ------- | -------: | -------: | ------------: |

| West    | $739,814 | $110,799 |        14.98% |

| East    | $691,828 |  $94,883 |        13.71% |

| South   | $391,722 |  $46,749 |        11.93% |

| Central | $503,171 |  $39,865 |         7.92% |



The \*\*West\*\* is the strongest region, while \*\*Central\*\* has the lowest profit margin.



\### Discount Impact



The analysis shows a strong relationship between higher discounts and weaker profitability.



| Discount |                  Sales |   Profit | Profit Margin |

| -------: | ---------------------: | -------: | ------------: |

|       0% |                 $1.11M | $326.72K |        29.56% |

|      10% |                $54.95K |   $9.10K |        16.56% |

|      20% |               $773.94K |  $91.08K |        11.77% |

|      30% |               $104.47K | -$10.51K |       -10.06% |

|      40% |               $116.50K | -$23.09K |       -19.82% |

|     50%+ | Significantly negative | Negative |      Negative |



Higher discount levels are associated with substantial declines in profit margin.



\### Monthly Trends



The strongest sales month was:



\*\*November 2026 — $118,454.51\*\*



The weakest sales month was:



\*\*February 2023 — $4,519.89\*\*



The most profitable month was:



\*\*December 2025 — $17,926.30 profit\*\*



The least profitable month was:



\*\*January 2024 — -$3,189.80 profit\*\*



\## SQL Techniques Used



This project uses:



\* `SELECT`

\* `WHERE`

\* `GROUP BY`

\* `ORDER BY`

\* `LIMIT`

\* `COUNT`

\* `COUNT(DISTINCT)`

\* `SUM`

\* `AVG`

\* `ROUND`

\* `CASE`

\* Date functions

\* `julianday()`

\* Common business KPIs

\* Profit margin calculations

\* Window functions such as `LAG()`

\* Month-over-month growth analysis



\## Project Structure



```text

retail-sql-analysis/

│

├── data/

│   ├── retail\_sales.db

│   └── sample\_-\_superstore.xls

│

├── sql/

│   └── 01\_exploration.sql

│

├── README.md

├── run\_sql.py

├── setup\_database.py

└── .gitignore

```



The raw dataset and SQLite database are excluded from Git tracking using `.gitignore`.



\## Tools \& Technologies



\* Python

\* SQLite

\* SQL

\* Pandas

\* Git

\* GitHub

\* VS Code



\## How to Run



\### 1. Clone the repository



```bash

git clone https://github.com/HariCharan1027/retail-sql-analysis.git

cd retail-sql-analysis

```



\### 2. Install dependencies



```bash

pip install pandas xlrd

```



\### 3. Prepare the database



Place the Superstore dataset inside the `data/` directory and run:



```bash

python setup\_database.py

```



\### 4. Run SQL analysis



```bash

python run\_sql.py

```



\## Business Recommendations



Based on the analysis:



1\. Review the pricing and discount strategy for highly discounted products.

2\. Investigate loss-making Furniture sub-categories, particularly Tables.

3\. Review products generating substantial negative profit.

4\. Prioritize high-margin Technology products such as Copiers and Accessories.

5\. Investigate customers generating significant losses despite repeated purchases.

6\. Study the practices of the West region to improve Central-region profitability.

7\. Maintain efficient Standard Class shipping while evaluating the economics of faster shipping options.



\## Conclusion



This project demonstrates how SQL can be used to transform transactional retail data into actionable business insights.



The analysis highlights the importance of looking beyond revenue alone and evaluating \*\*profitability, margins, discounts, customers, products, regions, and operational performance\*\* together.



