{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_partsupp",
        derived_columns={
            "LOAD_DATE":               "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE":           "!REDHILL.PUBLIC.PARTSUPP",
            "PART_KEY":                "PS_PARTKEY",
            "SUPPLIER_KEY":            "PS_SUPPKEY",
            "AVAILABLE_QUANTITY":      "PS_AVAILQTY",
            "SUPPLY_COST":             "PS_SUPPLYCOST",
            "COMMENT":                 "PS_COMMENT",
        },
        hashed_columns={
            "PART_HK":             "PS_PARTKEY",
            "SUPPLIER_HK":         "PS_SUPPKEY",
            "PART_SUPPLIER_LHK":   ["PS_PARTKEY", "PS_SUPPKEY"],
            "PART_SUPPLIER_HK":    ["PS_PARTKEY", "PS_SUPPKEY"],
            "PART_SUPPLIER_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["PS_PARTKEY", "PS_SUPPKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}
