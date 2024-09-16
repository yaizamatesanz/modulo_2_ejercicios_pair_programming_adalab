USE northwind;

-- 4. Obtener una lista con los datos de las empleadas y empleados de la empresa Northwind. 
-- En tabla de empleadas identificar first_name, last_name, id_employee

SELECT employee_id, first_name, last_name
FROM employees;


-- 5. Nuestra primera tarea consiste en identificar aquellos productos (tabla products) cuyos precios por unidad oscilen entre 0 y 5 dólares.

SELECT *
FROM products
WHERE unit_price BETWEEN 0 AND 5;

-- 6.Seleccionar aquellos productos que no tengan precio, porque lo hayan dejado vacio al introducir los datos (NULL).
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price IS NULL;

SELECT product_id, product_name, unit_price
FROM products;

-- 7. Obtén los datos de aquellos productos con un precio menor a 15 dólares, pero sólo aquellos que tienen un ID menor que 20.

SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price < 15 AND product_id < 20;

-- 8. Invertir el uso de los operadores del ejercicio anterior;  aquellos que tengan un precio superior a 15 dólares y un ID superior a 20.
SELECT product_id, product_name, unit_price
FROM products
WHERE NOT unit_price < 15 AND NOT product_id < 20;

-- 9. Conocer los datos de los países que hacen pedidos (orders) para focalizar el negocio en esas regiones y al mismo tiempo crear campañas 
-- de marketing para conseguir mejorar en las otras regiones. 

SELECT ship_country, ship_region
FROM orders;

-- 10. Crea una consulta que muestre los primeros 10 productos según su ID y que nos indique el nombre de dichos productos y sus precios.
SELECT product_id, product_name, unit_price
FROM products
LIMIT 10;

-- 11. Ahora realiza la misma consulta pero que nos muestre los últimos 10 productos según su ID de manera descendiente.
SELECT product_id, product_name, unit_price
FROM products
ORDER BY product_id DESC
LIMIT 10;

-- 12. Nos interesa conocer los distintos pedidos que hemos tenido (mostrar los valores únicos de ID en la tabla order_details).
SELECT DISTINCT product_id, order_id
FROM order_details;

-- 13.Conocer los 3 pedidos que han supuesto un mayor ingreso para la empresa. Crea una columna en esta consulta con el alias ImporteTotal.
-- Nota: Utiliza unit_price y quantity para calcular el importe total.

-- Crear columna
-- Debemos o no adicionar la columna?
ALTER TABLE order_details
ADD COLUMN importe_total FLOAT;

ALTER TABLE order_details
DROP COLUMN importe_total;


SELECT order_id, SUM(unit_price * quantity) AS ImporteTotal 
FROM order_details 
GROUP BY order_id 
ORDER BY ImporteTotal DESC LIMIT 3;

-- GROUP BY agrupa filas con valores comunes y se usa para realizar cálculos dentro de esos grupos.
-- ORDER BY organiza los resultados en un orden específico que tú defines.

-- OPCION 2/ mejor opción para guardar la información
ALTER TABLE order_details
ADD COLUMN importe_total FLOAT;
UPDATE order_details
SET importe_total = unit_price * quantity;

SELECT order_id, unit_price, quantity, importe_total AS  ImporteTotal 
FROM order_details;



-- 14. Los pedidos que están entre las posiciones 5 y 10 de nuestro ranking: Nos piden seleccionar el ID de los pedidos situados entre la 5 y la 10 mejor posición en cuanto al coste económico total ImporteTotal.
SELECT order_id , SUM(unit_price * quantity) AS ImporteTotal 
FROM order_details 
GROUP BY order_id 
ORDER BY  ImporteTotal DESC
LIMIT 10
OFFSET 5;

-- 15. Solicita una lista de las categorías que componen los tipos de pedido de la empresa. 
-- Queremos que la lista de resultado sea renombrada como "NombreDeCategoria".
SELECT category_name AS NombreDeCategoria
FROM categories;

-- 16.  Selecciona envios con retraso: Nos hacen llegar desde la dirección la preocupación acerca del cumplimiento de las fechas de envío. Últimamente se están dando retrasos en muchas entregas y por ello se busca realizar la acción preventiva de enviar los paquetes con varios días adicionales de antelacion. Para comenzar a planear esos envíos anticipados, nos piden conocer cuál sería la fecha de envío (ShippedDate) de los pedidos almacenados en la base de datos, si estos sufrieran un retraso de 5 días. Nos piden mostrar la nueva fecha renombrada como FechaRetrasada.
-- 💡 Pista 💡 Para realizar lo anterior, busca documentación de la función DATE_ADD para MySQL.


-- 17. Selecciona los productos más rentables: Gracias a un análisis realizado en los últimos meses en la empresa, se ha comprobado que el rango de productos que puede dar más beneficios parece ser el de aquellos con un precio mayor o igual a 15 dólares, pero menor o igual que 50 dólares. Selecciona los datos de ese rango de productos usando el operador BETWEEN

-- 18. Selecciona los productos con unos precios dados: Queremos conocer los datos de los productos que tengan exactamente un precio de 18, 19 o 20 dólares (un rango muy concreto de precios del que la empresa quiere maximizar sus ventas en un futuro). Usa IN para conseguirlo de manera eficiente.