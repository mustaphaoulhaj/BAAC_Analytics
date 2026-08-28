WITH u AS (
    SELECT *
    FROM {{ ref('stg_usagers') }}
)

SELECT
    u.accident_id,
    u.vehicule_id,
    u.usager_id,
    u.place_occupant,
    u.categorie_usager,
    u.gravite_int AS gravite,
    u.sexe_lower AS sexe,
    u.trajet,
    u.equipement_securite,
    u.localisation_usager,
    u.action_usager,
    u.etat_physique,
    u.annee_naissance_int,
    u.gravite_int

FROM u
