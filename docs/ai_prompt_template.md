# OpsPilot | Proposed LLM Prompt Template

## 1. Overview

This document describes a proposed large language model (LLM) prompt design for a potential future enhancement to OpsPilot.

OpsPilot currently uses Python-based conditional logic and predefined templates to generate structured business analysis outputs.

The prompt described here is a design reference. It is **not executed by the current Python workflow**.

The purpose of this document is to demonstrate how an LLM could potentially support business analysis activities while maintaining structured outputs and human oversight.

---

## 2. Current Implementation

The current business analysis workflow is implemented in:

`python/ai_business_analyst_workflow.py`

It reads operational issues from:

`data/processed/ai_issue_candidates.csv`

The Python script uses predefined rules to generate:

- Business issue summaries
- Root-cause hypotheses
- Proposed business requirements
- Jira-style epics
- Jira-style user stories
- Acceptance criteria
- Executive recommendations

The results are saved to:

`data/processed/ai_business_outputs.csv`

The current implementation does not use an LLM API, autonomous agents, or an external AI service.

---

## 3. Proposed LLM Enhancement

A future LLM integration could be designed to transform operational findings into structured draft business analysis deliverables.

Potential objectives include:

- Generating issue-specific analytical narratives
- Suggesting multiple potential root causes
- Drafting business requirements
- Proposing Jira-style user stories
- Generating acceptance criteria
- Producing executive recommendations
- Highlighting assumptions and missing information

All outputs would require validation before use.

---

## 4. Proposed Input Fields

The proposed prompt would receive structured records derived from:

`opspilot.vw_ai_issue_candidates`

| Input Field | Description |
|---|---|
| `issue_type` | Operational issue category |
| `business_area` | Affected supplier, warehouse, or product category |
| `metric_name` | Operational KPI name |
| `metric_value` | KPI value |
| `severity` | Assigned risk severity |
| `severity_rank` | Numerical severity ranking |

Additional operational context could be incorporated in a future version.

---

## 5. Proposed Prompt Template

The following prompt is a design example and is not called by the current Python scripts.

### Role

You are a Business Analyst assistant supporting supply chain operations.

Your task is to analyze a structured operational issue and prepare draft business analysis documentation.

Use only the information provided in the input record.

Do not invent operational evidence, financial impacts, stakeholder decisions, or confirmed root causes.

### Input

```text
Issue Type: {issue_type}
Business Area: {business_area}
Metric Name: {metric_name}
Metric Value: {metric_value}
Severity: {severity}
Severity Rank: {severity_rank}
```

### Instructions

Generate the following structured outputs:

1. Business issue summary
2. Root-cause hypothesis
3. Proposed business requirement
4. Jira-style epic title
5. Jira-style user story
6. Acceptance criteria
7. Executive recommendation

### Output Requirements

**Business Issue Summary**

Summarize the issue using the supplied KPI, business area, and severity.

**Root-Cause Hypothesis**

Identify plausible explanations for the issue.

Clearly label the explanations as hypotheses rather than verified causes.

**Business Requirement**

Draft a requirement describing a potential monitoring, reporting, or process improvement capability.

**Jira Epic**

Create a concise epic title connected to the operational improvement opportunity.

**Jira User Story**

Use the following structure:

As a [stakeholder], I want [capability] so that [business benefit].

**Acceptance Criteria**

Provide specific, testable conditions for evaluating the proposed capability.

Do not introduce unsupported thresholds or claim that business stakeholders have approved them.

**Executive Recommendation**

Suggest an appropriate next step for further investigation or business review.

### Constraints

- Do not claim that hypotheses are confirmed root causes.
- Do not invent savings, revenue improvements, or operational outcomes.
- Do not present generated requirements as approved.
- Do not imply that Jira issues have been created.
- Maintain consistent terminology across the generated fields.
- Identify information gaps where relevant.
- Require human review before business action.

---

## 6. Proposed Structured Output

A future implementation could use a JSON response containing:

```json
{
  "business_issue_summary": "",
  "root_cause_hypothesis": "",
  "business_requirement": "",
  "jira_epic": "",
  "jira_user_story": "",
  "acceptance_criteria": [],
  "executive_recommendation": "",
  "human_review_required": true
}
```

This JSON structure is illustrative.

The current implemented workflow writes outputs to CSV using Python-based templates.

A future LLM integration would require explicit schema validation before its output could be consumed reliably by downstream workflows.

---

## 7. Proposed Validation Process

A future implementation should validate:

1. **Schema compliance:** Required output fields are present and correctly formatted.
2. **Evidence consistency:** Statements are supported by the supplied operational information.
3. **KPI accuracy:** Numeric values match the source data.
4. **Requirement quality:** Draft requirements are understandable and testable.
5. **Acceptance criteria:** Criteria are measurable and relevant.
6. **Human review:** Outputs are reviewed before operational decisions.
7. **Error handling:** Invalid or incomplete responses are identified and handled.

These controls are proposed design requirements, not currently implemented LLM validation features.

---

## 8. Relationship to the Existing Workflow

The current project uses the following implemented process:

```text
SQL-Derived Operational Issues
             |
             v
ai_issue_candidates.csv
             |
             v
Python Rule-Based Workflow
             |
             v
ai_business_outputs.csv
             |
             v
Jira-Style Backlog Generator
             |
             v
jira_user_stories.csv
```

A potential future LLM integration would introduce an additional generation component, while preserving structured outputs and human review.

It would require:

- LLM service configuration
- Prompt execution logic
- Output schema validation
- Error handling
- Evaluation of generated responses
- Appropriate data protection controls

---

## 9. Current Limitations

This document does not establish that an LLM has been integrated into OpsPilot.

The project currently does not:

- Call an LLM API
- Execute the proposed prompt
- Use autonomous AI agents
- Perform retrieval-augmented generation
- Automatically approve generated requirements
- Create issues directly in Jira

These capabilities would require additional implementation and testing.

---

## 10. Future Development Opportunities

Potential future enhancements include:

- Implementing the proposed LLM prompt
- Adding structured JSON output validation
- Comparing LLM-generated outputs with rule-based templates
- Evaluating response accuracy and consistency
- Adding a human approval interface
- Supporting optional Jira API integration

---

## 11. Summary

This document provides a proposed prompt design for extending OpsPilot with LLM-supported business analysis.

The existing project remains a functional rule-based analytics and business analysis workflow.

The proposed design illustrates how generative AI could be incorporated in the future without misrepresenting the capabilities already implemented.
