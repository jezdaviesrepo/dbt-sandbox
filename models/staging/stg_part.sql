{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_part",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.PART",
        },
        hashed_columns={
            "PART_HK": ["P_PARTKEY"],
            "PART_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["P_PARTKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}