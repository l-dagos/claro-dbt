/*
    Análisis de distribución por segmentos de balance
    Proporciona insights sobre la concentración de balances
    Esto es lo que se usa para el modelo segment_analysis
    Sería tables.segment_analysis
*/

{{ config(materialized='table') }}

select
    balance_segment,
    segment_order,
    count(*) as line_count,
    round(avg(balance), 2) as avg_balance_in_segment,
    round(sum(balance), 2) as total_balance_in_segment,
    round(count(*) * 100.0 / sum(count(*)) over(), 2) as percentage_of_lines,
    round(sum(balance) * 100.0 / sum(sum(balance)) over(), 2) as percentage_of_total_balance
from {{ ref('balance_segments') }}
group by balance_segment, segment_order
order by segment_order 