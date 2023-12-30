with early_deli as (
    SELECT *
    FROM orders o
    LEFT JOIN orders_items i
    ON o.orderid = i.orderid
    WHERE sku LIKE 'DLI%'
        AND CAST(STRFTIME('%H', shipped) AS INT) = 4
),
cust AS (
    SELECT DISTINCT
        name,
        address,
        citystatezip,
        phone,
        orderid,
        ordered,
        shipped,
        sku
    FROM
        customers c
    RIGHT JOIN
        early_deli e
    ON
        c.customerid = e.customerid
)

SELECT
    name,
    address,
    citystatezip,
    phone,
    orderid,
    desc,
    ordered,
    shipped
FROM cust c
LEFT JOIN products p
ON c.sku = p.sku
WHERE
    desc NOT LIKE '%sandwich%'
    AND desc NOT LIKE '%salad%'
    AND desc NOT LIKE '%soup%'
    AND desc NOT LIKE '%meatball%'
    AND desc NOT LIKE '%broccoli%'
