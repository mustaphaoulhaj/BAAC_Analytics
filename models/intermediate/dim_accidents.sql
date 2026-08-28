WITH caract AS (
    SELECT *
    FROM {{ ref('stg_caract') }}
),

lieux AS (
    SELECT *
    FROM {{ ref('stg_lieux') }}
)

SELECT
    c.accident_id,
    c.date_accident,
    c.departement,
    c.commute,
    c.agglomeration,
    c.luminosite,
    c.intersection,
    c.atmosphere,

    -- Lieux
    l.type_voie,
    l.numero_voie,
    l.plan_voie,
    l.etat_surface,
    l.infrastructure,
    l.situation,
    l.vma_int AS vitesse_max_autorisee

FROM caract c
LEFT JOIN lieux l
    ON c.accident_id = l.accident_id
