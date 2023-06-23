DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  Order_id INT PRIMARY KEY,
  customer_id VARCHAR(10) NOT NULL,
  purchaseDate date NOT NULL,
  movie_Id VARCHAR(10) NOT NULL,
  minutesStreamed FLOAT NOT NULL
);
INSERT INTO 
orders (Order_id, customer_id, purchaseDate, movie_Id, minutesStreamed) VALUES
(1,'C1','1/1/00','P1',100),
(2,'C2','1/1/02','P2',90),
(3,'C3','4/1/02','P3',93),
(4,'C4','4/1/03','P1',99),
(5,'C4','1/1/06','P2',99),
(6,'C1','5/1/06','P5',89),
(7,'C4','12/1/17','P5',89),
(8,'C3','3/3/18','P1',145),
(9,'C4','3/3/18','P6',147);