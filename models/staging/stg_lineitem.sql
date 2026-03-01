{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_lineitem",
        derived_columns={
            "LOAD_DATE":     "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.LINEITEM",
            "ORDERKEY":      "L_ORDERKEY",
            "PARTKEY":       "L_PARTKEY",
            "SUPPKEY":       "L_SUPPKEY",
            "LINENUMBER":    "L_LINENUMBER",
            "QUANTITY":      "L_QUANTITY",
            "EXTENDEDPRICE": "L_EXTENDEDPRICE",
            "DISCOUNT":      "L_DISCOUNT",
            "TAX":           "L_TAX",
            "RETURNFLAG":    "L_RETURNFLAG",
            "LINESTATUS":    "L_LINESTATUS",
            "SHIPDATE":      "L_SHIPDATE",
            "COMMITDATE":    "L_COMMITDATE",
            "RECEIPTDATE":   "L_RECEIPTDATE",
            "SHIPINSTRUCT":  "L_SHIPINSTRUCT",
            "SHIPMODE":      "L_SHIPMODE",
            "COMMENT":       "L_COMMENT",
        },
        hashed_columns={
            "ORDER_HK":        "L_ORDERKEY",
            "PART_HK":         "L_PARTKEY",
            "SUPPLIER_HK":     "L_SUPPKEY",
            "LINE_ITEM_LHK":   ["L_ORDERKEY", "L_PARTKEY", "L_SUPPKEY"],
            "LINE_ITEM_HK":    ["L_ORDERKEY", "L_PARTKEY", "L_SUPPKEY"],
            "LINE_ITEM_HASHDIFF": {
                "is_hashdiff": true,
                "exclude_columns": ["L_ORDERKEY", "L_PARTKEY", "L_SUPPKEY"],
                "columns": "all",
            },
        },
        ranked_columns=none,
    )
}}
