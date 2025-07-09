/*
    Resumen estadístico de balances de líneas prepago
    Muestra métricas agregadas para análisis ejecutivo
*/

{{ config(materialized='table') }}

select
    count(*) as total_lines,
    count(distinct phone_line) as unique_lines,
    round(avg(balance), 2) as avg_balance,
    round(min(balance), 2) as min_balance,
    round(max(balance), 2) as max_balance,
    round(sum(balance), 2) as total_balance,
    round(median(balance), 2) as median_balance,
    last_update
from {{ ref('base_phone_balance') }}
group by last_update 