SELECT
    CAST(weekday_id AS INT)      AS weekday_id,
    CAST(action_weekday AS INT)  AS action_weekday,
    current_timestamp()          AS inserted_at
FROM bronze.take_home_test.d_weekday;