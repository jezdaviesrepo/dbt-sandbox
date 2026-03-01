{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_supplier",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.SUPPLIER",
        },
        hashed_columns={
            "SUPPLIER_HK": ["S_SUPPKEY"],
            "SUPPLIER_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["S_SUPPKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}