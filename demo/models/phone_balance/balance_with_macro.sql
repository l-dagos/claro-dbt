/*
    Ejemplo de uso del macro balance_tier
    Demuestra cómo reutilizar lógica de negocio a través de macros
    Sería views.balance_with_macro
*/

{{ config(materialized='view') }}

select
    phone_line,
    balance,
    {{ balance_tier('balance') }} as tier_from_macro,
    created_at,
    last_update
from {{ ref('base_phone_balance') }}
order by balance desc 