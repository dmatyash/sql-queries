# Тестирования БД интернет-магазина
---
В процессе тестирования интернет-магазина выполнила sql-запросы для проверки целостности данных, корректности выборок и работы с несколькими таблицами.

### Пример запросов

 1. Фильтрация товаров
 Проверка: фильтрация по производителю и категории

 SELECT * FROM products WHERE manufacturer = 'Apple' AND category = 'Phones'


 2. Агрегатные функции
 Проверка: суммарная стоимость товаров Samsung

 SELECT SUM(price) AS 'SAMSUNG TOTAL PRICE' FROM products WHERE manufacturer = 'Samsung'

 3. JOIN
 Проверка: Все пользователи и их заказы

  SELECT users.login, orders.order_id FROM users LEFT JOIN orders ON users.user_id = orders.user_id

 4. Подзапросы
 Проверка: товары дороже Samsung Active 5

 SELECT name, price FROM products WHERE price > (SELECT price FROM products WHERE name = 'Samsung Active 5')

 5. UNION
 Проверка: объединение названий товаров и номеров заказов

 SELECT name FROM products UNION SELECT order_id FROM orders

 6. CASE
 Проверка: классификация товаров по брендам

 SELECT name, CASE WHEN manufacturer = 'Apple' THEN 'Это продукт Apple' WHEN manufacturer = 'Samsung' THEN 'Это продукт Samsung' ELSE 'Другой бренд' END FROM products

 [Полный список запросов](sql-queries.sql)
