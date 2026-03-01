{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_order",
        derived_columns={
            "LOAD_DATE":      "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE":  "!REDHILL.PUBLIC.ORDER",
            "ORDER_KEY":      "O_ORDERKEY",
            "CUSTOMER_KEY":   "O_CUSTKEY",
            "ORDER_STATUS":   "O_ORDERSTATUS",
            "TOTAL_PRICE":    "O_TOTALPRICE",
            "ORDER_DATE":     "O_ORDERDATE",
            "ORDER_PRIORITY": "O_ORDERPRIORITY",
            "CLERK":          "O_CLERK",
            "SHIPPRIORITY":   "O_SHIPPRIORITY",
            "COMMENT":        "O_COMMENT",
        },
        hashed_columns={
            "ORDER_HK":            "O_ORDERKEY",
            "CUSTOMER_HK":         "O_CUSTKEY",
            "ORDER_CUSTOMER_LHK":  ["O_ORDERKEY", "O_CUSTKEY"],
            "ORDER_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["O_ORDERKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}
