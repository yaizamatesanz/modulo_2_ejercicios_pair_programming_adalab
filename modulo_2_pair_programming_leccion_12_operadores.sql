/*1. Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla 
con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre 
de contacto.*/

USE northwind;

SELECT city AS City, company_name AS CompanyName, contact_name AS ContactName
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%';

/*2. Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query 
anterior el número de total de pedidos que han hecho todas las ciudades que 
empiezan por "L".*/

SELECT 
	customers.city AS ciudad,
	customers.company_name AS empresa,
	customers.contact_name AS persona_de_contacto,
COUNT(orders.order_id) AS numero_pedidos
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE city LIKE 'L%'
GROUP BY city, company_name, contact_name;

/*otra opción*/

SELECT 
	customers.city AS ciudad,
	customers.company_name AS empresa,
	customers.contact_name AS persona_de_contacto,
COUNT(orders.order_id) AS numero_pedidos
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE customers.city IN (
    SELECT DISTINCT city
    FROM customers
    WHERE city LIKE 'L%'
)
GROUP BY city, company_name, contact_name;

/*otra opción*/

SELECT 
	city AS ciudad,
	company_name AS empresa,
    contact_name AS persona_de_contacto,
    COUNT(order_id) AS numero_pedidos
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
WHERE city LIKE 'L%'
GROUP BY city, company_name, contact_name;

/*3. Todos los clientes cuyo "country" no incluya "USA".
Nuestro objetivo es extraer los clientes que no sean de USA.
Extraer el nombre de contacto, su pais y el nombre de la compañia.*/

SELECT contact_name, country, company_name
FROM customers
WHERE country NOT LIKE 'USA';

/*otra opción*/

SELECT contact_name, country, company_name
FROM customers
WHERE country NOT IN ('USA');

/*otra opción*/

SELECT contact_name, country, company_name
FROM customers
WHERE country NOT REGEXP '^USA$';

/*4. Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_A%';

/*otra opción*/

SELECT DISTINCT contact_name
FROM customers
WHERE contact_name NOT LIKE '_A%';

/*otra opción*/

SELECT contact_name
FROM customers
WHERE LEFT(contact_name, 2) NOT LIKE '_A';