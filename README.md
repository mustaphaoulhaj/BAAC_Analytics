# BAAC Analytics

> Pipeline analytique des accidents corporels de la circulation (données ONISR/BAAC)

[![dbt CI](https://github.com/mustaphaoulhaj/BAAC_Analytics/actions/workflows/Dbt.yml/badge.svg)](https://github.com/mustaphaoulhaj/BAAC_Analytics/actions/workflows/Dbt.yml)

---

## 📋 Vue d'ensemble

Ce projet construit un pipeline analytique complet à partir des données **BAAC** (Bulletin d'Analyse des Accidents Corporels de la Circulation, source **ONISR**), depuis l'ingestion des fichiers CSV bruts jusqu'à un dashboard **Power BI**, avec un environnement **dbt Core** reproductible et une **CI/CD GitHub Actions**.

## 🏗️ Architecture & technologies

```mermaid
flowchart TD
    subgraph Source["📂 Source de données"]
        CSV["CSV BAAC (ONISR)<br/>caract · lieux · usagers · véhicules"]
    end

    subgraph Raw["🦆 DuckDB — RAW Layer"]
        RAW[("raw_caracteristiques<br/>raw_lieux<br/>raw_usagers<br/>raw_vehicules")]
    end

    subgraph DBT["🔧 dbt Core"]
        STG["Staging<br/>stg_caract · stg_lieux<br/>stg_usagers · stg_vehicules"]
        INT["Intermediate"]
        MARTS["Marts<br/>dim_accidents · dim_usagers<br/>dim_vehicules · fact_accidents"]
        DATASET["dataset_baac<br/>(table exposée)"]
    end

    subgraph Analytics["🦆 DuckDB — Analytics Layer"]
        ANA[("analytics.duckdb")]
    end

    subgraph BI["📊 Restitution"]
        PBI["Power BI Dashboard"]
    end

    subgraph CICD["⚙️ CI/CD"]
        GH["GitHub Actions<br/>build · test · docs"]
        PAGES["GitHub Pages<br/>(doc dbt)"]
    end

    CSV --> RAW
    RAW --> STG --> INT --> MARTS --> DATASET
    DATASET --> ANA
    ANA --> PBI

    GH -.déclenché par push/PR.-> STG
    GH --> PAGES

    style Source fill:#e8f4fd,stroke:#1a73e8
    style Raw fill:#fff4e5,stroke:#f57c00
    style DBT fill:#e6f4ea,stroke:#188038
    style Analytics fill:#fff4e5,stroke:#f57c00
    style BI fill:#fce8e6,stroke:#d93025
    style CICD fill:#f3e8fd,stroke:#8430ce
```

| Brique | Rôle |
|---|---|
| **ONISR / BAAC** | Source des données (4 fichiers CSV par millésime) |
| **DuckDB** | Base analytique fichier, sans credentials cloud, adaptée à la CI |
| **dbt Core** | Transformation SQL (staging → intermediate → marts), tests, documentation |
| **Docker** | Environnement dbt reproductible *(en cours d'intégration)* |
| **GitHub Actions** | CI/CD : build, tests, génération et publication de la doc |
| **Power BI** | Restitution finale du dataset agrégé `dataset_baac` |

## 📂 Source de données

**Producteur :** ONISR (Observatoire National Interministériel de la Sécurité Routière)

| Fichier | Contenu |
|---|---|
| `caract-2024.csv` | Caractéristiques de l'accident (date, luminosité, météo, type de collision...) |
| `lieux-2024.csv` | Lieux (catégorie de route, régime de circulation, profil...) |
| `usagers-2024.csv` | Usagers impliqués (gravité, sexe, âge, catégorie...) |
| `vehicules-2024.csv` | Véhicules impliqués (catégorie, manœuvre, obstacle heurté...) |

## 🗂️ Structure du repository

```
BAAC_Analytics/
├── data/                   # CSV sources BAAC (versionnés)
├── models/
│   ├── staging/            # Nettoyage/typage des sources brutes
│   ├── intermediate/       # Logique métier / jointures
│   └── marts/              # Dimensions, faits, dataset exposé
├── tests/
├── macros/
├── snapshots/
├── seeds/
├── analyses/
├── docker/
├── .github/workflows/      # Pipeline CI/CD
├── dbt_project.yml
└── README.md
```

## 📊 Aperçu du rapport Power BI


![Vue d'ensemble](https://github.com/mustaphaoulhaj/BAAC_Analytics/blob/main/docs/images/Page%201.png)

![Analyse de la gravité](https://github.com/mustaphaoulhaj/BAAC_Analytics/blob/main/docs/images/Page%202.png)

![Profil des usagers](https://github.com/mustaphaoulhaj/BAAC_Analytics/blob/main/docs/images/Page%203.png)

![Véhicules et conditions](https://github.com/mustaphaoulhaj/BAAC_Analytics/blob/main/docs/images/Page%204.png)

![Contexte environnemental](https://github.com/mustaphaoulhaj/BAAC_Analytics/blob/main/docs/images/Page%205.png)

![Fiche accident](https://github.com/mustaphaoulhaj/BAAC_Analytics/blob/main/docs/images/Page%206.png)

## ⚙️ CI/CD

À chaque `push` ou `pull request` sur `main`, le workflow [`Dbt.yml`](.github/workflows/Dbt.yml) :

1. Installe dbt-duckdb et lint le SQL (`sqlfluff`)
2. Exécute `dbt deps`, `dbt seed`, `dbt run`, `dbt test`
3. Génère la documentation (`dbt docs generate`)

## 📓 Journal des décisions

| Date | Décision |
|---|---|
| 18/07/2026 | Remplacement de Snowflake par DuckDB pour les couches RAW et Analytics |
| 27/08/2026 | Modèles de staging et marts finalisés ;  démarrage GitHub Actions |
| 28/08/2026 | Dashboard Power BI terminé ; CI/CD GitHub Actions fonctionnelle  |
