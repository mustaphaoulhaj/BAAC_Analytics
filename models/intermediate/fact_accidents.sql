WITH accidents AS (
    SELECT *
    FROM {{ ref('dim_accidents') }}
),

vehicules AS (
    SELECT *
    FROM {{ ref('dim_vehicules') }}
),

usagers AS (
    SELECT *
    FROM {{ ref('dim_usagers') }}
)

SELECT
    acc.accident_id,

    -- Accident
    acc.date_accident,
    acc.departement,
    acc.agglomeration,
    acc.luminosite,
    acc.intersection,
    acc.atmosphere,
    acc.vitesse_max_autorisee,

    -- Véhicule
    veh.vehicule_id,
    veh.categorie_vehicule,
    veh.sens_circulation,
    veh.type_choc,
    veh.manoeuvre,
    veh.obstacle_heurte,
    veh.obstacle_mobile_heurte,

    -- Usager
    us.usager_id,
    us.categorie_usager,
    us.gravite,
    us.gravite_int,
    us.sexe,
    us.trajet,
    us.equipement_securite,
    us.localisation_usager,
    us.action_usager,
    us.etat_physique,
    us.annee_naissance_int,


FROM accidents acc
LEFT JOIN vehicules veh
    ON acc.accident_id = veh.accident_id
LEFT JOIN usagers us
    ON veh.vehicule_id = us.vehicule_id
