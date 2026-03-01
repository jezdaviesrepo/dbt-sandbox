{{ config(
    materialized='incremental',
    database='REIGATE_MESH',
    schema='RAW_VAULT',
    post_hook="{% if not is_incremental() %}ALTER TABLE {{ this }} ADD CONSTRAINT pk_{{ this.name }} PRIMARY KEY (LINE_ITEM_LHK){% endif %}"
) }}

{%- set source_model = "stg_lineitem"                              -%}
{%- set src_pk       = "LINE_ITEM_LHK"                            -%}
{%- set src_fk       = ["ORDER_HK", "PART_HK", "SUPPLIER_HK"]    -%}
{%- set src_ldts     = "LOAD_DATE"                                -%}
{%- set src_source   = "RECORD_SOURCE"                            -%}

{{ automate_dv.link(
    src_pk=src_pk,
    src_fk=src_fk,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model)
}}
