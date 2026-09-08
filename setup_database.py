import os
import pandas as pd
import sqlite3

# ============================================================
# CONFIGURATION
# ============================================================

DATA_FILE = "data/sample_-_superstore.xls"
DATABASE_FILE = "data/retail_sales.db"
TABLE_NAME = "sales"

REQUIRED_COLUMNS = [
    "Row ID",
    "Order ID",
    "Order Date",
    "Ship Date",
    "Ship Mode",
    "Customer ID",
    "Customer Name",
    "Segment",
    "Country/Region",
    "City",
    "State/Province",
    "Postal Code",
    "Region",
    "Product ID",
    "Category",
    "Sub-Category",
    "Product Name",
    "Sales",
    "Quantity",
    "Discount",
    "Profit"
]

# ============================================================
# HEADER
# ============================================================

print("=" * 60)
print("RETAIL SALES DATABASE SETUP")
print("=" * 60)

# ============================================================
# CHECK DATA FILE
# ============================================================

if not os.path.exists(DATA_FILE):
    print(f"\nERROR: Dataset not found:")
    print(DATA_FILE)
    raise SystemExit(1)

# ============================================================
# LOAD DATA
# ============================================================

print("\nLoading dataset...")

try:
    df = pd.read_excel(DATA_FILE)
except Exception as e:
    print(f"\nERROR while reading Excel file:")
    print(e)
    raise SystemExit(1)

print(f"Rows loaded: {len(df):,}")
print(f"Columns loaded: {len(df.columns)}")

# ============================================================
# CHECK REQUIRED COLUMNS
# ============================================================

print("\nChecking required columns...")

missing_columns = [
    column for column in REQUIRED_COLUMNS
    if column not in df.columns
]

if missing_columns:
    print("\nERROR: Required columns are missing:")

    for column in missing_columns:
        print(f" - {column}")

    print("\nActual columns in dataset:")
    for column in df.columns:
        print(f" - {column}")

    raise SystemExit(1)

print("All required columns are present.")

# ============================================================
# DATA CLEANING
# ============================================================

print("\nCleaning data...")

# Convert dates
df["Order Date"] = pd.to_datetime(
    df["Order Date"],
    errors="coerce"
)

df["Ship Date"] = pd.to_datetime(
    df["Ship Date"],
    errors="coerce"
)

# Convert numeric columns
numeric_columns = [
    "Row ID",
    "Postal Code",
    "Sales",
    "Quantity",
    "Discount",
    "Profit"
]

for column in numeric_columns:
    df[column] = pd.to_numeric(
        df[column],
        errors="coerce"
    )

# ============================================================
# DATA QUALITY CHECKS
# ============================================================

print("\nData quality checks:")

print(f"Missing Order Dates: {df['Order Date'].isna().sum():,}")
print(f"Missing Ship Dates: {df['Ship Date'].isna().sum():,}")
print(f"Missing Customer IDs: {df['Customer ID'].isna().sum():,}")
print(f"Missing Product Names: {df['Product Name'].isna().sum():,}")
print(f"Negative Quantity: {(df['Quantity'] < 0).sum():,}")
print(f"Zero/Negative Sales: {(df['Sales'] <= 0).sum():,}")

# ============================================================
# DATE RANGE
# ============================================================

valid_dates = df["Order Date"].dropna()

if not valid_dates.empty:
    print("\nOrder date range:")
    print(
        f"First Order: {valid_dates.min().strftime('%Y-%m-%d')}"
    )
    print(
        f"Last Order:  {valid_dates.max().strftime('%Y-%m-%d')}"
    )

# ============================================================
# CREATE DATABASE DIRECTORY
# ============================================================

os.makedirs(
    os.path.dirname(DATABASE_FILE),
    exist_ok=True
)

# Remove old database so it is rebuilt cleanly
if os.path.exists(DATABASE_FILE):
    os.remove(DATABASE_FILE)
    print("\nExisting database removed.")

# ============================================================
# CREATE SQLITE DATABASE
# ============================================================

print("\nCreating SQLite database...")

connection = sqlite3.connect(DATABASE_FILE)

try:
    df.to_sql(
        TABLE_NAME,
        connection,
        if_exists="replace",
        index=False
    )

    # Verify database
    result = pd.read_sql_query(
        f"SELECT COUNT(*) AS total_rows FROM {TABLE_NAME}",
        connection
    )

    total_rows = result.iloc[0]["total_rows"]

finally:
    connection.close()

# ============================================================
# FINAL RESULT
# ============================================================

print("\n" + "=" * 60)
print("DATABASE SETUP COMPLETED SUCCESSFULLY")
print("=" * 60)

print(f"Database: {DATABASE_FILE}")
print(f"Table: {TABLE_NAME}")
print(f"Rows in database: {total_rows:,}")
print(f"Columns: {len(df.columns)}")

print("=" * 60)