{{ config(
    severity = 'warn'
) }}

with sales_agg as (
    select
        order_id,
        sum(net_sales) as total_sales_net_sales
    from {{ ref('stg_sales') }}
    group by order_id
),

reconciliation as (
    select
        coalesce(o.order_id, s.order_id) as order_id,
        o.net_sales as orders_net_sales,
        s.total_sales_net_sales as sales_net_sales,
        abs(coalesce(o.net_sales, 0) - coalesce(s.total_sales_net_sales, 0)) as diff
    from {{ ref('stg_orders') }} o
    full outer join sales_agg s
        on o.order_id = s.order_id
)

select *
from reconciliation
where orders_net_sales is null
   or sales_net_sales is null
   or diff > 0.01