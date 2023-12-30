WITH bdbd AS (
    SELECT
        customerid,
        STRFTIME("%Y", birthdate) AS year,
        STRFTIME("%m", birthdate) AS month,
        STRFTIME("%d", birthdate) AS day
    FROM
        customers
),
cancer_rabbit AS (
    SELECT customerid
    FROM bdbd
    WHERE
        -- rabbit
        year IN ("1903", "1915", "1927", "1939", "1951", "1963", "1975", "1987", "1999")
        -- cancer
        AND (
            (month = '06' AND CAST(day AS INT) > 21)
            OR (month = '07' AND CAST(day AS INT) < 23)
        )
)

SELECT *
FROM customers c
RIGHT JOIN cancer_rabbit r
ON c.customerid = r.customerid
-- contractor's neighborhood
WHERE citystatezip = "Jamaica, NY 11435"
