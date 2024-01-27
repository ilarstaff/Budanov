CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);
INSERT INTO users (username, email) VALUES
  INSERT INTO users (username, email) VALUES
    ('user1', 'user1@example.com'),
    ('user2', 'user2@example.com'),
    ('user3', 'user3@example.com'),
    ('user4', 'user4@example.com'),
    ('user5', 'user5@example.com'),
    ('user6', 'user6@example.com'),
    ('user7', 'user7@example.com'),
    ('user8', 'user8@example.com'),
    ('user9', 'user9@example.com'),
    ('user10', 'user10@example.com'),
    ('user11', 'user11@example.com'),
    ('user12', 'user12@example.com'),
    ('user13', 'user13@example.com'),
    ('user14', 'user14@example.com'),
    ('user15', 'user15@example.com'),
    ('user16', 'user16@example.com'),
    ('user17', 'user17@example.com'),
    ('user18', 'user18@example.com'),
    ('user19', 'user19@example.com'),
    ('user20', 'user20@example.com');

20 різноманітних SQL-запитів для роботи з базою даних, яка містить таблицю "users":

Вибірка всіх користувачів:
SELECT * FROM users;

Фільтрація за умовою (всі користувачі з електронною поштою gmail.com):
SELECT * FROM users WHERE email LIKE '%@gmail.com';


З'єднання двох полів таблиці (користувачі та їхні замовлення):
SELECT users.*, orders.order_id FROM users
INNER JOIN orders ON users.id = orders.user_id;

Групування користувачів за їхнім ім'ям:
SELECT username, COUNT(*) as user_count FROM users GROUP BY username;

Вивід загальної кількості користувачів:
SELECT COUNT(*) as total_users FROM users;

Середній вік користувачів (якщо є поле з датою народження):
SELECT AVG(age) as average_age FROM users;

Сортування користувачів за ім'ям в алфавітному порядку:
SELECT * FROM users ORDER BY username;

Вивід унікальних користувачів за ім'ям:
SELECT DISTINCT username FROM users;

Кількість користувачів, які мають електронну пошту:
SELECT COUNT(*) as email_users FROM users WHERE email IS NOT NULL;

Замовлення користувачів за кількістю замовлень:
SELECT users.username, COUNT(orders.order_id) as order_count
FROM users LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.username
ORDER BY order_count DESC;


Середня кількість замовлень на одного користувача:
SELECT users.username, AVG(order_count) as avg_orders
FROM users
LEFT JOIN (
    SELECT user_id, COUNT(order_id) as order_count
    FROM orders
    GROUP BY user_id
) AS user_orders ON users.id = user_orders.user_id
GROUP BY users.username;

Останні 5 замовлень:
SELECT * FROM orders ORDER BY order_id DESC LIMIT 5;


Користувачі та їхні замовлення за певний період часу:
SELECT users.username, orders.order_id, orders.order_date
FROM users
INNER JOIN orders ON users.id = orders.user_id
WHERE orders.order_date BETWEEN '2022-01-01' AND '2022-12-31';

Кількість користувачів в кожному місті:
SELECT city, COUNT(*) as user_count FROM users GROUP BY city;

Замовлення та їхні продукти:
SELECT orders.order_id, products.product_name, order_details.quantity
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;

Замовлення, сума яких перевищує певну суму:
SELECT orders.order_id, SUM(products.price * order_details.quantity) as total_amount
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY orders.order_id
HAVING total_amount > 100;

Замовлення та їхні користувачі (використання підзапиту):
SELECT users.username, orders.order_id
FROM users
INNER JOIN orders ON users.id = orders.user_id
WHERE orders.order_id IN (SELECT order_id FROM order_details WHERE quantity > 5);

Сума всіх замовлень для кожного користувача:
SELECT users.username, SUM(products.price * order_details.quantity) as total_amount
FROM users
INNER JOIN orders ON users.id = orders.user_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY users.username;


Середня кількість замовлень на одного користувача за місяць:
SELECT users.username, AVG(order_count) as avg_orders_per_month
FROM users
LEFT JOIN (
    SELECT user_id, COUNT(order_id) as order_count
    FROM orders
    WHERE EXTRACT(MONTH FROM order_date) = 1  -- Январь (змініть за потребою)
    GROUP BY user_id
) AS user_orders ON users.id = user_orders.user_id
GROUP BY users.username;


Виведення топ-3 користувачів за сумою їхніх замовлень:
SELECT users.username, SUM(products.price * order_details.quantity) as total_amount
FROM users
INNER JOIN orders ON users.id = orders.user_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY users.username
ORDER BY total_amount DESC
LIMIT 3;