┌────────────────────────────────────────────────────────────┐
│                    Public Data Sources                     │
│                                                            │
│  • CMS DE-SynPUF (Claims & Cost)                           │
│  • CDC PLACES (Population Health)                          │
│  • AHRF (Workforce Analytics)                              │
│  • (Future) Digital Engagement / Revenue Cycle Data        │
└────────────────────────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────────────┐
        │            Apache Airflow (Orchestration)        │
        │                                                  │
        │  • Schedules pipelines                           │
        │  • Manages dependencies                          │
        │  • Retries & failure handling                    │
        └──────────────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────────────┐
        │                Python ETL Layer                  │
        │                                                  │
        │  • API / file ingestion                          │
        │  • Data validation & cleaning                    │
        │  • Writes RAW data                               │
        └──────────────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────────────┐
        │              Snowflake Data Warehouse            │
        │                                                  │
        │  • RAW       – ingested source data              │
        │  • STAGING   – cleaned & standardized            │
        │  • ANALYTICS – domain-ready fact & dimension     │
        │                tables                            │
        └──────────────────────────────────────────────────┘
                 │                         │
                 │                         │
                 ▼                         ▼
        ┌──────────────────────┐   ┌──────────────────────┐
        │      dbt Models      │   │     ML Pipelines     │
        │                      │   │                      │
        │ • Transformations    │   │ • XGBoost / EBM      │
        │ • Tests              │   │ • SHAP               │
        │ • Documentation      │   │ • Train & score      │
        └──────────────────────┘   └──────────────────────┘
                 │                         │
                 └─────────────┬───────────┘
                               ▼
        ┌──────────────────────────────────────────────────┐
        │                Analytics Outputs                 │
        └──────────────────────────────────────────────────┘
                 │                         │
                 ▼                         ▼
┌──────────────────────────┐   ┌──────────────────────────┐
│     Power BI Dashboards  │   │      AI Assistant        │
│                          │   │                          │
│ • Claims & Cost          │   │ • Streamlit UI           │
│ • Population Health      │   │ • LLM + RAG              │
│ • Workforce Analytics    │   │ • Natural-language Q&A   │
│ • (Future domains)       │   │ • Explains KPIs & models │
└──────────────────────────┘   └──────────────────────────┘
