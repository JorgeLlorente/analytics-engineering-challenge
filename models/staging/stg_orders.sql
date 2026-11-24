{{ config(
    materialized = 'view'
) }}

select
    cast(date_date as date) as date_date,
    cast(customers_id as varchar(50)) as customer_id,
    cast(orders_id as varchar(50)) as order_id,
    cast(net_sales as decimal(18, 4)) as net_sales
from {{ source('bronze', 'raw_orders') }}