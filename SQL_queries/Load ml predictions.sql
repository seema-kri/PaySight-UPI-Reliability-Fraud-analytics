CREATE TABLE ml_predictions (
    sender_id             VARCHAR(30),
    receiver_id           VARCHAR(30),
    money_amount          NUMERIC(18,2),
    is_fraud              SMALLINT,
    ml_fraud_probability  NUMERIC(10,6),
    ml_predicted_fraud    SMALLINT
);

SELECT COUNT(*) FROM ml_predictions;
SELECT
    ROUND(100.0 * SUM(CASE WHEN is_fraud=1 AND ml_predicted_fraud=1 THEN 1 ELSE 0 END)
        / NULLIF(SUM(is_fraud),0), 2) AS ml_recall_pct
FROM ml_predictions;