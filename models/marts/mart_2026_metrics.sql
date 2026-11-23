{{ config(
    materialized = 'table'
) }}

{% set target_year = var('target_year', 2026) %}

with base_orders as (
    select
        order_id,
        date_date,
        qty_product
    from {{ ref('fact_orders') }}
    where year(date_date) = {{ target_year }}
)

select
    cast(year(date_date) as varchar(50)) as order_year,
    cast(month(date_date) as varchar(50)) as order_month,
    count(order_id) as total_orders, -- Exercise 1 (total orders adding in Power BI) & Exercise 2 (nb of orders per month)
    avg(cast(qty_product as float)) as avg_qty_per_order -- Exercise 3 (average quantity per order)
from base_orders
group by
    year(date_date),
    month(date_date)