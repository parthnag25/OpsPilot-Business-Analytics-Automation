# OpsPilot AI | Automated Business Analyst Workflow Documentation

## 1. Project Overview

OpsPilot AI is a supply chain analytics and automated business analysis project that combines Python, PostgreSQL, SQL, and Power BI to analyze operational performance and generate structured business analysis deliverables.

The automated Business Analyst workflow transforms identified operational issues into:

- Business issue summaries
- Root-cause hypotheses
- Proposed business requirements
- Jira-style epics
- Jira-style user stories
- Acceptance criteria
- Executive recommendations

The workflow is implemented using Python-based conditional rules and predefined text templates.

**Implementation clarification:** The current workflow does not invoke a large language model (LLM), use autonomous AI agents, or automatically create issues in Jira.

---

## 2. Business Problem

Supply chain operations generate large volumes of data related to inventory, warehouses, shipments, suppliers, and customers.

Although reporting tools can identify operational problems, translating those problems into business requirements and actionable work items often requires additional analysis and documentation.

OpsPilot AI demonstrates how structured automation can assist with this process.

The objective is to connect operational performance analysis with standardized business analysis outputs.

---

## 3. Workflow Objectives

The automated workflow is designed to:

1. Read operational issues identified through SQL analysis.
2. Interpret the issue type and business area.
3. Generate standardized business issue summaries.
4. Produce potential root-cause hypotheses.
5. Create proposed business requirements.
6. Generate Jira-style user stories and acceptance criteria.
7. Provide executive recommendations.
8. Flag generated records for human review.

The workflow reduces the need to manually prepare repetitive first-draft business analysis documentation.

It does not independently validate root causes or execute operational improvements.

---

## 4. Technology Stack

| Technology | Purpose |
|---|---|
| Python | Workflow automation and business logic |
| pandas | CSV processing and structured data manipulation |
| PostgreSQL | Storage and SQL-based operational analysis |
| SQL | KPI calculations and issue identification |
| Power BI | Interactive visualization and business reporting |
| DAX | Interactive dashboard measures |
| CSV | Storage of generated business analysis outputs |
| Jira-style Backlog | Structured user stories and acceptance criteria |
| GitHub | Source code and documentation |

---

## 5. Workflow Architecture

The workflow follows these stages:

### Stage 1 — Operational Data

Synthetic supply chain datasets contain information about orders, products, customers, suppliers, warehouses, shipments, inventory, and returns.

### Stage 2 — SQL Analysis

PostgreSQL analytical views calculate operational KPIs and identify issues requiring attention.

The issue identification view is:

`opspilot.vw_ai_issue_candidates`

### Stage 3 — Issue Candidate Export

Issue records are made available to the Python workflow through:

`data/processed/ai_issue_candidates.csv`

### Stage 4 — Automated Business Analysis

The Python script:

`python/ai_business_analyst_workflow.py`

processes issue records using predefined conditional logic.

### Stage 5 — Structured Business Analysis Output

The script generates:

`data/processed/ai_business_outputs.csv`

### Stage 6 — Jira-Style Backlog Generation

The script:

`python/jira_backlog_generator.py`

converts the structured business analysis output into:

`jira/jira_user_stories.csv`

### Stage 7 — Power BI Visualization

The generated business analysis output can be explored through the interactive Business Insights & Recommendations dashboard.

### Workflow Summary

```text
Synthetic Supply Chain Data
          |
          v
PostgreSQL Database
          |
          v
SQL KPI Analysis
          |
          v
Operational Issue Candidates
          |
          v
ai_issue_candidates.csv
          |
          v
Python Rule-Based Business Analysis
          |
          v
ai_business_outputs.csv
          |
          +----------------------+
          |                      |
          v                      v
Jira-Style Backlog         Power BI Insights
          |
          v
jira_user_stories.csv
```

The PostgreSQL-to-CSV export and Power BI data-loading steps are separate from the Python generation scripts.

---

## 6. Input Dataset

The business analysis workflow reads:

`data/processed/ai_issue_candidates.csv`

### Input Fields

| Field | Description |
|---|---|
| `issue_type` | Operational risk category |
