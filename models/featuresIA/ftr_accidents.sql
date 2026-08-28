WITH fact AS (
    SELECT *
    FROM {{ ref('fact_accidents') }}
),

features AS (

    SELECT
        accident_id,
        vehicule_id,
        usager_id,

        -- Gravité normalisée (0 à 1)
        gravite,
        gravite / 4.0 AS gravite_normalisee,

        -- Age usager
        CASE 
            WHEN annee_naissance_int IS NOT NULL 
            THEN 2024 - annee_naissance_int
        END AS age_usager,

        -- Typologie d'accident
        CASE
            WHEN type_choc = 1 THEN 'Frontal'
            WHEN type_choc = 2 THEN 'Latéral'
            WHEN type_choc = 3 THEN 'Arrière'
            ELSE 'Autre'
        END AS typologie_choc,

        CASE
            WHEN obstacle_heurte IN (1,2,3) THEN 'Obstacle fixe'
            WHEN obstacle_mobile_heurte IS NOT NULL THEN 'Obstacle mobile'
            ELSE 'Sans obstacle'
        END AS typologie_obstacle,

        -- Score de risque véhicule
        (
            gravite_int * 0.4 +
            categorie_vehicule * 0.3 +
            CASE WHEN type_choc = 1 THEN 0.3 ELSE 0 END
        ) AS risque_vehicule,

        -- Score de risque usager
        (
            gravite_int * 0.6 +
            CASE WHEN equipement_securite = 0 THEN 0.4 ELSE 0 END
        ) AS risque_usager,

        -- Vitesse vs gravité
        CASE
            WHEN vitesse_max_autorisee > 80 AND gravite >= 3 THEN 'Risque élevé'
            WHEN vitesse_max_autorisee > 50 AND gravite >= 2 THEN 'Risque moyen'
            ELSE 'Risque faible'
        END AS vitesse_risque,

        -- Feature textuelle
        CONCAT(
            'Accident ', accident_id,
            ' impliquant un véhicule de catégorie ', categorie_vehicule,
            ', choc ', type_choc,
            ', gravité ', gravite,
            ', usager ', sexe,
            ', âge ', COALESCE(CAST(2024 - annee_naissance_int AS VARCHAR), 'inconnu'),
            '.'
        ) AS resume_accident

    FROM fact
)

SELECT *
FROM features
