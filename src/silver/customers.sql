SELECT
    CAST(customer_id AS BIGINT)     AS customer_id,
    INITCAP(TRIM(first_name))       AS first_name,
    INITCAP(TRIM(last_name))        AS last_name,
    CAST(customer_city AS BIGINT)   AS city_id,
    INITCAP(TRIM(country_name))     AS country_name,

    -- Masked CPF without ever exposing the real value
    CONCAT(
        '***.***.***-',
        SUBSTRING(
            LPAD(REGEXP_REPLACE(TRIM(cpf), '[^0-9]', ''), 11, '0'),
            -2
        )
    ) AS cpf_masked,

    current_timestamp() AS inserted_at
FROM bronze.take_home_test.customers