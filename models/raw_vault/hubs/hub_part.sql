{{ config(
    materialized='incremental',
    post_hook="{% if not is_incremental() %}ALTER TABLE {{ this }} ADD CONSTRAINT pk_{{ this.name }} PRIMARY KEY (PART_HK){% endif %}"
) }}

{%- set source_model = "stg_part"      -%}
{%- set src_pk = "PART_HK"             -%}
{%- set src_nk = "PART_KEY"            -%}
{%- set src_ldts = "LOAD_DATE"         -%}
{%- set src_source = "RECORD_SOURCE"   -%}

{{ automate_dv.hub(
    src_pk=src_pk, 
    src_nk=src_nk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) 
}}