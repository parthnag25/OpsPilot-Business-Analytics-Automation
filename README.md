# OpsPilot AI | Business Analyst Workbench

### End-to-End Supply Chain Analytics, Business Intelligence & AI-Assisted Business Analysis

**Technologies:**Python | PostgreSQL | SQL | Power BI | DAX | Automated Business Analysis | Jira-Style Backlogs | GitHub

## Project Overview

OpsPilot AI is an end-to-end Business Analytics and AI project designed to transform supply chain operational data into actionable business insights, structured business requirements, and AI-assisted recommendations.

The project demonstrates how a Business Analyst can combine data analysis, business intelligence, and AI-assisted workflows to identify operational problems and translate findings into proposed solutions.

Using synthetic supply chain data, I developed a PostgreSQL analytical database, performed SQL-based KPI analysis, created five interactive Power BI dashboard pages, and implemented Python-based workflows for generating business analysis outputs and Jira-style user stories.

The project focuses on five core operational areas:

- Executive performance monitoring
- Inventory and stockout risk
- Warehouse and shipment performance
- Supplier and customer performance
- AI-assisted business analysis and recommendations

---

## Business Problem

Supply chain organizations generate large volumes of operational data across orders, shipments, inventory, suppliers, warehouses, and customers.

However, identifying performance issues is only one part of the challenge.

Business stakeholders also need to understand potential causes, prioritize risks, define business requirements, and translate improvement opportunities into actionable development tasks.

OpsPilot AI explores how data analytics and AI-assisted business analysis can bridge this gap.

The project addresses questions such as:

- Which product categories face the greatest stockout risk?
- Which warehouses experience the highest late shipment rates?
- Which suppliers contribute to delivery delays?
- Which customer segments generate the most order value?
- How do delayed-order and return rates differ across customer segments?
- How can operational findings be translated into business requirements, recommendations, and Jira user stories?

---

## Project Architecture

The project follows an analytical workflow:

**Synthetic Supply Chain Data**

↓

**Python — Data Generation and Quality Validation**

↓

**PostgreSQL — Relational Database and SQL Analysis**

↓

**Analytical Views and KPI Calculations**

↓

**Power BI — Interactive Business Intelligence Dashboards**

↓

**AI-Assisted Business Analysis**

↓

**Root-Cause Hypotheses, Business Requirements and Executive Recommendations**

↓

**Jira-Style User Stories and Acceptance Criteria**

The workflow demonstrates how operational data can support business decisions and structured delivery planning.

---

# Power BI Dashboard Showcase

The Power BI report contains five dashboard pages designed for operational analysis and business decision support.

**Power BI Report:** [Open the Power BI project files](powerbi/)

## 1. Executive Overview

![Executive Overview](images/Dahboard%20Images/Executive%20Overview.png)

The Executive Overview provides a consolidated view of supply chain performance.

### Key Metrics

| KPI | Value |
|---|---:|
| Total Orders | 25,000 |
| Shipped Order Value | $24.88M |
| Order Fulfillment Rate | 97.47% |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |
| Shipping Cost per Order | $19.08 |

### Business Value

The dashboard provides visibility into operational performance and highlights issues requiring management attention.

It includes severity-based issue prioritization, operational risk classifications, and AI-assisted business recommendations.

---

## 2. Inventory & Stockout Risk

![Inventory and Stockout Risk](images/Dahboard%20Images/Inventory%20%26%20Stockout%20Risk.png)

This dashboard evaluates inventory availability and stockout exposure across product categories and subcategories.

### Analysis Includes

- Stockout rate by product category
- Top 10 subcategories by stockout rate
- Weighted average inventory buffer by category
- Total stockout records by category

### Key Findings

Grocery recorded the highest category-level stockout rate at approximately **31.93%**.

Computer Accessories recorded a subcategory stockout rate of approximately **34.81%**.

These findings identify categories that warrant further inventory planning and replenishment analysis.

---

## 3. Warehouse & Shipment Performance

![Warehouse and Shipment Performance](images/Dahboard%20Images/Warehouse%20%26%20Shipment%20Performance.png)

This dashboard evaluates shipment performance across warehouses and geographic regions.

### Analysis Includes

- Top three warehouses by late shipment rate
- Late shipment rate by region
- Average shipment delay
- Warehouse-level shipment performance
- Conditional formatting for operational risk

### Key Findings

| Warehouse | Late Shipment Rate |
|---|---:|
| Los Angeles Fulfillment Center | 17.13% |
| Columbus Distribution Hub | 16.64% |
| Dallas Distribution Hub | 15.32% |

The dashboard identifies locations with elevated late shipment rates and provides supporting operational metrics for investigation.

---

## 4. Supplier & Customer Performance

![Supplier and Customer Performance](images/Dahboard%20Images/Supplier%20%26%20Customer%20Performance.png)

This dashboard combines supplier delivery performance with customer segment analysis.

### Supplier Analysis

- Top five suppliers by delay rate
- Supplier-level delay performance
- Delayed orders and total orders
- Supplier risk scores
- Conditional risk highlighting

### Customer Analysis

- Order value by customer segment and region
- Delayed-order rate by customer segment
- Return rate by customer segment

### Key Findings

**Supplier Delay Rates**

| Supplier | Delay Rate |
|---|---:|
| Supplier 17 | 15.60% |
| Supplier 2 | 15.02% |
| Supplier 9 | 14.75% |
| Supplier 20 | 14.31% |
| Supplier 14 | 14.17% |

**Customer Segment Performance**

Wholesale recorded the highest delayed-order rate at **13.20%**, followed by Retail at **12.82%** and Enterprise at **12.11%**.

Wholesale also recorded the highest return rate at **9.98%**.

Retail generated the highest overall order value among the three customer segments.

These findings support further investigation into supplier reliability and customer service performance.

---

## 5. AI Business Insights & Recommendations

![AI Business Insights and Recommendations](images/Dahboard%20Images/AI%20Business%20Insights%20%26%20Recommendations.png)

This dashboard demonstrates the AI-assisted Business Analyst workflow developed for OpsPilot AI.

Users can select an operational issue and interactively explore its associated business analysis outputs.

### Interactive Components

**1. Operational Issue Selection**

Users select a business area, issue type, and severity level.

**2. AI-Generated Root-Cause Hypothesis**

Displays potential explanations associated with the selected operational issue.

**3. Executive Recommendation**

Presents a proposed business action based on the identified issue.

**4. Business Requirement**

Translates the operational problem into a proposed business requirement.

**5. Jira User Story**

Expresses the business requirement as a user story from the perspective of an intended stakeholder.

### Business Analyst Workflow

**Operational Issue → Root-Cause Hypothesis → Executive Recommendation → Business Requirement → Jira User Story**

The interactive dashboard demonstrates how analytical findings can be translated into structured business analysis deliverables.

AI-generated hypotheses and recommendations are treated as proposals requiring human validation.

---

# Technical Implementation

## Python — Data Engineering and AI-Assisted Workflows

Python scripts support synthetic data generation, quality validation, AI-assisted business analysis, and Jira-style backlog preparation.

Key files:

- `python/data_generator.py`
- `python/data_quality_checks.py`
- `python/ai_business_analyst_workflow.py`
- `python/jira_backlog_generator.py`

The data generation and validation components provide a foundation for analyzing operational performance without using private customer information.

---

## PostgreSQL & SQL

PostgreSQL is used to store and analyze the synthetic supply chain datasets.

The relational database contains customer, product, supplier, warehouse, and date dimensions alongside operational fact tables.

SQL analysis covers:

- Order and shipment performance
- Inventory availability
- Warehouse delay analysis
- Supplier performance
- Customer segment analysis
- Operational issue identification

Analytical SQL views provide reusable datasets for Power BI reporting.

### SQL Files

- `sql/01_create_tables.sql` — Relational database structure
- `sql/03_kpi_analysis_queries.sql` — KPI analysis
- `sql/04_create_analytics_views.sql` — Analytical views

The completed Power BI model additionally uses a customer segment performance view created in PostgreSQL.

---

## Power BI & DAX

Power BI provides interactive visualizations across five analytical pages.

The report uses DAX calculations and measures for operational metrics, including:

- Supplier delay rates
- Customer delayed-order rates
- Customer return rates
- Weighted inventory calculations
- Warehouse shipment performance
- Interactive AI business analysis outputs

Additional features include sorting, conditional formatting, Top N filtering, and issue-driven interactive cards.

**Report File:** [OpsPilot_AI_Dashboard.pbix](powerbi/OpsPilot_AI_Dashboard.pbix)

---

# AI-Assisted Business Analyst Workflow

The AI-assisted workflow converts identified operational issues into structured business analysis deliverables.

Outputs include:

1. Business issue summaries
2. Root-cause hypotheses
3. Proposed business requirements
4. Executive recommendations
5. Jira-style user stories
6. Acceptance criteria

The purpose is to demonstrate how AI-assisted analysis can support requirements gathering, prioritization, stakeholder communication, and delivery planning.

Generated outputs are intended for review rather than automatic implementation.

---

# Data Validation and KPI Definitions

The project uses synthetic operational data.

Two order-value populations were identified during SQL validation:

| Metric | Value |
|---|---:|
| Total Orders | 25,000 |
| Orders With Shipments | 24,368 |
| Orders Without Shipments | 632 |
| Total Order Value | $25,502,432.32 |
| Shipped Order Value | $24,880,425.10 |

Total Order Value includes all orders, while Shipped Order Value includes orders associated with shipment records.

Distinguishing these populations prevents misleading comparisons between customer order-value analysis and shipment-based reporting.

Additional validation documentation is available in the `docs/` directory.

---

# Repository Structure

```text
OpsPilot-AI-Business-Analyst-Workbench/
│
├── README.md
├── data/
├── docs/
├── images/
│   └── Dahboard Images/
├── jira/
│   └── jira_user_stories.csv
├── powerbi/
│   ├── OpsPilot_AI_Dashboard.pbix
│   └── powerbi_dashboard_plan.md
├── python/
│   ├── ai_business_analyst_workflow.py
│   ├── data_generator.py
│   ├── data_quality_checks.py
│   └── jira_backlog_generator.py
├── sql/
│   ├── 01_create_tables.sql
│   ├── 03_kpi_analysis_queries.sql
│   └── 04_create_analytics_views.sql
└── requirements.txt
```

---

# Project Documentation

Additional documentation is available in the `docs/` directory, including:

- Project charter
- Data dictionary
- Data quality report
- PostgreSQL loading and validation
- SQL KPI results
- AI workflow documentation
- Jira backlog documentation
- Power BI dashboard planning

These documents provide supporting context for the analytical and business analysis components.

---

# Skills Demonstrated

**Business Analysis**
- Business problem identification
- Requirements analysis
- KPI definition
- Root-cause hypothesis development
- User story creation
- Acceptance criteria
- Stakeholder-oriented recommendations

**Data Analytics & Business Intelligence**
- SQL analysis
- PostgreSQL
- Data validation
- Power BI
- DAX
- Dashboard development
- Operational performance reporting

**AI-Assisted Workflows**
- Structured AI-generated business outputs
- AI-assisted requirements documentation
- Executive recommendation generation
- Jira-style backlog preparation

---

# Limitations & Future Improvements

OpsPilot AI is a portfolio demonstration built using synthetic operational data.

The analytical results are illustrative and do not represent the actual performance of a company.

AI-generated hypotheses, requirements, and recommendations require human review before implementation.

Potential future improvements include automated data refresh, additional operational KPIs, enhanced AI output validation, and closer integration with delivery-management tools.

---

## Project Purpose

OpsPilot AI demonstrates how business analytics, SQL, Python, Power BI, and AI-assisted workflows can work together to support operational decision-making.

The project's emphasis is not simply on creating dashboards, but on connecting data analysis to business problems, proposed requirements, and actionable development work..
