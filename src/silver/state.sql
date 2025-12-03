SELECT
    CAST(state_id AS BIGINT)    AS state_id,
    CAST(country_id AS BIGINT)  AS country_id,
    UPPER(TRIM(state))          AS state_code,
    current_timestamp()         AS inserted_at
FROM bronze.take_home_test.state;