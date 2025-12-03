WITH normalized AS (
    SELECT
        CAST(account_id AS BIGINT)      AS account_id,
        CAST(customer_id AS BIGINT)     AS customer_id,
        CAST(created_at AS TIMESTAMP)   AS created_at,

        -- Normalize status to a boolean attribute
        CASE 
            WHEN LOWER(TRIM(status)) = 'active' THEN TRUE
            ELSE FALSE
        END AS is_active,

        -- Normalize by removing any non-numeric characters 
        -- (values are NOT persisted in clear form)
        REGEXP_REPLACE(TRIM(account_branch), '[^0-9]', '') AS branch_norm,
        REGEXP_REPLACE(TRIM(account_number), '[^0-9]', '') AS number_norm,
        REGEXP_REPLACE(TRIM(account_check_digit), '[^0-9]', '') AS digit_norm,

        current_timestamp() AS inserted_at
    FROM bronze.take_home_test.accounts
)

SELECT
    account_id,
    customer_id,
    created_at,
    is_active,

    -- Masked Account Branch without ever exposing the real value
    -- Keep only the last digit visible (max length = 4)
    CONCAT(
        '***',
        RIGHT(LPAD(branch_norm, 4, '0'), 1)
    ) AS account_branch_masked,

    -- Masked Account Numbber without ever exposing the real value
    -- Keep only the last two digit visible (max length = 5)
    CONCAT(
        '***',
        RIGHT(LPAD(number_norm, 5, '0'), 2)
    ) AS account_number_masked,

    -- Check digit: always fully masked (1 digit)
    '*' AS account_check_digit_masked,
    inserted_at
FROM normalized