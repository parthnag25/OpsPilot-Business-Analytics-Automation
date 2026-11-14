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
| `business_area` | Relevant supplier, warehouse, or product category |
| `metric_name` | Operational performance metric |
| `metric_value` | Recorded KPI value |
| `severity` | Assigned issue severity |
| `severity_rank` | Numeric severity ranking |

### Supported Issue Types

The current implementation contains specific business rules for:

- Product Stockout Risk
- Warehouse Delay Risk
- Supplier Delay Risk

Unrecognized issue types receive generic fallback descriptions.

---

## 7. Python Business Analysis Logic

The workflow uses Python functions to generate structured business analysis outputs.

### 7.1 Stakeholder Identification

The `get_stakeholder()` function maps operational issues to stakeholder roles.

| Issue Type | Stakeholder |
|---|---|
| Product Stockout Risk | Supply Chain Operations Manager |
| Warehouse Delay Risk | Warehouse Operations Manager |
| Supplier Delay Risk | Supplier Performance Manager |
| Other Issues | Business Stakeholder |

### 7.2 Business Issue Summary

The `generate_business_issue_summary()` function creates a standardized description using:

- Business area
- Severity
- Issue type
- Metric name
- Metric value

This provides a consistent summary for operational review.

### 7.3 Root-Cause Hypothesis

The `generate_root_cause_hypothesis()` function selects predefined hypotheses based on the issue type.

Potential hypotheses include:

**Product Stockout Risk**
- Demand planning inaccuracies
- Reorder point configuration
- Supplier replenishment delays
- Inventory planning gaps

**Warehouse Delay Risk**
- Warehouse labor constraints
- Fulfillment bottlenecks
- Inventory availability problems
- Carrier coordination issues

**Supplier Delay Risk**
- Lead-time variability
- Supplier fulfillment inconsistencies
- Limited backup supplier coverage
- Category-specific demand pressure

These are possible explanations, not verified causes.

Additional operational evidence would be required to confirm any hypothesis.

### 7.4 Business Requirements

The `generate_business_requirement()` function creates proposed requirements based on operational risk categories.

The requirements focus on monitoring, identifying, and reviewing elevated operational risks.

### 7.5 Jira-Style Epics

The `generate_jira_epic()` function produces epic titles associated with:

- Inventory availability
- Warehouse shipment reliability
- Supplier delivery reliability

### 7.6 Jira User Stories

The `generate_jira_user_story()` function creates user stories using stakeholder perspectives.

The generated stories follow the general structure:

As a stakeholder, I want a specific monitoring capability so that I can support an operational business objective.

### 7.7 Acceptance Criteria

The `generate_acceptance_criteria()` function creates predefined conditions based on issue type.

The templates include:

- Required operational metrics
- Relevant thresholds
- Severity information
- Analyst review requirements
- Human review before business action

Acceptance criteria are initial proposals and should be reviewed before being used for delivery.

### 7.8 Executive Recommendations

The `generate_executive_recommendation()` function produces proposed management actions.

Recommendations focus on areas such as:

- Inventory planning and replenishment
- Warehouse operations and capacity
- Supplier reliability and lead times

The recommendations are intended to support further investigation.

---

## 8. Output Dataset

The workflow generates:

`data/processed/ai_business_outputs.csv`

### Output Schema

| Field | Description |
|---|---|
| `issue_type` | Operational issue category |
| `business_area` | Relevant operational area |
| `metric_name` | KPI name |
| `metric_value` | KPI value |
| `severity` | Assigned severity |
| `severity_rank` | Numeric severity ranking |
| `business_issue_summary` | Rule-generated issue description |
| `root_cause_hypothesis` | Potential operational explanation |
| `business_requirement` | Proposed business requirement |
| `jira_epic` | Generated epic title |
| `jira_user_story` | Generated stakeholder user story |
| `acceptance_criteria` | Proposed acceptance criteria |
| `executive_recommendation` | Proposed management action |
| `human_review_required` | Human review indicator |

---

## 9. Workflow Execution

### Prerequisites

- Python 3
- pandas
- NumPy
- Required input CSV files

Install dependencies from the project root:

```bash
python -m pip install -r requirements.txt
```

### Execute Business Analysis

```bash
python python/ai_business_analyst_workflow.py
```

The script reads the issue candidate CSV and writes the generated business analysis output.

### Generate Jira-Style Backlog

```bash
python python/jira_backlog_generator.py
```

The script reads the business analysis output and creates the Jira-style backlog CSV.

**Note:** Both scripts overwrite their respective output files when executed.

---

## 10. Execution Results

The workflow was tested locally.

| Validation Item | Result |
|---|---|
| Python dependencies | Available |
| Business analysis script | Executed successfully |
| Operational issue records processed | 41 |
| Business analysis output CSV | Generated successfully |
| Jira backlog generator | Executed successfully |
| Jira-style user stories created | 41 |

These results confirm successful execution of the existing rule-based workflow.

They do not establish that generated hypotheses are factually correct or that the proposed requirements have been approved by stakeholders.

---

## 11. Jira-Style Backlog Generation

The backlog generator reads:

`data/processed/ai_business_outputs.csv`

It creates:

`jira/jira_user_stories.csv`

The output includes:

- Issue keys
- Issue summaries
- Epic names
- User stories
- Acceptance criteria
- Priority
- Status
- Labels
- Business area
- KPI information
- Severity
- Human review requirement

### Priority Mapping

| Severity | Jira-Style Priority |
|---|---|
| High | High |
| Medium | Medium |
| Low | Low |

Generated issue keys follow this format:

`OPSPILOT-1`, `OPSPILOT-2`, and so on.

The keys are locally generated identifiers and do not represent issues created in a live Jira project.

---

## 12. Power BI Integration

The Power BI report includes a page titled:

**AI Business Insights & Recommendations**

This page displays the structured outputs generated by the Python business analysis workflow.

Users can select an operational issue to view:

- Root-cause hypothesis
- Executive recommendation
- Business requirement
- Jira user story

The dashboard uses DAX-based selection measures to display records associated with the selected operational issue.

Although the dashboard retains the AI-themed page title, its current supporting Python implementation uses predefined business rules rather than generative AI.

---

## 13. Human Review and Governance

All generated business analysis outputs require human review.

The workflow explicitly sets:

`human_review_required = True`

This flag indicates that the outputs should not be treated as approved business decisions.

Human reviewers should verify:

1. KPI accuracy
2. Operational context
3. Root-cause assumptions
4. Requirement completeness
5. Acceptance criteria
6. Recommendation feasibility
7. Business priorities

The workflow does not automatically enforce a human approval process.

---

## 14. Current Limitations

The implementation has several limitations:

- It uses predefined rules and templates rather than an LLM.
- It does not independently verify root causes.
- It does not autonomously investigate operational issues.
- It does not create or update Jira issues through an API.
- It does not automatically execute recommendations.
- It does not provide a production approval workflow.
- It uses synthetic operational data.

The generated outputs demonstrate workflow automation and structured business analysis rather than autonomous decision-making.

---

## 15. Future Enhancements

Potential enhancements include:

- Optional LLM integration
- Retrieval-augmented generation using business documentation
- Stronger KPI validation
- Automated PostgreSQL-to-CSV exports
- Direct Jira API integration
- Human approval workflows
- Recommendation confidence and evidence tracking
- Automated workflow testing
- Production-oriented monitoring and logging

These are proposed enhancements and are not part of the current implementation.

---

## 16. Business Analyst Value

The automated workflow demonstrates how Python and structured business logic can support:

- Operational issue identification
- Standardized business analysis documentation
- Requirements drafting
- Stakeholder communication
- Jira-style backlog preparation
- Risk prioritization
- Executive reporting

By connecting SQL-derived operational findings with structured requirements and recommendations, OpsPilot AI demonstrates the relationship between data analysis and business delivery planning.

---

## 17. Conclusion

The OpsPilot AI Automated Business Analyst Workflow demonstrates how operational data can be transformed into structured business analysis deliverables through Python-based automation.

The completed workflow successfully processed 41 operational issues and generated 41 Jira-style user stories.

Its primary contribution is the integration of operational analytics, standardized business documentation, and interactive reporting within a reproducible portfolio project.
