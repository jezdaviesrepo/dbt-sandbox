{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_order",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.ORDER",
        },
        hashed_columns={
            "ORDER_HK": ["O_ORDERKEY"],
            "ORDER_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["O_ORDERKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}