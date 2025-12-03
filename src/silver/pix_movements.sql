WITH remove_duplicates AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY id
            ORDER BY id
        ) AS rn
    FROM bronze.take_home_test.pix_movements
)

SELECT
    CAST(id AS BIGINT)            AS pix_movement_id,
    CAST(account_id AS BIGINT)    AS account_id,

    -- Normalize movement type (in/out)
    CASE 
        WHEN LOWER(TRIM(in_or_out)) IN ('pix_in') THEN 'IN'
        WHEN LOWER(TRIM(in_or_out)) IN ('pix_out') THEN 'OUT'
        ELSE NULL
    END AS movement_type,

    CAST(pix_amount AS FLOAT)        AS amount,
    CAST(pix_requested_at AS BIGINT) AS requested_time_id,

    -- Normalize transaction_completed_at:
    -- Only completed transactions should have a completion timestamp.
    CASE
        WHEN LOWER(TRIM(pix_completed_at)) IN ('none', 'null', '') THEN NULL
        ELSE CAST(pix_completed_at AS BIGINT)
    END AS completed_time_id,

    -- Normalize status into a boolean attribute
    CASE 
        WHEN LOWER(TRIM(status)) = 'completed' THEN TRUE
        ELSE FALSE
    END AS is_success,

    current_timestamp() AS inserted_at
FROM remove_duplicates
WHERE rn = 1; -- keep only one row per id
