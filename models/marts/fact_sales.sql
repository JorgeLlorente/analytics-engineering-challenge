{{ config(
    materialized = 'incremental',
    unique_key = ['order_id', 'products_id']
) }}

select
    date_date,
    customer_id,
    order_id,
    products_id,
    net_sales,
    qty
from {{ ref('stg_sales') }}

{% if is_incremental() %}
    where date_date >= (select max(date_date) from {{ this }})
{% endif %}