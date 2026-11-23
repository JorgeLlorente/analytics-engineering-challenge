-- Exercise 5: Order segmentation

{{ config(
    materialized = 'view'
) }}

with order_dates as (
    select
        customer_id,
        order_id,
        date_date
    from {{ ref('stg_orders') }}
),
rolling_counts as (
    select
        a.order_id,
        count(b.order_id) as prior_orders_last_12m
    from order_dates a
    left join order_dates b
        on a.customer_id = b.customer_id
        and b.date_date >= dateadd(day, -365, a.date_date)
        and b.date_date < a.date_date
    group by a.order_id
)

select
    r.order_id,
    r.prior_orders_last_12m,
    case
        when r.prior_orders_last_12m = 0 then 'New'
        when r.prior_orders_last_12m between 1 and 3 then 'Returning'
        when r.prior_orders_last_12m >= 4 then 'VIP'
        else 'Unknown'
    end as order_segmentation
from rolling_counts r