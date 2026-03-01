-- ======================================================
-- SQL-запросы для тестирования базы данных интернет-магазина
-- ======================================================

-- 1. Базовые выборки
-- ------------------------------------------------------

-- Все продукты
SELECT * FROM products;

-- Товары Apple в категории Phones
SELECT * FROM products WHERE manufacturer = 'Apple' AND category = 'Phones';

-- Поиск товаров по части названия
SELECT name, price FROM products WHERE name LIKE '%sa%';

-- Товары в ценовом диапазоне
SELECT name, price FROM products WHERE price BETWEEN 100 AND 1000;

-- 2. Агрегатные функции
-- ------------------------------------------------------

-- Суммарная стоимость товаров Samsung
SELECT SUM(price) AS 'SAMSUNG TOTAL PRICE' FROM products WHERE manufacturer = 'Samsung';

-- Средняя цена всех товаров
SELECT AVG(price) AS 'PRODUCTS AVG PRICE' FROM products;

-- Количество товаров в категориях (больше 15)
SELECT category, COUNT(*) as product_count 
FROM products 
GROUP BY category 
HAVING COUNT(*) > 15;

-- 3. Сортировка и уникальные значения
-- ------------------------------------------------------

-- Сортировка по убыванию цены
SELECT name, price FROM products ORDER BY price DESC;

-- Все производители (без повторов)
SELECT DISTINCT manufacturer FROM products;

-- Первые две уникальные категории
SELECT DISTINCT category FROM products LIMIT 2;

-- Товары из 12 символов, начинающиеся на A
SELECT name FROM products WHERE name LIKE '____________' AND name LIKE 'A%';

-- 4. JOIN-запросы 
-- ------------------------------------------------------

-- Заказы конкретного пользователя
SELECT users.login, orders.order_id, orders.total
FROM users 
RIGHT JOIN orders ON users.user_id = orders.user_id
WHERE users.login = 'test_dm1W';

-- Все пользователи и их заказы 
SELECT users.login, orders.order_id
FROM users 
LEFT JOIN orders ON users.user_id = orders.user_id;

-- Товары в заказах
SELECT order_items.order_id, products.name, order_items.quantity
FROM order_items  
LEFT JOIN products ON order_items.product_id = products.product_id;

-- Оплаченные заказы и все товары
SELECT order_items_paid.id, products.name
FROM order_items_paid  
RIGHT JOIN products ON order_items_paid.product_id = products.product_id;

-- 5. Продвинутые конструкции
-- ------------------------------------------------------

-- UNION: товары и номера заказов
SELECT name FROM products
UNION
SELECT order_id FROM orders;

-- Оператор IN
SELECT name, description 
FROM products
WHERE manufacturer IN ('Huawei', 'Samsung');

-- CASE: классификация по производителям
SELECT 
    name, 
    category, 
    price,
    CASE
        WHEN manufacturer = 'Apple' THEN 'Это продукт компании Apple'
        WHEN manufacturer = 'Samsung' THEN 'Это продукт компании Samsung'
        WHEN manufacturer = 'Huawei' THEN 'Это продукт компании Huawei'
        WHEN manufacturer = 'Xiaomi' THEN 'Это продукт компании Xiaomi'
    END AS manufacturer_message
FROM products;

-- Подзапрос: товары дороже Samsung Active 5
SELECT name, price 
FROM products
WHERE price > (
    SELECT price 
    FROM products 
    WHERE name = 'Samsung Active 5'
);