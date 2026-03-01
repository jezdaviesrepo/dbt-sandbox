{{ config(
    materialized='incremental',
    post_hook="{% if not is_incremental() %}ALTER TABLE {{ this }} ADD CONSTRAINT pk_{{ this.name }} PRIMARY KEY (PARTSUPP_HK){% endif %}"
) }}

{%- set source_model = "stg_partsupp"   -%}
{%- set src_pk = "PARTSUPP_HK"          -%}
{%- set src_nk = "PS_PARTKEY"           -%}
{%- set src_ldts = "LOAD_DATE"          -%}
{%- set src_source = "RECORD_SOURCE"    -%}

{{ automate_dv.hub(
    src_pk=src_pk, 
    src_nk=src_nk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) 
}}