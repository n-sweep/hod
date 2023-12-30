WITH do AS (
    SELECT DISTINCT
        customerid,
        orderid,
        ordered,
        strftime('%Y', ordered) AS year
    FROM orders
),
jp17 AS (
    SELECT
        c.customerid,
        name,
        phone,
        orderid,
        ordered,
        citystatezip
    FROM customers c
    LEFT JOIN do
        ON c.customerid = do.customerid
    WHERE year = '2017'
        AND name LIKE 'J% P%'
),
prod AS (
    SELECT
        orderid,
        i.sku,
        desc
    FROM
        orders_items i
    LEFT JOIN
        products p
    ON
        i.sku = p.sku
    WHERE
        desc LIKE "%bagel%"
        OR desc LIKE "%coffee%"
)

SELECT DISTINCT
    *
FROM
    jp17 j
INNER JOIN
    prod p
ON
    j.orderid = p.orderid
