/*
    Segmentación de balances por rangos
    Permite analizar la distribución de los balances de clientes
    Sería views.balance_segments
*/

{{ config(materialized='view') }}

select
    phone_line,
    balance,
    case 
        when balance <= 0 then 'Sin balance'
        when balance > 0 and balance <= 50 then 'Balance bajo (1-50)'
        when balance > 50 and balance <= 200 then 'Balance medio (51-200)'
        when balance > 200 and balance <= 500 then 'Balance alto (201-500)'
        when balance > 500 then 'Balance muy alto (500+)'
        else 'Sin clasificar'
    end as balance_segment,
    case 
        when balance <= 0 then 1
        when balance > 0 and balance <= 50 then 2
        when balance > 50 and balance <= 200 then 3
        when balance > 200 and balance <= 500 then 4
        when balance > 500 then 5
        else 0
    end as segment_order,
    created_at,
    last_update
from {{ ref('base_phone_balance') }} 

