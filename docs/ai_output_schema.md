# OpsPilot | Automated Business Analysis Output Schema

## 1. Overview

This document defines the input and output schemas used by the OpsPilot automated Business Analyst workflow.

The workflow transforms SQL-derived operational issue candidates into structured business analysis deliverables using Python-based conditional logic and predefined templates.

The implementation does not currently use a large language model (LLM) or autonomous AI agents.

The generated outputs support business analysis documentation, operational risk review, and Jira-style backlog preparation.

---

## 2. Workflow Architecture

The data flows through the following stages:

```text
PostgreSQL Analytical Views
           |
           v
Operational Issue Identification
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
Jira Backlog Generator      Power BI Dashboard
           |
           v
jira_user_stories.csv
```

The Python scripts consume CSV files. The export from PostgreSQL and loading into Power BI are separate steps.

---

## 3. Input Data Source

### PostgreSQL View

`opspilot.vw_ai_issue_candidates`

### Input CSV

`data/processed/ai_issue_candidates.csv`

The input contains operational issues identified through SQL-based analysis.

### Input Schema

| Field | Description |
|---|---|
| `issue_type` | Operational issue category |
| `business_area` | Supplier, warehouse, or product category associated with the issue |
| `metric_name` | Name of the operational KPI |
| `metric_value` | KPI value associated with the issue |
| `severity` | Assigned issue severity |
| `severity_rank` | Numeric ranking used for prioritization |

### Supported Issue Types

The workflow contains specific rules for:

- Product Stockout Risk
- Warehouse Delay Risk
- Supplier Delay Risk

Other issue types receive generic fallback outputs.

---

## 4. Business Analysis Processing

The workflow is implemented in:

`python/ai_business_analyst_workflow.py`

The script reads the issue candidate CSV and processes each record independently.

For every issue, it generates structured documentation using predefined Python functions.

### Processing Functions

| Function | Purpose |
|---|---|
| `get_stakeholder()` | Identifies the stakeholder role |
| `generate_business_issue_summary()` | Creates a standardized issue description |
| `generate_root_cause_hypothesis()` | Selects potential root-cause explanations |
| `generate_business_requirement()` | Produces a proposed business requirement |
| `generate_jira_epic()` | Generates a Jira-style epic title |
| `generate_jira_user_story()` | Creates a stakeholder-oriented user story |
| `generate_acceptance_criteria()` | Generates proposed acceptance criteria |
| `generate_executive_recommendation()` | Produces a proposed management action |

The script uses issue-type conditions to determine which text templates apply.

---

## 5. Output Data Source

### Output CSV

`data/processed/ai_business_outputs.csv`

This file contains the structured business analysis outputs produced by the Python workflow.

### Output Schema

| Field | Description | Generation Method |
|---|---|---|
| `issue_type` | Operational risk category | Copied from input |
| `business_area` | Operational area associated with the issue | Copied from input |
| `metric_name` | KPI name | Copied from input |
| `metric_value` | KPI value | Copied from input |
| `severity` | Assigned severity | Copied from input |
| `severity_rank` | Numeric severity ranking | Copied from input |
| `business_issue_summary` | Standardized issue description | Rule-based text generation |
| `root_cause_hypothesis` | Potential explanation for the issue | Predefined hypothesis template |
| `business_requirement` | Proposed business requirement | Issue-specific template |
| `jira_epic` | Jira-style epic title | Python string formatting |
| `jira_user_story` | Stakeholder-oriented user story | Issue-specific template |
| `acceptance_criteria` | Proposed criteria for evaluating the requirement | Predefined criteria |
| `executive_recommendation` | Proposed management action | Issue-specific template |
| `human_review_required` | Indicator that human review is required | Set to `True` |

The output contains 14 fields.

---

## 6. Root-Cause Hypothesis Generation

Root-cause hypotheses are selected according to the operational issue type.

### Product Stockout Risk

Potential explanations include:

- Inaccurate demand planning
- Reorder points set too low
- Supplier replenishment delays
- Inventory planning gaps

### Warehouse Delay Risk

Potential explanations include:

- Labor constraints
- Fulfillment bottlenecks
- Inventory availability problems
- Order processing delays
- Carrier coordination issues

### Supplier Delay Risk

Potential explanations include:

- Supplier lead-time variability
- Inconsistent supplier fulfillment
- Limited backup supplier coverage
- Product-category demand pressure

These are hypotheses rather than independently verified root causes.

---

## 7. Business Requirements

The workflow generates proposed business requirements based on the issue category.

Requirements focus on operational monitoring and identification of elevated risks.

For example, a product stockout issue results in a requirement describing the need to identify categories with high stockout rates and flag them for replenishment review.

These requirements are first drafts and require stakeholder validation before implementation.

---

## 8. Jira-Style User Stories

The workflow creates user stories using stakeholder roles determined by issue type.

The general structure is:

**As a [stakeholder], I want [capability] so that [business benefit].**

Generated user stories are included in the business analysis output and subsequently used by the Jira backlog generator.

The workflow does not directly create issues in a Jira instance.

---

## 9. Acceptance Criteria

Acceptance criteria are generated using predefined rules.

They include:

- Required KPI calculations
- Issue-specific thresholds
- Severity information
- Recommended analyst actions
- Human review requirements

The criteria are intended to provide a starting point for requirements discussions.

They have not been independently approved by business stakeholders.

---

## 10. Human Review Indicator

Every generated business analysis record includes:

`human_review_required = True`

This indicates that generated outputs require human review before business action.

The field is an indicator rather than an automated approval mechanism.

The current implementation does not include a user interface or system process for recording approval decisions.

---

## 11. Output Validation

The Python workflow was executed successfully using the existing operational issue candidate dataset.

### Execution Results

| Validation Item | Result |
|---|---|
| Input operational issues | 41 |
| Output business analysis records | 41 |
| Output CSV generated | Yes |
| Jira-style stories generated | 41 |
| Workflow execution errors | None observed |

The execution confirms that the workflow processes records and generates its expected output files.

It does not independently validate the business correctness of generated recommendations.

---

## 12. Execution Instructions

From the project root, install the required Python dependencies:

```bash
python -m pip install -r requirements.txt
```

Execute the business analysis script:

```bash
python python/ai_business_analyst_workflow.py
```

Generate the Jira-style backlog:

```bash
python python/jira_backlog_generator.py
```

Both scripts overwrite their respective output CSV files when executed.

---

## 13. Limitations

The current implementation has the following limitations:

- Business analysis text is generated using predefined templates.
- The workflow does not call an LLM.
- Root-cause hypotheses are not independently verified.
- Business requirements require stakeholder review.
- Jira issues are not created through an API.
- Generated recommendations are not automatically implemented.
- The project uses synthetic supply chain data.

---

## 14. Future Enhancements

Potential improvements include:

- Optional generative AI integration
- Structured output validation
- Automated testing of schema consistency
- Recommendation evidence tracking
- Confidence scoring supported by evaluation
- Direct Jira API integration
- Human approval workflows

These are proposed enhancements rather than implemented functionality.

---

## 15. Summary

The OpsPilot output schema provides a structured interface between SQL-derived operational issues, Python-based business analysis automation, Power BI reporting, and Jira-style backlog preparation.

The current workflow successfully processes 41 operational issue records and generates 41 corresponding business analysis outputs.

Its main contribution is consistent, reproducible generation of structured business analysis documentation using Python and predefined business rules.
