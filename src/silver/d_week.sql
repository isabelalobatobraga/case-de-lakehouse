SELECT
    CAST(week_id AS BIGINT)   AS week_id,
    CAST(action_week AS INT)  AS action_week,
    current_timestamp()       AS inserted_at
FROM bronze.take_home_test.d_week;