{{ config(
    materialized = 'table'
) }}

with base as (
    select distinct customer_id
    from {{ ref('stg_orders') }}
)
select * from base