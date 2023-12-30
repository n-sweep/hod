WITH pastries AS (
    SELECT sku, desc
    FROM products
    WHERE sku LIKE 'DLI%'
        -- AND desc NOT LIKE '%soup%'
        -- AND desc NOT LIKE '%salad%'
        -- AND desc NOT LIKE '%sandwich%'
        -- AND desc NOT LIKE '%meatball%'
),
pastry_orders AS (
    SELECT i.orderid, i.sku, desc
    FROM orders_items i
    RIGHT JOIN pastries p
    ON i.sku = p.sku
),
early_orders AS (
    SELECT orderid, customerid, ordered, shipped
    FROM orders
    WHERE CAST(STRFTIME('%H', shipped) AS INT) = 4

        -- "... a few weeks later ..."
        -- 2017-04-05 11:42:15
        AND STRFTIME('%Y', shipped) = '2017'
        AND CAST(STRFTIME('%m', shipped) AS INT) > 3
),
early_pastries AS (
    SELECT e.orderid, customerid, sku, desc, ordered, shipped
    FROM early_orders e
    INNER JOIN pastry_orders p
    ON e.orderid = p.orderid
)

SELECT
    c.customerid,
    name,
    address,
    citystatezip,
    phone,
    orderid,
    ordered,
    shipped,
    sku,
    desc
FROM
    customers c
RIGHT JOIN
    early_pastries p
ON
    c.customerid = p.customerid
ORDER BY STRFTIME('%H:%M:%s', shipped)
