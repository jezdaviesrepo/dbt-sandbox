{{ config(schema="STAGING", database="REIGATE_MESH", materialized="view") }}

{{
    automate_dv.stage(
        include_source_columns=false,
        source_model="src_nation",
        derived_columns={
            "LOAD_DATE":     "CURRENT_TIMESTAMP()",
            "RECORD_SOURCE": "!REDHILL.PUBLIC.NATION",
            "NATION_KEY":    "N_NATIONKEY",
            "NAME":          "N_NAME",
            "REGION_KEY":    "N_REGIONKEY",
            "COMMENT":       "N_COMMENT",
        },
        hashed_columns={
            "NATION_HK": "N_NATIONKEY",
            "NATION_HASHDIFF": {
                "is_hashdiff": true,
                "columns": ["N_NAME", "N_COMMENT"],
            },
        },
        ranked_columns=none,
    )
}}
