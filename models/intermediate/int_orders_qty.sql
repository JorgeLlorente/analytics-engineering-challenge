{{ config(
    materialized = 'view'
) }}

select
    order_id,
    sum(qty) as qty_product
from {{ ref('stg_sales') }}
group by order_id