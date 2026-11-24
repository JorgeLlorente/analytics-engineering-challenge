{{ config(
    materialized = 'table'
) }}

with customers as (
    select distinct customer_id
    from {{ ref('stg_orders') }}
)
select * from customers