{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_part",
        derived_columns={
            "LOAD_DATE":     "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.PART",
            "PART_KEY":      "P_PARTKEY",
            "NAME":          "P_NAME",
            "MANUFACTURER":  "P_MFGR",
            "BRAND":         "P_BRAND",
            "TYPE":          "P_TYPE",
            "SIZE":          "P_SIZE",
            "CONTAINER":     "P_CONTAINER",
            "RETAIL_PRICE":  "P_RETAILPRICE",
            "COMMENT":       "P_COMMENT",
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
