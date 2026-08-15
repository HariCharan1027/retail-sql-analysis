import pandas as pd
import sqlite3

# File paths
excel_file = "data/sample_-_superstore.xls"
database_file = "data/retail_sales.db"

# Read Excel file
df = pd.read_excel(excel_file)

# Connect to SQLite
conn = sqlite3.connect(database_file)

# Save data as a SQL table
df.to_sql("sales", conn, if_exists="replace", index=False)

# Close connection
conn.close()

print("Database created successfully!")
print(f"Rows loaded: {len(df)}")
print(f"Columns loaded: {len(df.columns)}")