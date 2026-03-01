{{ config(schema="staging") }}

with 

source as (

    select * from {{ source('redhill', 'region') }}

),

renamed as (

    select
        r_regionkey,
        r_name,
        r_comment

    from source

)

select * from renamed