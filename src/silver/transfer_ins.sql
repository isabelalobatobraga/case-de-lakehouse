WITH remove_duplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY id
            ORDER BY id
        ) AS rn
    FROM bronze.take_home_test.transfer_ins
)

SELECT
    CAST(id AS BIGINT)                       AS transfer_in_id,
    CAST(account_id AS BIGINT)               AS account_id,
    CAST(amount AS FLOAT)                    AS amount,
    CAST(transaction_requested_at AS BIGINT) AS requested_time_id,

    -- Normalize transaction_completed_at:
    -- Only completed transactions should have a completion timestamp.
    CASE 
        WHEN LOWER(transaction_completed_at) IN ('none', 'null', '') THEN NULL
        ELSE CAST(transaction_completed_at AS BIGINT)
    END AS completed_time_id,

    -- Normalize status into a boolean attribute
    CASE 
        WHEN LOWER(TRIM(status)) = 'completed' THEN TRUE 
        ELSE FALSE
    END AS is_success,

    current_timestamp() AS inserted_at
FROM remove_duplicates
WHERE rn = 1;   -- keep only one row per id
