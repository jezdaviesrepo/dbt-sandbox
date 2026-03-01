{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_region",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.REGION",
        },
        hashed_columns={
            "REGION_HK": ["R_REGIONKEY"],
            "REGION_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["R_REGIONKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}