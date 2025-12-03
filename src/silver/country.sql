SELECT
    CAST(country_id AS BIGINT) AS country_id,
    INITCAP(TRIM(country))     AS country_name,
    current_timestamp()        AS inserted_at
FROM bronze.take_home_test.country;