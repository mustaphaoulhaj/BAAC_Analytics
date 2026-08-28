WITH source AS (

    SELECT *
    FROM {{ source('raw', 'raw_usagers') }}

),

clean AS (

    SELECT
        -- Identifiants
        Num_Acc AS accident_id,
        id_vehicule AS vehicule_id,
        id_usager AS usager_id,

        -- Informations usager
        num_veh AS numero_vehicule,
        place AS place_occupant,
        catu AS categorie_usager,
        grav AS gravite,
        sexe AS sexe,
        trajet AS trajet,
        (secu1 + secu2 + secu3) AS equipement_securite,
        locp AS localisation_usager,
        actp AS action_usager,
        etatp AS etat_physique,
        an_nais AS annee_naissance,

        -- Nettoyage
        CAST(grav AS INTEGER) AS gravite_int,
        CAST(an_nais AS INTEGER) AS annee_naissance_int,
        LOWER(CAST(sexe AS VARCHAR)) AS sexe_lower

    FROM source
)

SELECT *
FROM clean
