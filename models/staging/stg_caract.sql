WITH clean AS (
    SELECT
        Num_Acc AS accident_id,
        an AS annee,
        mois,
        jour,

        MAKE_DATE(
            CAST(an AS BIGINT),
            CAST(mois AS BIGINT),
            CAST(jour AS BIGINT)
        ) AS date_accident,

        lum AS luminosite,
        agg AS agglomeration,
        int AS intersection,
        atm AS atmosphere,
        col,
        dep AS departement,
        com AS commute

    FROM {{ source('raw', 'raw_caracteristiques') }}
)

SELECT *
FROM clean
