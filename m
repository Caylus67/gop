import sqlite3
import pandas as pd

conn = sqlite3.connect(":memory:")
cur = conn.cursor()

cur.execute("CREATE TABLE experiments(id INTEGER PRIMARY KEY, name TEXT, duration INTEGER)")
cur.execute("CREATE TABLE materials(id INTEGER PRIMARY KEY, exp_id INTEGER, material TEXT)")

cur.executemany("INSERT INTO experiments VALUES(?,?,?)", [(1,"Volcano",30),(2,"Plant Growth",90),(3,"Magnetism",15)])
cur.executemany("INSERT INTO materials VALUES(?,?,?)", [(1,1,"Baking Soda"),(2,1,"Vinegar"),(3,2,"Soil")])

df = pd.read_sql_query("SELECT * FROM experiments WHERE duration = (SELECT MIN(duration) FROM experiments)", conn)
print(df)
