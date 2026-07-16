--Q1: Which transaction types have the highest fraud rate?
select payment_type,count(*) as total_transactions,
sum(is_fraud) as fraud_count,
round(100.0 * sum(is_fraud) / count(*), 4)  as fraud_rate_pct
from transactions
group by payment_type
order by fraud_rate_pct desc;

-- Q2: How does transaction amount influence fraud probability?
select case
        when money_amount < 10000  then '1. Under 10K'
        when money_amount < 100000  then'2. 10K - 100K'
        when money_amount < 500000  then '3. 100K - 500K'
        when money_amount < 1000000 then '4. 500K - 1M'
        else '5. Above 1M'
end as amount_bracket,
count(*) as total_transactions,sum(is_fraud) as fraud_count,
ROUND(100.0 * sum(is_fraud) / count(*), 4) as fraud_rate_pct
from transactions
group by amount_bracket
order by amount_bracket;

--

--Q3: Which time periods (hour of day) see the most fraud?
select mod(hour_number, 24) as hour_of_day,
count(*) as total_transactions,
sum(is_fraud) as fraud_count,
ROUND(100.0 * sum(is_fraud) / count(*), 4) as fraud_rate_pct
from transactions
group by hour_of_day
order by hour_of_day;


-- Q4: What customer behavior signals suspicious activity?
select payment_type,
count(*) as full_drain_transactions,
sum(is_fraud) as fraud_count,
round(100.0 * sum(is_fraud) / count(*), 4) as fraud_rate_pct
from transactions
where sender_balance_before > 0 and sender_balance_after = 0
group by payment_type
order by fraud_rate_pct desc;

-- Q5: How effective is the existing fraud detection system?

select
    sum(is_fraud) as real_fraud_count,
    sum(system_caught_it) as system_flagged_count,
    sum(case when is_fraud=1 and system_caught_it=1 then 1 else 0 end) as correctly_caught,
    sum(case when is_fraud=1 and system_caught_it=0 then 1 else 0 end) as missed_fraud,
    round(100.0 * sum(case when is_fraud=1 and system_caught_it=1 then 1 else 0 end)
        / nullif(sum(is_fraud),0), 2) as detection_rate_pct
from transactions;