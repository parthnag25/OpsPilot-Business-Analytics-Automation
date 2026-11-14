# OpsPilot AI | Project Charter

## 1. Project Information

**Project Name:** OpsPilot AI — Business Analyst Workbench

**Project Type:** End-to-End Business Analytics and Workflow Automation Portfolio Project

**Business Domain:** Supply Chain Operations

**Implementation Status:** Completed portfolio demonstration

**Primary Technologies:** Python, PostgreSQL, SQL, Power BI, DAX, pandas, NumPy

**Supporting Technologies:** Rule-Based Automation, Jira-Style Backlog Generation, GitHub

---

## 2. Executive Summary

OpsPilot AI is an end-to-end supply chain analytics and automated business analysis project developed to demonstrate how operational data can be transformed into business insights, structured requirements, and proposed improvement actions.

The project combines synthetic supply chain datasets, PostgreSQL analytical views, Power BI dashboards, and Python-based automation.

Its primary objective is to connect operational performance monitoring with standardized business analysis documentation.

The completed implementation includes five Power BI dashboard pages, operational issue identification, rule-generated business analysis outputs, and Jira-style user story generation.

The project uses synthetic data and is designed as a portfolio demonstration rather than a production deployment.

---

## 3. Business Problem

Supply chain organizations collect operational information across inventory, suppliers, warehouses, shipments, customers, and orders.

However, identifying performance issues does not automatically translate those findings into actionable business requirements.

Operational challenges may include:

- Inventory stockouts
- Late shipments
- Supplier delivery delays
- Warehouse fulfillment inefficiencies
- Customer returns
- Inconsistent operational performance reporting

Business stakeholders need structured information to understand these issues, prioritize investigations, and develop improvement initiatives.

OpsPilot AI addresses this challenge by combining analytical reporting with automated business analysis documentation.

---

## 4. Project Objectives

The project aims to:

1. Generate realistic synthetic supply chain datasets.
2. Validate data completeness and relational integrity.
3. Store operational information in PostgreSQL.
4. Develop reusable SQL queries and analytical views.
5. Define and calculate operational KPIs.
6. Build interactive Power BI dashboards.
7. Identify and classify operational issues.
8. Generate preliminary root-cause hypotheses.
9. Prepare proposed business requirements and recommendations.
10. Generate Jira-style user stories and acceptance criteria.
11. Document the implementation in GitHub.

### Success Criteria

| Objective | Success Indicator |
|---|---|
| Data generation | Nine synthetic datasets generated |
| Data validation | Implemented quality checks pass |
| Database development | Operational tables and analytical views available |
| KPI analysis | Major supply chain metrics calculated |
| Business intelligence | Five Power BI dashboard pages completed |
| Issue identification | Operational issues classified and exported |
| Workflow automation | Business analysis outputs generated |
| Backlog preparation | Jira-style user stories exported |
| Documentation | Technical and business documentation maintained in GitHub |

---

## 5. Project Scope

### In Scope

The completed project includes:

- Synthetic operational data generation
- Data quality checks
- PostgreSQL database development
- SQL-based KPI calculations
- Analytical views
- Power BI dashboard development
- DAX measures
- Operational issue identification
- Rule-based business analysis automation
- Root-cause hypothesis generation
- Proposed business requirements
- Executive recommendations
- Jira-style user stories and acceptance criteria
- GitHub documentation

### Out of Scope

The current implementation does not include:

- Production ERP integration
- Live enterprise operational data
- Autonomous AI agents
- Active LLM API integration
- Automated business decision execution
- Direct Jira API integration
- Production workflow orchestration
- Automated stakeholder approval
- Production Power BI Service deployment

These capabilities may be explored in future versions.

---

## 6. Target Stakeholders

The project is designed around the information needs of the following stakeholder roles:

| Stakeholder | Primary Interest |
|---|---|
| Business Analyst | Operational problems, requirements, recommendations |
| Operations Manager | Fulfillment and shipment performance |
| Supply Chain Analyst | Inventory and supplier performance |
| BI Analyst | KPI definitions, reporting, data quality |
| Product Owner | User stories, acceptance criteria, priorities |
| Leadership Team | Executive KPIs and operational risk summaries |

These are representative stakeholder roles. The project does not claim formal validation by an actual business stakeholder group.

---

## 7. Core Business Questions

The analytical solution is designed to explore:

1. What is the overall supply chain performance?
2. Which product categories experience elevated stockout rates?
3. Which warehouses have the highest late shipment rates?
4. Which suppliers demonstrate elevated delivery delay rates?
5. How does shipment performance differ across regions?
6. Which customer segments generate the highest order value?
7. How do shipment delays and returns differ across customer segments?
8. Which operational issues should receive further investigation?
9. What business requirements could address the identified issues?
10. What recommendations and Jira-style user stories could support improvement planning?

---

## 8. Project Deliverables

### 8.1 Synthetic Supply Chain Data

Nine operational datasets covering:

- Date
- Supplier
- Product
- Warehouse
- Customer
- Orders
- Shipments
- Inventory
- Returns

### 8.2 PostgreSQL Database

A relational database containing dimension and fact tables.

**Database:** `opspilot_ai`

**Schema:** `opspilot`

### 8.3 SQL Analysis

SQL scripts supporting:

- Database table creation
- Operational KPI calculations
- Analytical view creation
- Customer segment performance analysis

### 8.4 Power BI Dashboards

Five completed dashboard pages:

1. Executive Overview
2. Inventory & Stockout Risk
3. Warehouse & Shipment Performance
4. Supplier & Customer Performance
5. AI Business Insights & Recommendations

The fifth page retains its original title, but its business analysis outputs are generated using predefined Python rules rather than an LLM.

### 8.5 Automated Business Analysis

A Python workflow that processes SQL-derived operational issues and generates:

- Business issue summaries
- Root-cause hypotheses
- Proposed business requirements
- Jira-style epics
- Jira-style user stories
- Acceptance criteria
- Executive recommendations

### 8.6 Jira-Style Backlog

A CSV-based backlog containing structured user stories and supporting business information.

The workflow does not create issues directly in Jira.

### 8.7 GitHub Documentation

Documentation covering:

- Project architecture
- Data definitions
- Data validation
- SQL analysis
- Business analysis automation
- Output schemas
- Jira-style backlog generation
- Power BI implementation

---

## 9. Project Architecture

```text
Synthetic Supply Chain Data
             |
             v
Python Data Generation
             |
             v
Data Quality Validation
             |
             v
PostgreSQL Database
             |
             v
SQL KPI Analysis
             |
             +--------------------------+
             |                          |
             v                          v
Power BI Analytical Views     Operational Issue Candidates
             |                          |
             |                          v
             |                  Python Rule-Based Workflow
             |                          |
             |                          v
             |                  Business Analysis Outputs
             |                          |
             |                +---------+---------+
             |                |                   |
             v                v                   v
       Power BI Report   Business Insights   Jira-Style Backlog
```

The project uses separate processing steps rather than a fully orchestrated production pipeline.

---

## 10. Technology Stack

| Technology | Role |
|---|---|
| Python | Data generation and workflow automation |
| pandas | Structured data processing |
| NumPy | Synthetic data generation |
| PostgreSQL | Relational database |
| SQL | KPI calculations and analytical views |
| Power BI | Business intelligence dashboards |
| DAX | Interactive measures |
| Power Query | Data connection and preparation |
| CSV | Data exchange between workflow components |
| GitHub | Version control and documentation |

---

## 11. Implemented Workflow

### Stage 1 — Data Generation

Python generates synthetic operational datasets.

### Stage 2 — Data Validation

A Python validation script checks the datasets for missing values, duplicate identifiers, and foreign key inconsistencies.

### Stage 3 — Database Development

The operational datasets are stored in PostgreSQL.

### Stage 4 — SQL Analysis

SQL queries and analytical views calculate operational metrics and identify issues.

### Stage 5 — Business Intelligence

Power BI visualizes operational KPIs across five dashboard pages.

### Stage 6 — Business Analysis Automation

Python-based conditional rules generate preliminary business analysis documentation for identified issues.

### Stage 7 — Backlog Generation

A second Python script converts business analysis outputs into Jira-style user stories.

### Stage 8 — Documentation

Project files, implementation details, and analytical results are maintained in GitHub.

---

## 12. Verified Project Results

The completed project was tested locally.

### Data Generation

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

### Workflow Automation

| Metric | Result |
|---|---:|
| Operational issues processed | 41 |
| Jira-style user stories generated | 41 |
| Power BI dashboard pages | 5 |

### Operational Performance

| Metric | Result |
|---|---:|
| Order Fulfillment Rate | 97.47% |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |

These metrics describe synthetic operational data and do not represent actual business performance.

---

## 13. Assumptions and Constraints

### Assumptions

- Synthetic data provides a suitable environment for demonstrating analytics and business analysis techniques.
- Predefined operational rules can support initial issue prioritization.
- Structured templates can improve consistency in draft business analysis documentation.
- Human review is required before recommendations are accepted as business decisions.

### Constraints

- No production operational data is used.
- Root-cause hypotheses are not independently confirmed.
- Operational severity thresholds are predefined.
- Generated requirements have not been approved by actual business stakeholders.
- The workflows require manual execution.
- The project does not contain a live Jira integration.
- The current implementation does not use LLM-generated outputs.

---

## 14. Risks and Mitigation

| Risk | Potential Impact | Mitigation |
|---|---|---|
| Misleading KPI definitions | Incorrect business interpretation | Document calculations and reconcile totals |
| Incorrect data joins | Duplicated records or inflated metrics | Aggregate fact data before joining where necessary |
| Unverified root-cause hypotheses | Unsupported business conclusions | Label outputs as hypotheses |
| Rule-generated recommendations | Limited contextual understanding | Require human validation |
| Synthetic data limitations | Reduced real-world generalizability | Clearly disclose data origin |
| Manual processing steps | Reproduction errors | Document execution instructions |
| Unapproved business requirements | Misaligned delivery priorities | Treat outputs as drafts |

---

## 15. Governance and Human Review

The workflow generates preliminary analysis outputs rather than approved business decisions.

Each business analysis output includes:

`human_review_required = True`

This identifies records requiring further review.

Recommended review activities include:

- Verify underlying KPIs.
- Validate operational context.
- Assess root-cause hypotheses.
- Review requirement completeness.
- Confirm acceptance criteria.
- Evaluate recommendation feasibility.
- Obtain relevant stakeholder approval.

The current implementation includes a review indicator but does not implement an automated approval process.

---

## 16. Future Enhancements

Potential future improvements include:

### Data Engineering

- Automated data refresh
- Pipeline orchestration
- Expanded data validation
- Historical operational data processing

### Business Intelligence

- Power BI Service deployment
- Historical KPI trends
- Target-based monitoring
- Additional operational metrics

### Business Analysis Automation

- Optional LLM integration
- Structured output validation
- Evidence-based hypothesis generation
- Human approval workflows
- Direct Jira API integration

These capabilities are proposed enhancements rather than features of the current implementation.

---

## 17. Project Outcome

OpsPilot AI demonstrates how operational data can be transformed into structured business insights and preliminary delivery documentation.

The completed implementation combines:

- Synthetic data engineering
- PostgreSQL database development
- SQL-based operational analysis
- Power BI reporting
- Python workflow automation
- Business requirements drafting
- Jira-style backlog generation

The project successfully processed 41 operational issues and generated 41 Jira-style user stories during local testing.

Its primary contribution is demonstrating a connected approach to operational analytics and business analysis within a single portfolio project.

---

## 18. Related Documentation

- [Project README](../README.md)
- [Power BI Dashboard Documentation](../powerbi/powerbi_dashboard_documentation.md)
- [Automated Business Analyst Workflow](ai_workflow_documentation.md)
- [Business Analysis Output Schema](ai_output_schema.md)
- [Jira-Style Backlog Documentation](jira_backlog_documentation.md)
- [SQL KPI Results Summary](sql_kpi_results_summary.md)
- [PostgreSQL Load Validation](postgresql_load_validation.md)

---

## 19. Conclusion

OpsPilot AI is a completed supply chain analytics and automated business analysis portfolio project.

It demonstrates how Python, PostgreSQL, SQL, Power BI, and structured automation can support operational performance analysis and business requirements preparation.

The project provides a practical example of connecting business intelligence with preliminary business analysis outputs while maintaining transparency about implementation limitations and the need for human review.
