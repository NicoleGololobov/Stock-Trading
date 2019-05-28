import pymysql

# Open connection to the database
db = pymysql.connect("localhost","root","","firm")

# Start a cursor object using cursor() method
cursor = db.cursor()

# Find tickers whose closing price is both higher than IBM on 3/20/2019
# and no higher than GOOG on 3/20/2019
Q1 = """SELECT P.ticker FROM Price P \
WHERE P.close > (SELECT P.close FROM Price P WHERE P.ticker = "IBM" AND dat = "3/20/2019") \
AND P.close <= (SELECT P.close FROM Price P WHERE P.ticker = "GOOG" AND dat = "3/20/2019");"""

# Find the tickers of all stocks that closed at the highest price on 3/20/2019
Q2 = """SELECT DISTINCT P.ticker FROM Price P WHERE P.close = (\
SELECT MAX(P.close) FROM Price P WHERE P.dat = "3/20/2019") AND P.dat = "3/20/2019";"""

# Find tickers of stocks in NYSE whose closing price on 3/20/2019 was either below 20 or above 100.
Q3 = """SELECT P.ticker FROM Price P \
WHERE P.ticker IN (SELECT S.ticker FROM Stock S WHERE S.market="NYSE") \
AND P.dat = "3/20/2019" AND (P.close<20 OR P.close>100);"""

# Find tickers in NYSE of stocks whose closing price had highest increase between 3/20/2019 and 3/21/2019
# and whose closing price was above $100 for the entire 2019
Q4 = """SELECT P1.ticker, P2.close-P1.close FROM Price P1 JOIN Price P2 ON \
P1.ticker=P2.ticker AND P1.dat="3/20/2019" AND P2.dat="3/21/2019" \
JOIN Stock S ON P1.ticker=S.ticker WHERE S.market="NYSE" AND \
P1.ticker NOT IN (SELECT P1.ticker FROM Price P1 WHERE P1.close<=100 GROUP BY P1.ticker) \
ORDER BY P2.close-P1.close DESC limit 1;"""

# Find dates where total price (price*numofshares) of AAPL firm sold was higher than what firm bought in NASDAQ
Q5 = """SELECT B1.dat FROM Buynsell B1, Buynsell B2 \
WHERE B1.dat=B2.dat AND B1.buy_or_sell="SELL" AND B2.buy_or_sell="BUY" \
AND B1.ticker="AAPL" AND B2.ticker IN (SELECT S.ticker FROM Stock S WHERE S.market="NASDAQ") \
GROUP BY B1.dat \
HAVING (B1.price*B1.num_of_shares) > SUM(B2.price*B2.num_of_shares);"""   

# Execute SQL query
cursor.execute(Q1)

# Fetch all the rows using fetchall() method
data = cursor.fetchall()
print(data)

# disconnect from server
db.close()



