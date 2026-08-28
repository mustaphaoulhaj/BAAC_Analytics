{{ config(
    materialized='table',
    schema='main',
    alias='dataset_baac'
) }}

WITH accidents AS (
    SELECT * FROM {{ ref('dim_accidents') }}
),
usagers AS (
    SELECT * FROM {{ ref('dim_usagers') }}
),
vehicules AS (
    SELECT * FROM {{ ref('dim_vehicules') }}
),
facts AS (
    SELECT * FROM {{ ref('fact_accidents') }}
),
ftr AS (
    SELECT * FROM {{ ref('ftr_accidents') }}
)

SELECT
    a.*,
    u.* EXCLUDE (accident_id),
    v.* EXCLUDE (accident_id, vehicule_id),
    f.* EXCLUDE (accident_id),
    t.* EXCLUDE (accident_id)
FROM accidents a
LEFT JOIN usagers u USING (accident_id)
LEFT JOIN vehicules v USING (accident_id, vehicule_id)
LEFT JOIN facts f USING (accident_id)
LEFT JOIN ftr t USING (accident_id)
