CREATE DATABASE firm;	/* database for a stock trading firm */
USE firm;

CREATE TABLE Stock (				/* table for each company's stock */
	ticker         VARCHAR(150) NOT NULL,   /* stock ticker, ex. GOOG for Google */            
	market         VARCHAR(150) NOT NULL,   /* stock exchange, ex. NYSE for New York Stock Exchange */          
	PRIMARY KEY  (ticker)			/* ticker is the unique, identifying attribute of each record */
);

INSERT INTO Stock (ticker, market) VALUES
('AAPL', 'NASDAQ'),
('GOOG', 'NASDAQ'),
('MSFT', 'NASDAQ'),
('IBM', 'NYSE');

CREATE TABLE Price (					/* table for each stock's price on each date */
	ticker         VARCHAR(150) NOT NULL,        
	dat            VARCHAR(150) NOT NULL,           /* date in MM-DD-YYYY form */  
	close          FLOAT(10,2)  NOT NULL,           /* closing price, 2 decimal places max, ex: 10.99 */
    FOREIGN KEY (ticker) REFERENCES Stock(ticker)	/* ticker in Price references ticker in Stock */
);
INSERT INTO Price (ticker, dat, close) VALUES
('AAPL', '3/20/2019', 100),
('AAPL', '3/21/2019', 101.5),
('AAPL', '3/22/2019', 106.5),
('GOOG', '3/20/2019', 100),
('GOOG', '3/21/2019', 130),
('GOOG', '3/22/2019', 110),
('MSFT', '3/20/2019', 184.5),
('MSFT', '3/21/2019', 188.5),
('MSFT', '3/22/2019', 210),
('IBM', '3/20/2019', 72),
('IBM', '3/21/2019', 70),
('IBM', '3/22/2019', 10);

CREATE TABLE Buynsell (				    /* table for each stock the firm bought or sold on each date */
	ticker         VARCHAR(150) NOT NULL,
	buy_or_sell    VARCHAR(5) NOT NULL,         /* attribute must be either "buy" or "sell" */ 
	dat            VARCHAR(150) NOT NULL, 	    /* date in MM-DD-YYYY form */
	timstamp       TIME NOT NULL,               /* timestamp in hh-mm-ss form */
	price          FLOAT(10,2)  NOT NULL,	    /* price per stock */
	num_of_shares  INT unsigned NOT NULL,	    /* total number of shares in transaction */
    FOREIGN KEY (ticker) REFERENCES Price(ticker)   /* ticker in Buynsell references ticker in Price */
);
INSERT INTO Buynsell (ticker, buy_or_sell, dat, timstamp, price, num_of_shares) VALUES
('IBM', 'BUY', '3/20/2019', '11:55:00', 273, 1100),
('IBM', 'BUY', '3/21/2019', '10:45:00', 271, 2400),
('IBM', 'SELL', '3/22/2019', '12:09:00', 270.5, 2500),
('GOOG', 'BUY', '3/20/2019', '12:22:00', 86, 2200),
('GOOG', 'SELL', '3/20/2019', '14:00:00', 87, 1000),
('GOOG', 'SELL', '3/21/2019', '10:22:00', 87.5, 1000),
('GOOG', 'BUY', '3/21/2019', '13:28:00', 87, 800),
('GOOG', 'SELL', '3/22/2019', '11:45:00', 86, 500),
('AAPL', 'BUY', '3/20/2019', '10:01:00', 99, 1000),
('AAPL', 'BUY', '3/20/2019', '11:22:00', 99.5, 1000),
('AAPL', 'BUY', '3/21/2019', '14:22:00', 100, 1000),
('AAPL', 'SELL', '3/22/2019', '14:42:00', 103, 3000),
('MSFT', 'BUY', '3/20/2019', '11:45:00', 186, 1500),
('MSFT', 'SELL', '3/21/2019', '10:45:00', 188, 1000),
('MSFT', 'BUY', '3/22/2019', '12:03:00', 187, 5000);






