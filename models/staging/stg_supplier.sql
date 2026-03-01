{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_supplier",
        derived_columns={
            "LOAD_DATE":      "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE":  "!REDHILL.PUBLIC.SUPPLIER",
            "SUPPLIER_KEY":   "S_SUPPKEY",
            "NAME":           "S_NAME",
            "ADDRESS":        "S_ADDRESS",
            "NATION_KEY":     "S_NATIONKEY",
            "PHONE":          "S_PHONE",
            "ACCOUNT_BALANCE":"S_ACCTBAL",
            "COMMENT":        "S_COMMENT",
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
