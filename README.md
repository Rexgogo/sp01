# SP01 Modular Data Pipeline for Operational & Membership Analytics

## Project Overview
This project implements an end-to-end analytics workflow that automates data E(T)L and data modeling processes(T). It integrates operational, channel performance and recharge record etc. from a live-streaming platform, and delivers actionable KPIs through interactive dashboards.

The project contain Python ETL scripts, dbt for data modeling in BigQuery, containerization via Docker, and Superset for data visualization. The goal is to build a scalable, maintainable, and cost-efficient analytics solution using open-source tools.

## Table of Contents
1. [Project Structure](#project-structure)  
2. [Tech Stack](#tech-stack)  
3. [Environment Setup](#environment-setup)  
4. [Data Workflow (ETL)](#data-workflow-etl)  
5. [Data Modeling with dbt](#data-modeling-with-dbt)  
6. [Superset Dashboards](#superset-dashboards)  
7. [Version Control Strategy](#version-control-strategy)  
8. [Debugging Notes & Lessons Learned](#debugging-notes--lessons-learned)  
9. [Future Enhancements](#future-enhancements)  
10. [Contact](#contact)  

## Project Structure
```bash
SP01/
├── ETL_workspace/
│   ├── scripts/
│   │   ├── raw_data/                # Google Drive raw files
│   │   ├── pipeline_top_up.py
│   │   ├── pipeline_op_stats.py
│   └── main.py                      # Calls all pipelines
├── dags/                            # Airflow DAGs
├── dbt/
│   ├── models/
│   ├── snapshots/
│   └── tests/
├── dashboards/
│   └── superset_dashboard.json
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
└── README.md
```

Each component is modular and easily testable, supporting better debugging, scalability, and collaboration.

## Data Stack
| Category          | Tool/Library      | Purpose                                               |
|-------------------|-------------------|--------------------------------------------------------|
| Language          | Python             | ETL scripting and orchestration                       |
| Orchestration     | Apache Airflow     | Schedule and monitor daily ETL tasks                  |
| Containerization  | Docker & Compose   | Standardize and deploy analytics environments         |
| Transformation    | dbt-core           | SQL-based data modeling, testing, and documentation   |
| Warehouse         | BigQuery           | Scalable storage and analytics engine                 |
| Visualization     | Apache Superset    | KPI dashboards for business insights                  |
| Version Control   | Git + GitHub       | Project tracking, collaboration, and documentation    |

## Environment Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/yourname/SP01-data-pipeline.git
   cd SP01-data-pipeline
   ```

2. Add your environment variables in `.env`:
   ```env
   POSTGRES_USER=sp01
   POSTGRES_PASSWORD=12345
   POSTGRES_DB=sp01_db_postgres
   GOOGLE_CREDENTIAL_PATH=/app/credentials/google_drive.json
   ```

3. Start containers:
   ```bash
   docker-compose up --build
   ```

4. Access Superset: `http://localhost:8088`

## Data Workflow (ETL)
The ETL pipeline is modularized into `extract`, `transform`, and `load` layers.

- **Extract**:  
  Uses Google Drive API and local file readers to fetch `.xlsx` reports across four data domains (`top_up`, `pre_deduction`, `post_deduction`, `op_stats`).

- **Transform**:  
  Standardizes schema, renames columns, generates derived fields (e.g., `is_repeat_topup`, `topup_day_segment`), and handles missing/dirty data using `pandas`.

- **Load**:  
  Writes processed data into:
  - Local PostgreSQL (for Airflow/Superset development)
  - BigQuery datasets (for dbt transformations and analytics)

- **Schedule**:  
  `main.py` runs all pipelines, and is orchestrated daily using Apache Airflow at `10:00 AM`.

## Data Modeling with dbt
This project adopts a layered dbt modeling strategy:

- **Staging Layer**:  
  Clean raw wide tables from BigQuery using consistent naming conventions and data types.

- **Intermediate Layer**:  
  Split wide tables into:
  - Fact tables: `fct_topup`, `fct_user_activity`
  - Dimension tables: `dim_users`, `dim_channels`, etc.

- **Mart Layer**:  
  Create business-ready models, e.g., user top-up funnel, channel performance, and retention.

- **Tests & Documentation**:  
  - Primary key uniqueness (`unique`)
  - Foreign key consistency (`relationships`)
  - Null checks (`not_null`)
  - Auto-generate docs using `dbt docs generate`

## Superset Dashboards
KPI dashboards are designed to answer:
- Daily active user behavior
- Membership upgrade/drop-off patterns
- Channel-wise top-up effectiveness
- Operational trend deviations (pre- vs post-deductions)

💡 Superset connects to BigQuery directly via OAuth and pulls from `BI_LAYER` models.

## Version Control Strategy
To maintain clean, scalable collaboration:

### Branching Strategy
| Branch        | Purpose                       |
|---------------|-------------------------------|
| `main`        | Stable production release      |
| `develop`     | Feature integration            |
| `feature/xxx` | New ETL logic or modeling unit |
| `bugfix/xxx`  | Specific issue patches         |

### Commit Convention (Conventional Commits)
```bash
feat(etl): add segmentation logic to topup pipeline  
fix(dbt): resolve join ambiguity in channel models  
chore(env): update .env for Google credentials path  
```

## Debugging Notes & Lessons Learned
| Date       | Issue                                               | Fix/Resolution                                             | Status  |
|------------|-----------------------------------------------------|-------------------------------------------------------------|---------|
| 2025-03-25 | Airflow container exits right after `init`         | Expected behavior; use `airflow webserver` to stay active  | ✅       |
| 2025-03-26 | dbt couldn't connect to BigQuery via local CLI     | Set `DBT_PROFILES_DIR` to point to local `~/.dbt` config   | ✅       |
| 2025-03-27 | Superset OAuth failed on localhost                 | Updated credentials and enabled localhost URI              | ✅       |

## Future Enhancements
- [x] Modularize and orchestrate daily pipelines  
- [x] SLA monitoring and email notification via Airflow  
- [ ] Add Great Expectations for cross-table validation  
- [ ] Migrate data pipeline to GCP Composer & Cloud Run  

## Contact
> Developed and maintained by **[Your Name]**, passionate about building reliable, low-cost data environments using open-source tools.

- 📧 Email: your_email@example.com  
- 🧑‍💻 LinkedIn: [your-link]  
- 📂 GitHub: [your-github-profile]
