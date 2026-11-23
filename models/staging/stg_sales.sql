{{ config(
    materialized = 'view'
) }}

with raw_data as (
    select
        cast(Prop_0 as varchar(50)) as col_date,
        cast(Prop_1 as varchar(50)) as col_customer,
        cast(Prop_2 as varchar(50)) as col_order,
        cast(Prop_3 as varchar(50)) as col_product,
        cast(Prop_4 as varchar(50)) as col_sales,
        cast(Prop_5 as varchar(50)) as col_qty
    from {{ source('bronze', 'raw_sales') }}
),
filtered_data as (
    select *
    from raw_data
    where col_date not in ('date_date', 'Column1')
      and col_date is not null
)

select
    cast(col_date as date) as date_date,
    cast(col_customer as varchar(50)) as customer_id,
    cast(col_order as varchar(50)) as order_id,
    cast(col_product as varchar(50)) as products_id,
    cast(col_sales as decimal(18, 2)) as net_sales,
    cast(col_qty as int) as qty
from filtered_data