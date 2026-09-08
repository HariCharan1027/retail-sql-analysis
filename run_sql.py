import os
import sqlite3
import pandas as pd

DATABASE_FILE = "data/retail_sales.db"
SQL_FILE = "sql/01_exploration.sql"


print("=" * 70)
print("RETAIL SALES SQL ANALYSIS")
print("=" * 70)


# ============================================================
# CHECK FILES
# ============================================================

if not os.path.exists(DATABASE_FILE):
    print(f"\nERROR: Database not found: {DATABASE_FILE}")
    print("Run setup_database.py first.")
    raise SystemExit(1)

if not os.path.exists(SQL_FILE):
    print(f"\nERROR: SQL file not found: {SQL_FILE}")
    raise SystemExit(1)


# ============================================================
# READ SQL FILE
# ============================================================

with open(SQL_FILE, "r", encoding="utf-8") as file:
    sql_content = file.read()


# ============================================================
# SPLIT SQL QUERIES
# ============================================================

queries = []

for query in sql_content.split(";"):
    cleaned_query = query.strip()

    if cleaned_query:
        queries.append(cleaned_query)


print(f"\nSQL queries found: {len(queries)}")


# ============================================================
# CONNECT DATABASE
# ============================================================

connection = sqlite3.connect(DATABASE_FILE)


# ============================================================
# EXECUTE QUERIES
# ============================================================

for number, query in enumerate(queries, start=1):

    print("\n" + "=" * 70)
    print(f"QUERY {number}")
    print("=" * 70)

    try:

        result = pd.read_sql_query(
            query,
            connection
        )

        print(result.to_string(index=False))

    except Exception as e:

        print("\nERROR:")
        print(e)

        connection.close()
        raise SystemExit(1)


# ============================================================
# CLOSE DATABASE
# ============================================================

connection.close()


print("\n" + "=" * 70)
print("ALL SQL QUERIES EXECUTED SUCCESSFULLY")
print("=" * 70)