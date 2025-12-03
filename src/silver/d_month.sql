SELECT
    CAST(month_id AS INT)      AS month_id,
    CAST(action_month AS INT)  AS action_month,
    current_timestamp()        AS inserted_at
FROM bronze.take_home_test.d_month;