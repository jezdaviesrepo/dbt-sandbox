{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_partsupp",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.PARTSUPP",
        },
        hashed_columns={
            "PARTSUPP_HK": ["PS_PARTKEY", "PS_SUPPKEY"],
            "PARTSUPP_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["PS_PARTKEY", "PS_SUPPKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}