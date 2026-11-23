{{ config(
    materialized = 'incremental',
    unique_key = 'order_id'
) }}

with orders as (
    select * from {{ ref('stg_orders') }}
),
order_qty as (
    select * from {{ ref('int_orders_qty') }}
),
order_segments as (
    select * from {{ ref('int_customer_order_segments') }}
)

select
    o.order_id,
    o.customer_id,
    o.date_date,
    o.net_sales,
    coalesce(q.qty_product, 0) as qty_product, -- Exercise 4
    s.order_segmentation                       -- Exercise 6
from orders o
left join order_qty q on o.order_id = q.order_id
left join order_segments s on o.order_id = s.order_id