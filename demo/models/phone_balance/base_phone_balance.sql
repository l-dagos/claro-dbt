/*
    Modelo base para phone_balance
    Extrae datos de la tabla ABT_MOTHER filtrados para líneas prepago
    Esto es lo que se usa para el modelo base_phone_balance
*/

{{ config(materialized='view') }}

select
    FECHA as created_at,
    CELLULAR_NUMBER as phone_line,
    MAIN_BALANCE as balance,
    trunc(current_date) as last_update
from PYDW.ABT_MOTHER
where 1=1
    and CBT_ID = 'PP'
    and FECHA = trunc(to_date('2023-11-17', 'yyyy-mm-dd'), 'mm') 