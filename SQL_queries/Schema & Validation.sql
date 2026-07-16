CREATE TABLE transactions (
    hour_number             INTEGER,
    payment_type            VARCHAR(20),
    money_amount            NUMERIC(18,2),
    sender_id               VARCHAR(30),
    sender_balance_before   NUMERIC(18,2),
    sender_balance_after    NUMERIC(18,2),
    receiver_id             VARCHAR(30),
    receiver_balance_before NUMERIC(18,2),
    receiver_balance_after  NUMERIC(18,2),
    is_fraud                SMALLINT,
    system_caught_it        SMALLINT,
    balance_doesnt_match    SMALLINT,
    balance_matches         SMALLINT,
    fraud_risk_flag         SMALLINT
);

SELECT COUNT(*) FROM transactions;

SELECT
    COUNT(*) AS row_count,
    ROUND(SUM(money_amount), 2) AS total_amount,
    SUM(is_fraud) AS fraud_count,
    SUM(system_caught_it) AS system_caught_it_count,
    SUM(fraud_risk_flag)  AS fraud_risk_flag_count
FROM transactions;