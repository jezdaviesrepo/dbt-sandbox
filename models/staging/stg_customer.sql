{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_customer",
        derived_columns={
            "LOAD_DATE":       "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE":   "!REDHILL.PUBLIC.CUSTOMER",
            "CUSTOMER_KEY":    "C_CUSTKEY",
            "NAME":            "C_NAME",
            "ADDRESS":         "C_ADDRESS",
            "NATION_KEY":      "C_NATIONKEY",
            "PHONE":           "C_PHONE",
            "ACCOUNT_BALANCE": "C_ACCTBAL",
            "MARKET_SEGMENT":  "C_MKTSEGMENT",
            "COMMENT":         "C_COMMENT",
        },
        hashed_columns={
            "CUSTOMER_HK":         "C_CUSTKEY",
            "NATION_HK":           "C_NATIONKEY",
            "CUSTOMER_NATION_LHK": ["C_CUSTKEY", "C_NATIONKEY"],
            "CUSTOMER_HASHDIFF": {
                "is_hashdiff": true,
                "columns": [
                    "C_NAME",
                    "C_ADDRESS",
                    "C_PHONE",
                    "C_ACCTBAL",
                    "C_MKTSEGMENT",
                    "C_COMMENT",
                ],
            },
        },
        ranked_columns=none,
    )
}}