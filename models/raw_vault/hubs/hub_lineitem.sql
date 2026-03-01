{{ config(
    materialized='incremental',
    post_hook="{% if not is_incremental() %}ALTER TABLE {{ this }} ADD CONSTRAINT pk_{{ this.name }} PRIMARY KEY (LINE_ITEM_HK){% endif %}"
) }}

{%- set source_model = "stg_lineitem"   -%}
{%- set src_pk = "LINE_ITEM_HK"         -%}
{%- set src_nk = "LINENUMBER"           -%}
{%- set src_ldts = "LOAD_DATE"          -%}
{%- set src_source = "RECORD_SOURCE"    -%}

{{ automate_dv.hub(
    src_pk=src_pk, 
    src_nk=src_nk, 
    src_ldts=src_ldts,
    src_source=src_source, 
    source_model=source_model) 
}}