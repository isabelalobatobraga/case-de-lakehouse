SELECT
    CAST(city_id AS BIGINT)   AS city_id,
    CAST(state_id AS BIGINT)  AS state_id,
    INITCAP(TRIM(city))       AS city_name,
    current_timestamp()       AS inserted_at
FROM bronze.take_home_test.city;