WITH veh AS (
    SELECT *
    FROM {{ ref('stg_vehicules') }}
)

SELECT
    veh.accident_id,
    veh.vehicule_id,
    veh.sens_circulation,
    veh.categorie_vehicule_int AS categorie_vehicule,
    veh.obstacle_heurte,
    veh.obstacle_mobile_heurte,
    veh.type_choc,
    veh.manoeuvre_clean AS manoeuvre

FROM veh