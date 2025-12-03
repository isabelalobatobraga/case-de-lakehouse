SELECT
    CAST(time_id AS BIGINT)             AS time_id,
    CAST(action_timestamp AS TIMESTAMP) AS event_timestamp,
    CAST(year_id AS BIGINT)             AS year_id,
    CAST(month_id AS INT)               AS month_id,
    CAST(week_id AS BIGINT)             AS week_id,
    CAST(weekday_id AS INT)             AS weekday_id,
    current_timestamp()                 AS inserted_at
FROM bronze.take_home_test.d_time;