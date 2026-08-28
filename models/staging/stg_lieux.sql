WITH source AS (

    SELECT *
    FROM {{ source('raw', 'raw_lieux') }}

),

clean AS (

    SELECT
        Num_Acc AS accident_id,

        -- Localisation
        catr AS type_voie,
        voie AS numero_voie,
        v1 AS indice_voie,
        v2 AS indice_voie_2,
        pr AS point_repere,
        pr1 AS point_repere_detail,
        plan AS plan_voie,
        lartpc AS largeur_chaussée,
        larrout AS largeur_route,
        surf AS etat_surface,
        infra AS infrastructure,
        situ AS situation,
        vma AS vitesse_max_autorisee,

        -- Nettoyage
        TRIM(voie) AS voie_clean,
        CAST(vma AS INTEGER) AS vma_int

    FROM source
)

SELECT *
FROM clean
