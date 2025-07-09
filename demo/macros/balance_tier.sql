/*
    Macro para clasificar balances en tiers
    Puede ser reutilizado en diferentes modelos para mantener consistencia
    Sería lo mismo que balance_segment pero siendo una macro
*/

{% macro balance_tier(balance_column) %}
    case 
        when {{ balance_column }} <= 0 then 'Sin balance'
        when {{ balance_column }} > 0 and {{ balance_column }} <= 50 then 'Balance bajo'
        when {{ balance_column }} > 50 and {{ balance_column }} <= 200 then 'Balance medio'
        when {{ balance_column }} > 200 and {{ balance_column }} <= 500 then 'Balance alto'
        when {{ balance_column }} > 500 then 'Balance muy alto'
        else 'Sin clasificar'
    end
{% endmacro %} 