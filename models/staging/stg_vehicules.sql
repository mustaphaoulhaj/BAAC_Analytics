WITH source AS (

    SELECT *
    FROM {{ source('raw', 'raw_vehicules') }}

),

clean AS (

    SELECT
        -- Identifiant accident
        Num_Acc AS accident_id,

        -- Identifiant véhicule
        id_vehicule AS vehicule_id,

        -- Catégories et caractéristiques
        senc AS sens_circulation,
        catv AS categorie_vehicule,
        occutc AS occupants_transport_en_commun,
        obs AS obstacle_heurte,
        obsm AS obstacle_mobile_heurte,
        choc AS type_choc,
        manv AS manoeuvre,

        -- Nettoyage
        CAST(catv AS INTEGER) AS categorie_vehicule_int,
        CAST(manv AS VARCHAR) AS manoeuvre_clean

    FROM source
)

SELECT *
FROM clean
