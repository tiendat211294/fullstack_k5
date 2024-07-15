-- Xem danh sách đơn hàng
SELECT customers.name,customers.email,customers.phone_number,customers_products.status,customers_products.created_at,
COUNT(customers_products.id) AS product_count,
SUM(products.price) AS product_price
FROM customers
LEFT JOIN customers_products
ON customers_products.customer_id=customers.id
LEFT JOIN products
ON products.id=customers_products.product_id
GROUP BY customers.name,customers.email,customers.phone_number,customers_products.status,customers_products.created_at

-- Xem chi tiết đơn hàng
SELECT customers.name,customers.email,customers.phone_number,products.name,products.code,products.price,
customers_products.status,customers_products.created_at,customers_products.updated_at,
COUNT(customers_products.id) AS product_count
FROM customers
LEFT JOIN customers_products
ON customers_products.customer_id=customers.id
LEFT JOIN products
ON products.id=customers_products.product_id
WHERE customers.name='Nguyễn Văn A'
GROUP BY customers.name,customers.email,customers.phone_number,customers_products.status,
customers_products.created_at,products.name,products.code,products.price,customers_products.updated_at