{{ config(
    materialized = 'view'
) }}

select
    cast(date_date as date) as date_date,
    cast(customers_id as int) as customer_id,
    cast(orders_id as int) as order_id,
    cast(net_sales as decimal(18, 2)) as net_sales
from {{ source('bronze', 'raw_orders') }}