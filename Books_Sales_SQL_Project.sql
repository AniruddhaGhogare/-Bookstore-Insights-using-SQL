## Bookstore Insights using SQL  Project
Create database Bookstore ;	
Use Bookstore ;

select * from books ;
select * from customers ;


create table orders ( 
order_id serial primary key , 
customer_id int references customers(costomer_id),
book_id int references  books(book_id) ,
order_date date,
quantity int,
total_amount numeric(10,2));
select * from orders ;
select * from books ;
select * from customers ;
                     
-- 1.	Retrieve all books in the "Fiction" genre                     
select * from books where genre = 'Fiction' ;

-- 2.	Find books published after the year 1950 
select * from books where published_year > 1950 ;

-- 3.	List all customers from Canada
select * from customers where country =  'canada';

-- 4.	Show orders placed in November 2023
select * from orders where order_date like '2023-11-%'
order by order_date  ;

-- 5.	Retrieve the total stock of books available
select sum(stock) as total_stock  from books ;

-- 6.	Find the details of the most expensive book
select *  from books 
order by price desc limit 1 ;

-- 7.	Show all customers who ordered more than 1 quantity of a book
select * from orders where
quantity > 1 
order by quantity asc; 

-- 8.	Retrieve all orders where the total amount exceeds $20
select * from orders where
total_amount >= 20 ;

-- 9.	List all genres available in the Books table
select genre ,count(title) from books 
group by genre ; 

-- 10.	Find the book with the lowest stock
select * from books 
order by stock desc limit 1 ;

-- 11.	Calculate the total revenue generated from all orders
select sum(total_amount) as revenue  from  orders ;

# Adv
-- 1.	Retrieve the total number of books sold for each genre
select round(sum(orders.quantity*books.price),2) as revenue  from  orders join books 
on orders.book_id = books.book_id ;

## Advanced 
--  1.	Retrieve the total number of books sold for each genre
select genre , round(sum(price)) as total_numb from books
group by genre ;

--  2.	Find the average price of books in the "Fantasy" genre
select round(avg(price),2) from books where genre = "fantasy";

-- 3.List customers who have placed at least 2 orders
select c.Name,c.customer_id , count(o.order_id) as order_count
from orders o join customers c
on o.Customer_ID = c.Customer_ID
group by o.customer_id , c.Name
having order_count >=2 ;

-- 4.Find the most frequently ordered book
select b.Title, o.book_id , count(o.Book_ID) as most_order_books 
from orders o join books b 
on o.book_id = b.book_id
group by b.title ,o.book_id
order by most_order_books desc , Book_ID desc 
limit 7 ;
  

-- 5.	Show the top 3 most expensive books of the "Fantasy" genre
select *  from books
where genre = 'fantasy'
order by price desc
 limit 3;
 
 -- 6.Retrieve the total quantity of books sold by each author
select b.Author , sum(o.quantity)
from books b join orders o 
on b.Book_ID = o.order_id
group by b.Author  ;

-- 7.List the cities where customers who spent over $30 are located
select  c.name,  c.city , o.total_amount 
from customers c right join orders o
on c.Customer_ID = o.order_id
where o.total_amount > 30 ;

-- 8.	Find the customer who spent the most on orders 
select c.Customer_ID ,c.name , sum(o.total_amount) as HighSpent
from customers c join orders o 
on c.Customer_ID =o.customer_id
group by c.name ,c.Customer_ID 
order by HighSpent desc 
limit 1;

-- 9.	Calculate the stock remaining after fulfilling all orders
select b.Book_ID, b.title, b.Stock,
coalesce(sum(o.quantity),0) as total_order ,
(b.Stock - coalesce(sum(o.quantity),0)) as remain_order 
from books b left join orders o 
on b.Book_ID = o.Book_ID 
group by b.book_id ,b.Title,b.Stock
order by b.Book_ID ; 

select b.book_id, 
b.title,
b.Stock , 
coalesce(sum(o.quantity),0) ,
(b.stock - coalesce(sum(o.quantity),0)) as remaining_stock 
from books b  left join orders o 
on b.Book_ID = o.Book_ID
group by b.Book_ID ,b.Title,b.Stock
order by b.Book_ID ; 

select * from orders ;
select * from books ;
select * from customers ;