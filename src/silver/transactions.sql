WITH unified AS (
  -- ===========================
  -- transfer_ins
  -- ===========================
  SELECT
      transfer_in_id                      AS transaction_id,
      account_id                          AS account_id,
      amount                              AS amount,
      requested_time_id                   AS requested_time_id,
      completed_time_id                   AS completed_time_id,
      is_success                          AS is_success,
      "TRANSFER"                          AS transaction_method,
      "IN"                                AS movement_type,
      current_timestamp()                 AS inserted_at
  FROM silver.take_home_test.transfer_ins

  UNION ALL

  -- ===========================
  -- transfer_outs
  -- ===========================
  SELECT
      transfer_out_id                     AS transaction_id,
      account_id                          AS account_id,
      amount                              AS amount,
      requested_time_id                   AS requested_time_id,
      completed_time_id                   AS completed_time_id,
      is_success                          AS is_success,
      "TRANSFER"                          AS transaction_method,
      "OUT"                               AS movement_type,
      current_timestamp()                 AS inserted_at
  FROM silver.take_home_test.transfer_outs

  UNION ALL

  -- ===========================
  -- pix_movements
  -- ===========================
  SELECT
      pix_movement_id                     AS transaction_id,
      account_id                          AS account_id,
      amount                              AS amount,
      requested_time_id                   AS requested_time_id,
      completed_time_id                   AS completed_time_id,
      is_success                          AS is_success,
      'PIX'                               AS transaction_method,
      movement_type                       AS movement_type,
      current_timestamp()                 AS inserted_at
  FROM silver.take_home_test.pix_movements
)

-- ===========================
--   REMOVE PERFECT DUPLICATES
-- ===========================
SELECT DISTINCT *
FROM unified;
