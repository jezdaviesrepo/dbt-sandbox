{{ config(
    materialized='incremental',
    database='REIGATE_MESH',
    schema='RAW_VAULT',
    post_hook="{% if not is_incremental() %}ALTER TABLE {{ this }} ADD CONSTRAINT pk_{{ this.name }} PRIMARY KEY (CUSTOMER_NATION_LHK){% endif %}"
) }}

{%- set source_model = "stg_customer"              -%}
{%- set src_pk       = "CUSTOMER_NATION_LHK"       -%}
{%- set src_fk       = ["CUSTOMER_HK", "NATION_HK"] -%}
{%- set src_ldts     = "LOAD_DATE"                 -%}
{%- set src_source   = "RECORD_SOURCE"             -%}

{{ automate_dv.link(
    src_pk=src_pk,
    src_fk=src_fk,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model)
}}