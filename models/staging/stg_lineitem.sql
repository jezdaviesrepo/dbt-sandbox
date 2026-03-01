{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_lineitem",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.LINEITEM",
        },
        hashed_columns={
            "LINEITEM_HK": ["L_ORDERKEY", "L_PARTKEY", "L_SUPPKEY"],
            "LINEITEM_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["L_ORDERKEY", "L_PARTKEY", "L_SUPPKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}
