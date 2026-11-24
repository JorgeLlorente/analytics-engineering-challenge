{{ config(
    materialized = 'table'
) }}

with products as (
    select distinct products_id
    from {{ ref('stg_sales') }}
)
select * from products