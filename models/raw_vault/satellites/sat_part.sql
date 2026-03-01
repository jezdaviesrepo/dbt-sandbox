{{ config(
    materialized='incremental',
    post_hook="{% if not is_incremental() %}ALTER TABLE {{ this }} ADD CONSTRAINT pk_{{ this.name }} PRIMARY KEY (PART_HK, LOAD_DATE){% endif %}"
) }}

{%- set source_model = "stg_part"       -%}
{%- set src_pk       = "PART_HK"        -%}
{%- set src_hashdiff = "PART_HASHDIFF"  -%}
{%- set src_eff      = "LOAD_DATE"          -%}
{%- set src_ldts     = "LOAD_DATE"          -%}
{%- set src_source   = "RECORD_SOURCE"      -%}

{%- set src_payload = dbt_utils.get_filtered_columns_in_relation(
    from=ref('stg_part'),
    except=[src_pk, src_hashdiff, src_ldts, src_source]
) -%}

{{ automate_dv.sat(
    src_pk=src_pk,
    src_hashdiff=src_hashdiff,
    src_payload=src_payload,
    src_eff=src_eff,
    src_ldts=src_ldts,
    src_source=src_source,
    source_model=source_model)
}}