{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model="src_customer",
        derived_columns={
            "LOAD_DATE": "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.CUSTOMER",
        },
        hashed_columns={
            "CUSTOMER_HK": "C_CUSTKEY",
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