SELECT
    CAST(year_id AS BIGINT)   AS year_id,
    CAST(action_year AS INT)  AS action_year,
    current_timestamp()       AS inserted_at
FROM bronze.take_home_test.d_year;
