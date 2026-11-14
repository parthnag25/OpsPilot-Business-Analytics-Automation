# OpsPilot — Business Analytics & Automation Workbench

### Turning Operational Data into Business Insights, Requirements & Actionable Recommendations

**Python | PostgreSQL | SQL | Power BI | DAX | Business Analytics | Rule-Based Automation | Jira-Style Backlogs**

---

## Project Overview

**OpsPilot** is an end-to-end business analytics and automation project designed to demonstrate how operational data can be transformed into actionable insights, structured business requirements, and improvement recommendations.

The project combines **data engineering, SQL analytics, business intelligence, and business analysis automation** to support data-driven decision-making.

Using a synthetic supply chain dataset, I developed a workflow that:

1. Generates and validates operational datasets using Python.
2. Stores structured data in PostgreSQL.
3. Performs KPI analysis using SQL and analytical views.
4. Visualizes operational performance through five interactive Power BI dashboard pages.
5. Identifies and prioritizes operational risks.
6. Generates preliminary business requirements, root-cause hypotheses, and recommendations using Python.
7. Converts business analysis outputs into structured Jira-style user stories.

The objective is to demonstrate how analytical findings can be translated into business analysis deliverables that support operational improvement planning.

> **Implementation note:** The business analysis automation uses predefined Python rules and text templates. It does not currently use a large language model (LLM), autonomous AI agents, or direct Jira API integration. Generated recommendations and requirements are drafts intended for human review.

---

## Project at a Glance

| Metric | Result |
|---|---:|
| Synthetic datasets | 9 |
| Customer records | 2,000 |
| Product records | 100 |
| Supplier records | 25 |
| Warehouse records | 10 |
| Order records | 25,000 |
| Shipment records | 24,368 |
| Inventory records | 30,000 |
| Return records | 2,405 |
| Power BI dashboard pages | 5 |
| Operational issues identified | 41 |
| Jira-style user stories generated | 41 |

All results are based on synthetic data generated for portfolio demonstration purposes.

---

## Business Problem

Organizations often collect substantial amounts of operational data but face challenges converting that information into decisions and actionable improvement initiatives.

Common challenges include:

- Limited visibility into operational performance.
- Difficulty identifying high-risk business processes.
- Inconsistent KPI definitions across reporting systems.
- Delays in translating analytical findings into business requirements.
- Manual preparation of improvement recommendations and development backlogs.

OpsPilot demonstrates a structured approach to these challenges by connecting **operational analytics with business analysis automation**.

### Key Business Questions

The project addresses the following questions:

1. Which product categories experience the highest inventory stockout exposure?
2. Which warehouses and regions have elevated shipment delays?
3. Which suppliers demonstrate higher delivery delay rates?
4. How do order values, shipment delays, and returns vary across customer segments?
5. Which operational issues should be prioritized for further investigation?
6. How can analytical findings be converted into proposed business requirements and user stories?

---

## Technology Stack

| Technology | Application |
|---|---|
| Python | Synthetic data generation, validation, and automation |
| pandas | Data manipulation and structured output generation |
| NumPy | Synthetic dataset generation |
| PostgreSQL | Relational database management |
| SQL | KPI calculations, joins, aggregation, and analytical views |
| Power BI | Interactive dashboards and business intelligence |
| DAX | Calculated measures and interactive report functionality |
| Power Query | Data connectivity and preparation |
| CSV | Data exchange between workflow components |
| GitHub | Version control and technical documentation |
| Jira-style backlog | Structured user stories and acceptance criteria |

---

## Solution Architecture

```text
                  SYNTHETIC OPERATIONAL DATA
                              |
                              v
                  PYTHON DATA GENERATION
                              |
                              v
                    DATA QUALITY CHECKS
                              |
                              v
                    POSTGRESQL DATABASE
                              |
                              v
                   SQL ANALYTICAL VIEWS
                              |
                  +-----------+-----------+
                  |                       |
                  v                       v
           POWER BI REPORT       OPERATIONAL ISSUE
             5 PAGES               IDENTIFICATION
                                          |
                                          v
                                  ISSUE CANDIDATE CSV
                                          |
                                          v
                                  PYTHON RULE-BASED
                                  BUSINESS ANALYSIS
                                          |
                                          v
                                  STRUCTURED BUSINESS
                                   ANALYSIS OUTPUTS
                                          |
                              +-----------+-----------+
                              |                       |
                              v                       v
                        POWER BI INSIGHTS       JIRA-STYLE
                        & RECOMMENDATIONS       USER STORIES
```

### Workflow Explanation

**Stage 1 — Data Generation**

Python generates nine synthetic operational datasets covering customers, suppliers, products, warehouses, orders, shipments, inventory, returns, and dates.

**Stage 2 — Data Validation**

Automated Python checks evaluate missing values, duplicate identifiers, record counts, and foreign key relationships.

**Stage 3 — Database Development**

Validated datasets are stored in PostgreSQL using relational dimension and fact tables.

**Stage 4 — SQL Analytics**

SQL queries and analytical views calculate operational KPIs, identify performance exceptions, and generate issue candidates.

**Stage 5 — Business Intelligence**

Power BI presents operational performance through five interactive dashboard pages.

**Stage 6 — Business Analysis Automation**

Python applies predefined business rules to generate issue summaries, root-cause hypotheses, proposed requirements, and recommendations.

**Stage 7 — Jira-Style Backlog Generation**

A separate Python script converts the business analysis outputs into a structured CSV containing user stories and acceptance criteria.

**Current limitation:** PostgreSQL loading, issue-candidate extraction, and Power BI source configuration require manual steps. The workflow is not a fully automated production pipeline.

---

# Power BI Dashboard Showcase

The project includes five dashboard pages designed to support executive reporting, operational monitoring, and business analysis.

**Report file:** [`OpsPilot_AI_Dashboard.pbix`](powerbi/OpsPilot_AI_Dashboard.pbix)

**Documentation:** [Power BI Dashboard Documentation](powerbi/powerbi_dashboard_documentation.md)

---

## Dashboard 1 — Executive Overview

![Executive Overview](images/Dahboard%20Images/Executive%20Overview.png)

### Purpose

Provide a consolidated view of operational performance and highlight business areas requiring further investigation.

### Executive KPIs

| KPI | Result |
|---|---:|
| Total Orders | 25,000 |
| Shipped Order Value | $24.88M |
| Order Fulfillment Rate | 97.47% |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |
| Average Shipping Cost per Shipped Order | $19.08 |

### Operational Risk Distribution

| Severity | Issues |
|---|---:|
| High | 6 |
| Medium | 34 |
| Low | 1 |
| **Total** | **41** |

### Business Insights

The dashboard identifies inventory availability, shipment delays, and product returns as areas for operational investigation.

The issue-prioritization visuals help stakeholders distinguish between high-, medium-, and low-severity findings.

Severity classifications are generated using predefined analytical rules and are not stakeholder-approved business priorities.

**Business value:** Consolidates multiple operational KPIs into a single executive reporting interface and supports risk-based investigation.

---

## Dashboard 2 — Inventory & Stockout Risk

![Inventory and Stockout Risk](images/Dahboard%20Images/Inventory%20%26%20Stockout%20Risk.png)

### Purpose

Evaluate inventory availability and identify product categories with elevated stockout exposure.

### Dashboard Features

- Stockout rate by product category.
- Top 10 subcategories by stockout rate.
- Weighted average inventory buffer analysis.
- Total stockout records by category.

### Key Findings

| Metric | Result |
|---|---:|
| Overall Stockout Rate | 31.64% |
| Highest-Risk Category | Grocery |
| Grocery Stockout Rate | 31.93% |
| Highest-Risk Subcategory | Computer Accessories |
| Computer Accessories Stockout Rate | 34.81% |

### Business Interpretation

Grocery and Computer Accessories show elevated stockout exposure in the synthetic dataset.

These results identify areas for further investigation into:

- Replenishment planning.
- Inventory availability.
- Reorder point configuration.
- Stock buffer management.

The observed stockout rates do not independently establish the underlying causes.

**Business value:** Helps analysts identify inventory categories that warrant additional review and supports data-driven replenishment discussions.

---

## Dashboard 3 — Warehouse & Shipment Performance

![Warehouse and Shipment Performance](images/Dahboard%20Images/Warehouse%20%26%20Shipment%20Performance.png)

### Purpose

Analyze shipment reliability and compare warehouse and regional performance.

### Highest Late Shipment Rates

| Warehouse | Late Shipment Rate |
|---|---:|
| Los Angeles Fulfillment Center | 17.13% |
| Columbus Distribution Hub | 16.64% |
| Dallas Distribution Hub | 15.32% |

### Regional Performance

| Region | Late Shipment Rate |
|---|---:|
| West | 14.27% |
| Midwest | 14.23% |
| South | 13.45% |
| Northeast | 9.67% |

### Overall Shipment Metrics

| Metric | Result |
|---|---:|
| Total Shipments | 24,368 |
| Delayed Shipments | 3,212 |
| On-Time Shipments | 21,156 |
| Overall Late Shipment Rate | 13.18% |
| Average Shipment Delay | 0.60 days |

### Business Interpretation

Los Angeles, Columbus, and Dallas recorded the highest late shipment rates among the warehouses analyzed.

These findings suggest opportunities to investigate warehouse processing, fulfillment capacity, shipment scheduling, and carrier coordination.

They do not establish which factors caused the delays.

**Business value:** Supports warehouse performance monitoring and helps prioritize locations for operational investigation.

---

## Dashboard 4 — Supplier & Customer Performance

![Supplier and Customer Performance](images/Dahboard%20Images/Supplier%20%26%20Customer%20Performance.png)

### Purpose

Evaluate supplier delivery reliability and compare customer-segment performance.

### Suppliers with Elevated Delay Rates

| Supplier | Delay Rate |
|---|---:|
| Supplier 17 | 15.60% |
| Supplier 2 | 15.02% |
| Supplier 9 | 14.75% |
| Supplier 20 | 14.31% |
| Supplier 14 | 14.17% |

### Customer Segment Analysis

| Customer Segment | Delayed-Order Rate | Return Rate |
|---|---:|---:|
| Wholesale | 13.20% | 9.98% |
| Retail | 12.82% | 9.48% |
| Enterprise | 12.11% | 9.62% |

Retail recorded the highest total order value among the three customer segments.

### Business Interpretation

Supplier-level comparisons identify vendors with elevated delay rates.

Customer-segment analysis provides additional visibility into order value, delayed orders, and returns.

These descriptive differences can guide further investigation but do not establish causation or statistical significance.

**Business value:** Supports supplier performance reviews, customer-segment reporting, and operational improvement planning.

---

## Dashboard 5 — Business Insights & Recommendations

![Business Insights and Recommendations](images/Dahboard%20Images/AI%20Business%20Insights%20%26%20Recommendations.png)

### Purpose

Demonstrate how operational findings can be converted into structured business analysis deliverables.

### Dashboard Features

Users can select an operational issue to display its associated:

- Root-cause hypothesis.
- Executive recommendation.
- Proposed business requirement.
- Jira-style user story.

The dashboard uses DAX measures, including `SELECTEDVALUE()`, to display issue-specific outputs.

### Example Workflow

```text
Operational Issue Identified
             |
             v
       Risk Classification
             |
             v
      Root-Cause Hypothesis
             |
             v
     Proposed Business Requirement
             |
             v
      Executive Recommendation
             |
             v
       Jira-Style User Story
```

### Implementation

The Python business analysis workflow generates text using predefined conditional rules and templates.

Power BI displays the corresponding outputs based on the selected operational issue.

The existing Power BI page and screenshot retain the original title **AI Business Insights & Recommendations**. This is a legacy display label; the implemented workflow is rule-based rather than LLM-powered.

**Business value:** Demonstrates a repeatable process for connecting analytical findings with draft business requirements, recommendations, and development backlog items.

---

# Technical Implementation

## 1. Python Data Generation

**Script:** [`python/data_generator.py`](python/data_generator.py)

The data generator creates nine synthetic datasets using a fixed random seed.

| Dataset | Records |
|---|---:|
| Date | 731 |
| Suppliers | 25 |
| Products | 100 |
| Warehouses | 10 |
| Customers | 2,000 |
| Orders | 25,000 |
| Shipments | 24,368 |
| Inventory | 30,000 |
| Returns | 2,405 |

The datasets represent simulated operational activity and are not sourced from an actual organization.

## 2. Data Quality Validation

**Script:** [`python/data_quality_checks.py`](python/data_quality_checks.py)

The validation process checks:

- Missing values.
- Duplicate identifiers.
- Expected record counts.
- Foreign key relationships.

**Documentation:** [Data Quality Report](docs/data_quality_report.md)

The implemented checks passed during local project testing.

## 3. PostgreSQL Database

**Database:** `opspilot_ai`  
**Schema:** `opspilot`

The relational model uses dimension and fact tables to organize operational information.

### SQL Scripts

| File | Purpose |
|---|---|
| [`01_create_tables.sql`](sql/01_create_tables.sql) | Create relational tables |
| [`03_kpi_analysis_queries.sql`](sql/03_kpi_analysis_queries.sql) | Operational KPI analysis |
| [`04_create_analytics_views.sql`](sql/04_create_analytics_views.sql) | Reusable reporting views |
| [`05_create_customer_segment_view.sql`](sql/05_create_customer_segment_view.sql) | Customer-segment analytical view |

The customer-segment view aggregates shipment and return information at the order level before joining it with order data.

This avoids multiplying order values through one-to-many joins.

**Important:** The table-creation script contains `DROP TABLE` statements. Do not execute it against an existing populated database without reviewing its effects and creating a backup.

## 4. Business Analysis Automation

**Script:** [`python/ai_business_analyst_workflow.py`](python/ai_business_analyst_workflow.py)

### Input

`data/processed/ai_issue_candidates.csv`

### Output

`data/processed/ai_business_outputs.csv`

The workflow processes identified operational issues and produces structured outputs including:

- Business issue summaries.
- Root-cause hypotheses.
- Proposed requirements.
- Executive recommendations.
- Jira-style epics.
- User stories.
- Acceptance criteria.
- Human-review indicators.

### Verified Results

| Metric | Result |
|---|---:|
| Operational Issues Processed | 41 |
| Structured Business Analysis Records | 41 |

The workflow uses deterministic rules and predefined text templates.

It does not independently verify root causes or execute recommendations.

## 5. Jira-Style Backlog Generation

**Script:** [`python/jira_backlog_generator.py`](python/jira_backlog_generator.py)

**Output:** [`jira/jira_user_stories.csv`](jira/jira_user_stories.csv)

The generator converts business analysis outputs into a structured backlog.

### Generated Backlog

| Metric | Result |
|---|---:|
| Jira-Style User Stories | 41 |
| Generation Method | Rule-based Python automation |
| Output Format | CSV |
| Jira API Integration | Not implemented |

The backlog contains structured stories, priorities, and acceptance criteria.

Each generated story uses a `rule-generated` label to identify the generation method.

The stories are drafts requiring human review before implementation.

**Documentation:** [Jira Backlog Documentation](docs/jira_backlog_documentation.md)

---

# Data Validation & KPI Reconciliation

Data reconciliation was performed to distinguish between total order value and shipped order value.

## Validated Order Counts

| Metric | Value |
|---|---:|
| Total Orders | 25,000 |
| Orders with Shipment Records | 24,368 |
| Orders without Shipment Records | 632 |

## Validated Order Values

| Metric | Value |
|---|---:|
| Total Order Value | $25,502,432.32 |
| Shipped Order Value | $24,880,425.10 |
| Order Value Without Shipment Records | $622,007.22 |

### Reconciliation

```text
Shipped Order Value
+
Order Value Without Shipment Records
=
Total Order Value

$24,880,425.10
+
$622,007.22
=
$25,502,432.32
```

The reconciled values represent different order populations.

**Total order value** includes all recorded orders.

**Shipped order value** includes orders associated with shipment records.

Neither metric should automatically be interpreted as recognized accounting revenue.

### KPI Definition Notes

- **Order fulfillment rate:** The existing executive SQL view calculates the percentage of orders with a status other than `Cancelled`. Validation confirmed that this population matches orders with shipment records in the current synthetic dataset.
- **On-time delivery rate:** Percentage of shipment records with zero delay days.
- **Late shipment rate:** Percentage of shipment records with positive delay days.
- **Stockout rate:** Percentage of inventory records flagged as stockouts.
- **Return rate:** Percentage of orders associated with returns.
- **Average shipping cost per shipped order:** The existing SQL calculation averages shipping cost across shipment records. The validated dataset contains one shipment record per shipped order.

The underlying SQL aliases retain their existing names for compatibility with the Power BI report.

For detailed definitions, see the [Data Dictionary](docs/data_dictionary.md) and [SQL KPI Results Summary](docs/sql_kpi_results_summary.md).

---

# Running the Project

## Prerequisites

- Python.
- PostgreSQL.
- Power BI Desktop for viewing the `.pbix` report.
- Required Python packages listed in `requirements.txt`.

## Step 1 — Install Python Dependencies

From the repository root:

```bash
python -m pip install -r requirements.txt
```

## Step 2 — Generate Synthetic Data

```bash
python python/data_generator.py
```

This generates the synthetic CSV datasets under `data/raw/`.

## Step 3 — Validate Data Quality

```bash
python python/data_quality_checks.py
```

The validation results are written to:

`docs/data_quality_report.md`

## Step 4 — Configure PostgreSQL

Create the local PostgreSQL database and load the generated datasets using the documented schema and load order.

Refer to:

[PostgreSQL Load Validation](docs/postgresql_load_validation.md)

Then apply the analytical SQL scripts.

**Caution:** Review the table-creation script before execution because it includes table-dropping statements.

## Step 5 — Export Operational Issue Candidates

Export the issue candidates generated by the SQL analysis to:

`data/processed/ai_issue_candidates.csv`

This SQL-to-CSV handoff is currently manual.

## Step 6 — Run Business Analysis Automation

```bash
python python/ai_business_analyst_workflow.py
```

The script generates:

`data/processed/ai_business_outputs.csv`

## Step 7 — Generate the Jira-Style Backlog

```bash
python python/jira_backlog_generator.py
```

The script generates:

`jira/jira_user_stories.csv`

**Note:** Running these scripts overwrites the corresponding generated output files.

## Step 8 — Open the Power BI Report

Open:

[`powerbi/OpsPilot_AI_Dashboard.pbix`](powerbi/OpsPilot_AI_Dashboard.pbix)

Power BI Desktop requires access to the configured PostgreSQL source to refresh database-backed visuals.

The report is provided as a project file rather than a publicly hosted Power BI application.

---

# Repository Structure

```text
OpsPilot-Business-Analytics-Automation/
│
├── README.md
├── requirements.txt
│
├── data/
│   ├── raw/
│   └── processed/
│       ├── ai_issue_candidates.csv
│       └── ai_business_outputs.csv
│
├── docs/
│   ├── project_charter.md
│   ├── data_dictionary.md
│   ├── data_quality_report.md
│   ├── dataset_generation_plan.md
│   ├── postgresql_load_validation.md
│   ├── sql_kpi_results_summary.md
│   ├── ai_workflow_documentation.md
│   ├── ai_output_schema.md
│   ├── ai_prompt_template.md
│   └── jira_backlog_documentation.md
│
├── images/
│   └── Dahboard Images/
│       ├── Executive Overview.png
│       ├── Inventory & Stockout Risk.png
│       ├── Warehouse & Shipment Performance.png
│       ├── Supplier & Customer Performance.png
│       └── AI Business Insights & Recommendations.png
│
├── jira/
│   └── jira_user_stories.csv
│
├── powerbi/
│   ├── OpsPilot_AI_Dashboard.pbix
│   └── powerbi_dashboard_documentation.md
│
├── python/
│   ├── data_generator.py
│   ├── data_quality_checks.py
│   ├── ai_business_analyst_workflow.py
│   └── jira_backlog_generator.py
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 03_kpi_analysis_queries.sql
│   ├── 04_create_analytics_views.sql
│   └── 05_create_customer_segment_view.sql
│
└── streamlit_app/
```

---

# Project Documentation

| Document | Description |
|---|---|
| [Project Charter](docs/project_charter.md) | Project objectives, scope, and deliverables |
| [Data Dictionary](docs/data_dictionary.md) | Database tables, fields, relationships, and metrics |
| [Dataset Generation Plan](docs/dataset_generation_plan.md) | Synthetic data generation approach |
| [Data Quality Report](docs/data_quality_report.md) | Data validation checks and results |
| [PostgreSQL Load Validation](docs/postgresql_load_validation.md) | Database loading and validation |
| [SQL KPI Results Summary](docs/sql_kpi_results_summary.md) | KPI results and operational findings |
| [Power BI Documentation](powerbi/powerbi_dashboard_documentation.md) | Dashboard implementation and metrics |
| [Business Analysis Workflow](docs/ai_workflow_documentation.md) | Python automation logic and outputs |
| [Business Analysis Output Schema](docs/ai_output_schema.md) | Structured input and output definitions |
| [Proposed LLM Enhancement](docs/ai_prompt_template.md) | Future LLM design proposal; not implemented |
| [Jira Backlog Documentation](docs/jira_backlog_documentation.md) | User story generation and backlog structure |

---

# Skills Demonstrated

### Business Analysis

- Business problem identification.
- KPI definition and interpretation.
- Operational issue prioritization.
- Root-cause hypothesis development.
- Business requirements documentation.
- User story and acceptance criteria preparation.
- Executive recommendations.
- Stakeholder-oriented reporting.

### Data Analytics

- Python data processing.
- Data quality validation.
- Relational data modeling.
- SQL queries and analytical views.
- Data aggregation and reconciliation.
- Operational KPI analysis.
- Customer segmentation analysis.

### Business Intelligence

- Power BI dashboard development.
- DAX calculations.
- Interactive filtering.
- Conditional formatting.
- Executive KPI reporting.
- Data visualization and storytelling.

### Automation

- Rule-based Python workflows.
- Structured business analysis output generation.
- Automated CSV backlog preparation.
- Repeatable data-processing scripts.
- Human-review checkpoints.

---

# Limitations & Future Enhancements

## Current Limitations

**Synthetic data:** The project uses simulated operational datasets rather than real company records.

**Rule-based automation:** Business analysis outputs are generated using predefined rules and templates, not generative AI.

**Unverified root causes:** Proposed root causes and recommendations require additional evidence and stakeholder validation.

**No direct Jira integration:** User stories are exported to CSV rather than submitted through the Jira API.

**Partly manual workflow:** Database loading, SQL-to-CSV extraction, and Power BI source configuration require manual steps.

**Local reporting environment:** The Power BI report is supplied as a `.pbix` file and is not publicly deployed.

## Potential Enhancements

Future development could include:

1. Automated PostgreSQL data loading and issue-candidate extraction.
2. Automated KPI reconciliation and regression testing.
3. Scheduled Power BI data refresh.
4. Direct Jira API integration.
5. Optional LLM-assisted requirement drafting with validation and human oversight.
6. A deployable interactive reporting application.

These are proposed enhancements rather than features currently implemented.

---

# Project Outcome

OpsPilot demonstrates a structured workflow connecting:

**Data Generation → Data Validation → SQL Analytics → Business Intelligence → Operational Risk Identification → Business Analysis Automation → Jira-Style Backlog Preparation**

The project demonstrates how technical analytics and business analysis practices can be combined to create reusable reporting assets, identify operational improvement opportunities, and prepare structured deliverables for business stakeholders.

The main achievement is not simply producing dashboards, but demonstrating how analytical findings can be translated into proposed business actions and development-ready drafts through a repeatable, documented process.

---

**Project:** OpsPilot — Business Analytics & Automation Workbench  
**Repository:** `OpsPilot-Business-Analytics-Automation`  
**Status:** Portfolio project with locally tested components and documented manual integration steps.
