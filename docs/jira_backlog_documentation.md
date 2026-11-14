# OpsPilot AI | Jira-Style Backlog Documentation

## 1. Project Overview

OpsPilot AI is a supply chain analytics and automated business analysis project.

The Jira-style backlog component converts structured business analysis outputs into user stories that can support operational improvement planning.

The workflow demonstrates how findings from SQL-based analysis can be translated into standardized delivery documentation.

The backlog is generated using Python and pandas.

**Implementation clarification:** The current workflow produces a CSV file containing Jira-style user stories. It does not connect to Jira through an API or automatically create issues in a live Jira project.

---

## 2. Business Objective

Operational analysis can identify performance issues such as inventory stockouts, warehouse delays, and supplier reliability problems.

However, translating these findings into clear development tasks requires additional documentation.

The backlog generator supports this process by creating structured records containing:

- Issue summaries
- Epic titles
- User stories
- Acceptance criteria
- Priorities
- Operational context
- Human review indicators

The outputs can serve as drafts for stakeholder discussions and delivery planning.

---

## 3. Technology Stack

| Technology | Purpose |
|---|---|
| Python | Backlog generation |
| pandas | CSV processing and record transformation |
| PostgreSQL | Source operational analysis |
| SQL | Operational issue identification |
| CSV | Backlog storage |
| Jira-style Structure | Story and acceptance criteria organization |
| GitHub | Version control and documentation |

---

## 4. Workflow Architecture

The Jira-style backlog is generated through the following process:

```text
Synthetic Supply Chain Data
             |
             v
PostgreSQL KPI Analysis
             |
             v
Operational Issue Candidates
             |
             v
ai_issue_candidates.csv
             |
             v
Python Business Analysis Workflow
             |
             v
ai_business_outputs.csv
             |
             v
Python Jira Backlog Generator
             |
             v
jira_user_stories.csv
```

The initial business analysis outputs are produced through predefined Python rules.

The Jira backlog generator then transforms these records into a structured CSV.

---

## 5. Input Dataset

The backlog generator reads:

`data/processed/ai_business_outputs.csv`

The input contains structured business analysis records generated from identified operational issues.

### Relevant Input Fields

| Field | Purpose |
|---|---|
| `issue_type` | Operational risk category |
| `business_area` | Affected operational area |
| `metric_name` | Associated KPI |
| `metric_value` | KPI value |
| `severity` | Operational risk severity |
| `jira_epic` | Proposed epic title |
| `jira_user_story` | Proposed stakeholder user story |
| `acceptance_criteria` | Proposed acceptance conditions |
| `human_review_required` | Human review indicator |

These fields are used to prepare backlog records.

---

## 6. Python Implementation

The backlog generator is implemented in:

`python/jira_backlog_generator.py`

The script processes each input record and creates a corresponding backlog entry.

### Main Functions

| Function | Purpose |
|---|---|
| `map_priority()` | Maps severity values to backlog priorities |
| `create_issue_key()` | Generates sequential local issue identifiers |
| `create_summary()` | Creates a short issue summary |
| `create_labels()` | Assigns predefined labels based on issue type |
| `main()` | Reads input data and generates the backlog CSV |

The workflow does not perform autonomous prioritization or create issues directly in Jira.

---

## 7. Priority Mapping

Backlog priorities are assigned based on the severity values already provided by the business analysis workflow.

| Operational Severity | Backlog Priority |
|---|---|
| High | High |
| Medium | Medium |
| Low | Low |

The script uses the `map_priority()` function for this transformation.

Priorities are initial classifications rather than stakeholder-approved delivery priorities.

---

## 8. Issue Key Generation

The generator creates sequential identifiers using the following format:

```text
OPSPILOT-1
OPSPILOT-2
OPSPILOT-3
```

Each input row receives an identifier according to its position in the dataset.

These identifiers are generated locally.

They are not actual Jira issue keys and do not establish that an issue exists in a Jira project.

Because identifiers depend on row order, they may change if the input dataset is reordered.

---

## 9. Issue Summary Generation

The generator creates a summary containing:

- Operational issue type
- Business area
- KPI value

The summary uses the following structure:

```text
{issue_type}: {business_area} - {metric_value}%
```

This provides a standardized description of the operational issue.

---

## 10. Labels and Categorization

The generator assigns labels according to the operational issue type.

### Product Stockout Risk

```text
inventory,stockout,supply-chain,ai-generated
```

### Warehouse Delay Risk

```text
warehouse,late-shipments,operations,ai-generated
```

### Supplier Delay Risk

```text
supplier-risk,delivery-delay,procurement,ai-generated
```

### Other Issue Types

```text
business-analysis,ai-generated
```

**Implementation note:** The existing Python script uses the label `ai-generated`. This label is retained for compatibility with current output files. The actual generation method is rule-based Python automation rather than an LLM.

The label should not be interpreted as evidence of generative AI integration.

---

## 11. Output Dataset

The script generates:

`jira/jira_user_stories.csv`

### Output Schema

| Field | Description |
|---|---|
| `issue_key` | Locally generated sequential identifier |
| `issue_type` | Backlog issue type, set to `Story` |
| `summary` | Generated issue summary |
| `epic_name` | Proposed epic title |
| `user_story` | Proposed stakeholder user story |
| `acceptance_criteria` | Proposed acceptance criteria |
| `priority` | Priority mapped from severity |
| `status` | Initial status, set to `To Do` |
| `labels` | Rule-generated categorization labels |
| `business_area` | Operational area associated with the issue |
| `metric_name` | Associated performance metric |
| `metric_value` | KPI value |
| `severity` | Original operational severity |
| `human_review_required` | Indicator requiring analyst review |

The output contains 14 fields.

---

## 12. User Story Structure

The generated user stories follow a stakeholder-oriented format:

**As a [stakeholder], I want [capability] so that [business benefit].**

Stakeholder roles are assigned by the preceding business analysis workflow.

The stories describe proposed capabilities related to:

- Inventory monitoring
- Warehouse performance monitoring
- Supplier reliability monitoring

These are draft requirements and should be refined with relevant stakeholders before implementation.

---

## 13. Acceptance Criteria

Acceptance criteria are generated by the preceding business analysis workflow.

They may define:

- Required KPI calculations
- Monitoring thresholds
- Required output information
- Operational review requirements
- Human review conditions

The criteria are intended as draft conditions for evaluating a proposed capability.

They do not represent completed testing or formal stakeholder approval.

---

## 14. Workflow Execution

### Prerequisites

- Python 3
- pandas
- `data/processed/ai_business_outputs.csv`

Install dependencies from the project root:

```bash
python -m pip install -r requirements.txt
```

### Generate the Backlog

Run:

```bash
python python/jira_backlog_generator.py
```

### Expected Output

The script creates:

`jira/jira_user_stories.csv`

The script prints the output file location and number of generated records.

**Note:** Running the generator overwrites the existing backlog CSV.

---

## 15. Verified Execution Results

The script was executed successfully during local project testing.

| Validation Item | Result |
|---|---|
| Input business analysis records | 41 |
| Backlog records generated | 41 |
| Output file | `jira_user_stories.csv` |
| Execution status | Successful |
| Runtime errors | None observed |

This confirms that the existing Python script can generate the expected backlog file.

It does not confirm that the stories have been approved or imported into Jira.

---

## 16. Human Review

The output includes:

`human_review_required`

This field is copied from the business analysis input.

The preceding workflow sets the value to `True` for generated records.

The field indicates that backlog entries require human validation.

Recommended review activities include:

1. Verify the operational issue and associated KPI.
2. Confirm the business requirement.
3. Validate the intended stakeholder.
4. Review acceptance criteria for completeness.
5. Confirm delivery priority.
6. Refine the proposed user story.
7. Obtain the relevant stakeholder approval.

The current implementation does not provide an automated approval interface.

---

## 17. Current Limitations

The backlog generator has several limitations:

- It creates CSV records rather than live Jira issues.
- It does not authenticate with the Jira API.
- Issue keys are locally generated.
- Story descriptions use predefined templates.
- Priorities are based directly on severity mappings.
- It does not validate stakeholder approval.
- It does not assign issues to delivery teams.
- It does not track actual development progress.
- The input data is synthetic.

The resulting backlog demonstrates requirements preparation and workflow automation rather than production Jira integration.

---

## 18. Future Improvements

Potential enhancements include:

- Direct Jira API integration
- Jira-compatible CSV import validation
- Stable issue identifiers
- Additional priority scoring based on business impact
- Human approval workflows
- Story assignment and ownership fields
- Backlog deduplication
- Automated acceptance criteria validation
- Optional LLM-assisted drafting with output review

These are proposed enhancements and are not currently implemented.

---

## 19. Business Analyst Value

The Jira-style backlog generator demonstrates the connection between operational analysis and structured delivery documentation.

It highlights practical Business Analyst activities, including:

- Requirements documentation
- User story development
- Acceptance criteria preparation
- Operational issue prioritization
- Backlog organization
- Stakeholder review considerations

The workflow shows how Python automation can help prepare consistent first-draft delivery artifacts from operational data.

---

## 20. Conclusion

The OpsPilot AI Jira-style backlog workflow converts structured operational business analysis outputs into standardized backlog records.

During local testing, the workflow successfully generated 41 Jira-style user stories.

The implementation demonstrates automated requirements preparation using Python and pandas while preserving the need for human validation before business action.
