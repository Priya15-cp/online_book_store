CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    genre VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT,
    publisher VARCHAR(255),
    published_year INT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    country VARCHAR(100),
    city VARCHAR(100),
    signup_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(50),

    -- Foreign Keys
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

SELECT * FROM BOOKs;
SELECT * FROM customers;
SELECT * FROM orders;

SELECT *FROM  BOOKs 
WHERE PRICE >1000;

SELECT * FROM customers
WHERE Country = 'Nepal';

SELECT * FROM orders 
WHERE status = 'Pending';

SELECT * FROM BOOKS
WHERE published_year > 2010;

SELECT * FROM CUSTOMERs
WHERE signup_date > '2020-12-31';

SELECT * FROM orders
WHERE quantity > 3;

SELECT * FROM BOOKS 
WHERE genre = 'Fiction';

SELECT * FROM CUSTOMERS
WHERE city = 'Kathmandu';

SELECT * FROM BOOKS
WHERE quantity = 0;

SELECT * FROM ORDERs
 WHERE EXTRACT(year from cast(order_date AS DATE)) = '2022' ;

 SELECT o.order_id, c.customer_name, b.book_name
 FROM orders o
 JOIN customers c on o.customer_id = c.customer_id
 JOIN books b on o.book_id = b.book_id;

 SELECT o.order_id, o.quantity, b.author, b.book_name,o.order_date,o.status
 FROM Orders o
 JOIn books b on o.book_id = b.book_id
 WHERE o.status = 'Delivered';

SELECT c.customer_id, c.customer_name, b.book_name, b.genre
FROM orders o
join customers c on o.customer_id = c.customer_id
JOin books b on o.book_id = b.book_id
WHERE genre = 'Romance';

SELECT sum(price) as total_reveneu from orders;

SELECT sum(quantity) as total_sold from orders;

select o.book_id, b.book_name, sum(o.quantity) as total_sold 
from orders o
Join books b on o.book_id = b.book_id
GRoup by o.book_id , b.book_id
order by total_sold desc
limit 10;

select cast(order_date as date) as order_date,
       sum(price) as daily_revenue,
	   sum(sum(price)) over (order by cast(order_date as date))
	   as running_total_reveneu
	from orders
	group by cast(order_date as date)
	order by order_date;

SELECT *FROM BOOKs
where quantity < (select(avg(quantity)) from books);

SELECT * from orders
WHERE price = (SELECT(max(price))FROM ORDERs);