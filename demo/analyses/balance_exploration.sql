/*
    Análisis exploratorio de balances
    Este archivo en analyses/ permite ejecutar queries ad-hoc sin crear modelos
    Ejecutar con: dbt compile --select balance_exploration
*/

-- Distribución de balances por cuartiles
with quartiles as (
    select
        balance,
        ntile(4) over (order by balance) as quartile
    from {{ ref('base_phone_balance') }}
),
quartile_stats as (
    select
        quartile,
        count(*) as line_count,
        round(min(balance), 2) as min_balance,
        round(max(balance), 2) as max_balance,
        round(avg(balance), 2) as avg_balance
    from quartiles
    group by quartile
)

select 
    'Q' || quartile as quartile_label,
    line_count,
    min_balance,
    max_balance,
    avg_balance,
    round(line_count * 100.0 / sum(line_count) over(), 2) as percentage
from quartile_stats
order by quartile;

-- Top 10 balances más altos
-- select 
--     phone_line,
--     balance,
--     rank() over (order by balance desc) as balance_rank
-- from {{ ref('base_phone_balance') }}
-- order by balance desc
-- fetch first 10 rows only;

-- Análisis de outliers (valores que exceden 3 desviaciones estándar)
-- with stats as (
--     select
--         avg(balance) as mean_balance,
--         stddev(balance) as stddev_balance
--     from {{ ref('base_phone_balance') }}
-- )
-- select
--     pb.phone_line,
--     pb.balance,
--     round((pb.balance - s.mean_balance) / s.stddev_balance, 2) as z_score
-- from {{ ref('base_phone_balance') }} pb
-- cross join stats s
-- where abs((pb.balance - s.mean_balance) / s.stddev_balance) > 3
-- order by abs((pb.balance - s.mean_balance) / s.stddev_balance) desc; 