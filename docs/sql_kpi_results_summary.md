# OpsPilot | SQL KPI Results Summary

## 1. Project Overview

OpsPilot is an end-to-end supply chain analytics and automated business analysis project developed using Python, PostgreSQL, SQL, Power BI, and rule-based workflow automation.

This document summarizes the SQL KPI analysis performed on the project's synthetic supply chain dataset.

The analysis focuses on operational performance across:

- Orders and fulfillment
- Warehouse operations
- Shipment delays
- Inventory and stockout risk
- Supplier reliability
- Product returns
- Customer segment performance
- Operational issue identification
- Business risk prioritization

The results support five Power BI dashboard pages and the Python-based automated Business Analyst workflow.

### Analysis Objectives

The SQL analysis aims to:

1. Establish baseline supply chain KPIs.
2. Identify warehouses with elevated shipment delays.
3. Evaluate inventory stockout exposure.
4. Compare supplier delivery performance.
5. Examine shipment delay reasons.
6. Analyze product returns and associated costs.
7. Evaluate customer segment performance.
8. Identify and prioritize operational issues.
9. Provide structured inputs for business analysis automation.

### Implementation Clarification

The project's operational issue identification is performed using PostgreSQL queries and analytical views.

A Python workflow then uses predefined conditional rules and text templates to generate business issue summaries, root-cause hypotheses, requirements, recommendations, and Jira-style user stories.

The current implementation does not invoke an LLM or use autonomous AI agents.

The project uses synthetic operational data. All findings are illustrative rather than evidence of actual organizational performance.

---

# 2. Executive KPI Summary

The Executive Overview consolidates major supply chain performance indicators.

## Executive Performance Results

| KPI | Result |
|---|---:|
| Total Orders | 25,000 |
| Shipped Order Value | $24,880,425.10 |
| Order Fulfillment Rate | 97.47% |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Average Shipment Delay | 0.60 days |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |
| Shipping Cost per Order | $19.08 |

## KPI Definitions

### Total Orders

Number of orders recorded in the order fact table.

**Result:** 25,000 orders.

### Shipped Order Value

Total order value associated with orders that have shipment records.

**Result:** $24,880,425.10.

This metric should not be described as total recognized revenue because shipment records alone do not establish accounting revenue recognition.

### Order Fulfillment Rate

Percentage of orders associated with shipment records.

```text
Order Fulfillment Rate =
Orders With Shipments / Total Orders × 100
```

**Result:** 97.47%.

### On-Time Delivery Rate

Percentage of shipment records classified as on time.

```text
On-Time Delivery Rate =
On-Time Shipments / Total Shipments × 100
```

**Result:** 86.82%.

### Late Shipment Rate

Percentage of shipment records classified as delayed.

```text
Late Shipment Rate =
Delayed Shipments / Total Shipments × 100
```

**Result:** 13.18%.

### Stockout Rate

Percentage of inventory records classified as stockouts.

**Result:** 31.64%.

This is a record-based measure of inventory availability in the synthetic dataset.

It should not automatically be interpreted as the percentage of customer orders lost due to stockouts.

### Return Rate

Percentage of orders associated with returns.

```text
Return Rate =
Orders With Returns / Total Orders × 100
```

**Result:** 9.62%.

### Shipping Cost per Order

The dashboard reports an average shipping cost per order of approximately $19.08.

Its interpretation should follow the denominator used by the underlying SQL calculation rather than assuming all 25,000 orders incurred shipping costs.

## Executive Business Insight

The analysis identified three major areas requiring operational attention:

- Inventory stockout exposure: 31.64%.
- Late shipment rate: 13.18%.
- Return rate: 9.62%.

Inventory stockout risk is a significant area for further investigation.

However, these percentages have different denominators and represent different operational processes. Their numerical magnitudes should not be used alone to rank business impact.

---

# 3. Order Value Reconciliation

Two different order-value populations are used in the project.

The Executive Overview reports shipped order value, while customer-segment analysis uses the value of all orders.

## Validated Order Counts

| Metric | Value |
|---|---:|
| Total Orders | 25,000 |
| Orders With Shipments | 24,368 |
| Orders Without Shipments | 632 |

## Validated Order Values

| Metric | Value |
|---|---:|
| Total Order Value | $25,502,432.32 |
| Shipped Order Value | $24,880,425.10 |
| Order Value Without Shipments | $622,007.22 |

## Reconciliation

```text
Shipped Order Value
+
Order Value Without Shipments
=
Total Order Value
```

```text
$24,880,425.10
+
$622,007.22
=
$25,502,432.32
```

The values reconcile.

### Business Interpretation

**Total Order Value** includes all recorded orders.

**Shipped Order Value** includes orders associated with shipment records.

**Order Value Without Shipments** represents orders without corresponding shipment records.

These populations must be distinguished when comparing KPIs.

The project does not independently establish recognized revenue under an accounting framework.

---

# 4. Warehouse Performance Analysis

## Objective

Identify warehouses with elevated late shipment rates and evaluate differences in fulfillment performance.

## Highest Late Shipment Risk Warehouses

| Rank | Warehouse | Region | Late Shipment Rate |
|---:|---|---|---:|
| 1 | Los Angeles Fulfillment Center | West | 17.13% |
| 2 | Columbus Distribution Hub | Midwest | 16.64% |
| 3 | Dallas Distribution Hub | South | 15.32% |
| 4 | Seattle Distribution Hub | West | 14.98% |
| 5 | Denver Operations Center | West | 13.53% |

## Regional Shipment Performance

| Region | Late Shipment Rate |
|---|---:|
| West | 14.27% |
| Midwest | 14.23% |
| South | 13.45% |
| Northeast | 9.67% |

## Overall Shipment Performance

| Metric | Result |
|---|---:|
| Total Shipments | 24,368 |
| Delayed Shipments | 3,212 |
| On-Time Shipments | 21,156 |
| Late Shipment Rate | 13.18% |
| Average Shipment Delay | 0.60 days |

## Business Insight

Los Angeles, Columbus, and Dallas recorded the highest warehouse late shipment rates.

Los Angeles exceeded the overall late shipment rate by approximately 3.95 percentage points.

The West and Midwest regions also recorded elevated late shipment rates relative to the overall result.

These findings identify warehouses and regions that warrant further investigation.

### Potential Root-Cause Hypotheses

Possible contributing factors include:

- Warehouse labor constraints
- Fulfillment bottlenecks
- Inventory availability
- Order processing delays
- Carrier coordination
- Capacity utilization

These are hypotheses rather than established causes.

Additional operational evidence would be needed to determine which factors explain the observed performance differences.

### Proposed Business Actions

1. Review fulfillment processes at the three highest-delay warehouses.
2. Compare operational capacity and shipment volume.
3. Examine late shipment reasons by warehouse.
4. Investigate regional differences in shipment reliability.
5. Develop monitoring requirements for warehouses with elevated delay rates.

---

# 5. Product Category and Stockout Risk

## Objective

Evaluate inventory availability and identify product categories and subcategories experiencing elevated stockout rates.

## Highest Stockout Risk Subcategories

| Rank | Category | Subcategory | Stockout Rate |
|---:|---|---|---:|
| 1 | Electronics | Computer Accessories | 34.81% |
| 2 | Health & Personal Care | Personal Care | 33.07% |
| 3 | Electronics | Smart Devices | 33.05% |
| 4 | Grocery | Packaged Food | 32.94% |
| 5 | Office Supplies | Writing | 31.99% |

## Product Category Stockout Rates

| Category | Stockout Rate |
|---|---:|
| Grocery | 31.93% |
| Electronics | 31.76% |
| Health & Personal Care | 31.71% |
| Office Supplies | 31.69% |
| Apparel | 31.53% |
| Home Goods | 31.19% |

## Overall Inventory Performance

| KPI | Result |
|---|---:|
| Total Inventory Records | 30,000 |
| Overall Stockout Rate | 31.64% |

## Business Insight

All six product categories recorded stockout rates above 31%.

Grocery had the highest category-level stockout rate at 31.93%.

Computer Accessories recorded the highest subcategory-level stockout rate among the reported results at 34.81%.

Electronics contained two subcategories among the five highest reported stockout rates:

- Computer Accessories
- Smart Devices

This indicates that inventory availability in these areas warrants further review.

### Potential Root-Cause Hypotheses

Possible explanations include:

- Demand forecasting inaccuracies
- Reorder points that do not reflect consumption patterns
- Supplier replenishment variability
- Insufficient inventory buffers
- Product-level planning differences

The SQL results identify inventory exposure but do not independently verify these explanations.

### Proposed Business Actions

1. Review replenishment policies for high-stockout categories.
2. Compare closing stock with reorder points.
3. Examine supplier lead times for affected products.
4. Review inventory buffer calculations.
5. Develop monitoring requirements for elevated stockout rates.

---

# 6. Supplier Delay Risk Analysis

## Objective

Evaluate supplier-associated shipment delay performance and identify suppliers requiring further reliability analysis.

## Highest Supplier Delay Risk

| Rank | Supplier | Region | Supplier Delay Rate |
|---:|---|---|---:|
| 1 | Supplier 17 | West | 15.60% |
| 2 | Supplier 2 | Northeast | 15.02% |
| 3 | Supplier 9 | West | 14.75% |
| 4 | Supplier 20 | South | 14.31% |
| 5 | Supplier 14 | Midwest | 14.17% |

## Business Insight

Supplier 17 recorded the highest delay rate at 15.60%.

Supplier 2 followed at 15.02%, while Supplier 9 recorded 14.75%.

These suppliers represent candidates for further performance investigation.

### Supplier Risk Score Consideration

The original SQL analysis identified cases where supplier risk scores did not align directly with observed delay rates.

For example, Supplier 9 had a relatively low supplier risk score despite appearing among the highest reported delay rates.

This indicates that the supplier risk score alone may not explain shipment performance.

Possible additional variables include:

- Product mix
- Warehouse performance
- Supplier lead-time variability
- Demand patterns
- Shipment processing
- Carrier performance

The available results do not establish causal relationships between these variables and delays.

### Proposed Business Actions

1. Review supplier lead-time reliability.
2. Compare supplier delay rates across product categories.
3. Investigate suppliers with elevated delay rates.
4. Evaluate whether existing risk scores reflect actual shipment performance.
5. Consider backup supplier arrangements where operationally appropriate.

---

# 7. Shipment Delay Reason Analysis

## Objective

Understand the distribution of recorded shipment delay reasons and their associated operational costs.

## Delay Reason Results

| Delay Reason | Shipment Count | Shipment Share | Average Delay Days | Total Shipping Cost |
|---|---:|---:|---:|---:|
| No Delay | 21,156 | 86.82% | 0.00 | $381,565.38 |
| Weather | 558 | 2.29% | 4.68 | $14,940.38 |
| Labor Constraint | 540 | 2.22% | 4.49 | $13,554.80 |
| Inventory Shortage | 540 | 2.22% | 4.44 | $14,032.26 |
| System Issue | 531 | 2.18% | 4.60 | $14,006.59 |
| Supplier Delay | 523 | 2.15% | 4.47 | $13,347.23 |
| Carrier Delay | 520 | 2.13% | 4.53 | $13,473.86 |

## Key Findings

On-time shipments accounted for 86.82% of all shipment records.

Among the delayed shipments:

- Weather was the most frequently recorded delay reason, with 558 shipments.
- Labor Constraint accounted for 540 delayed shipments.
- Inventory Shortage also accounted for 540 delayed shipments.
- System Issue accounted for 531 delayed shipments.
- Supplier Delay accounted for 523 delayed shipments.
- Carrier Delay accounted for 520 delayed shipments.

Weather-related delayed shipments had an average delay of 4.68 days.

## Business Insight

The recorded delay reasons are distributed across several operational categories rather than concentrated in a single category.

This indicates that a review limited to one delay category would overlook other reported sources of delay.

### Proposed Business Actions

1. Review weather-related delivery exceptions.
2. Investigate labor-related fulfillment disruptions.
3. Examine inventory shortages associated with delayed shipments.
4. Analyze system-related processing delays.
5. Review supplier and carrier coordination.
6. Develop more detailed reporting for delay reasons and shipment costs.

### Analytical Limitation

The delay reason field records a category associated with each shipment.

It does not independently establish that the assigned category is the sole or verified causal explanation for the delay.

---

# 8. Return Analysis by Product Category

## Objective

Evaluate product return rates and associated return costs across categories.

## Product Category Return Performance

| Category | Total Orders | Total Returns | Return Rate | Total Return Cost | Late Delivery Returns |
|---|---:|---:|---:|---:|---:|
| Apparel | 5,111 | 516 | 10.10% | $40,832.71 | 55 |
| Electronics | 3,774 | 371 | 9.83% | $29,586.47 | 45 |
| Office Supplies | 4,929 | 478 | 9.70% | $37,198.21 | 59 |
| Home Goods | 3,769 | 365 | 9.68% | $28,609.30 | 35 |
| Grocery | 4,254 | 401 | 9.43% | $31,947.23 | 54 |
| Health & Personal Care | 3,163 | 274 | 8.66% | $22,228.63 | 35 |

## Key Findings

Apparel recorded:

- The highest reported return rate: 10.10%.
- The highest total return cost: $40,832.71.
- A total of 516 returns.

Office Supplies recorded the second-highest reported return cost at $37,198.21.

## Business Insight

Apparel represents a potential priority for return-related analysis because it combines the highest reported return rate with the highest total return cost.

Potential areas for investigation include:

- Product quality
- Product descriptions
- Customer expectations
- Fulfillment accuracy
- Delivery experience
- Sizing-related issues

These factors are not verified causes of the observed returns.

### Proposed Business Actions

1. Review return reasons for Apparel.
2. Analyze return costs by category.
3. Compare return rates with order volumes.
4. Investigate products with repeated returns.
5. Examine whether delivery performance is associated with return behavior.

---

# 9. Customer Segment Performance

## Objective

Analyze order value, shipment delays, and returns across customer segments and geographic regions.

The analysis uses the PostgreSQL view:

`opspilot.vw_customer_segment_performance`

The view aggregates shipment and return information before joining it to the order fact table.

This reduces the risk of multiplying order values through joins involving multiple fact records.

## Customer Segments

The analysis includes:

- Retail
- Wholesale
- Enterprise

## 9.1 Order Value by Customer Segment

Retail customers generated the highest total order value among the three customer segments.

### Retail Order Value by Region

| Segment | Region | Total Order Value |
|---|---|---:|
| Retail | Northeast | $4,246,620.26 |
| Retail | South | $4,223,677.06 |
| Retail | West | $4,125,687.13 |
| Retail | Midwest | $3,661,821.27 |

These values describe recorded order value, not independently established recognized revenue.

### Business Insight

Retail represents the largest order-value segment in the reported analysis.

This indicates that maintaining fulfillment reliability for Retail orders may be important for protecting customer experience and operational continuity.

However, order value alone does not establish profitability or business contribution margin.

---

## 9.2 Shipment Delay Performance by Customer Segment and Region

### Highest Reported Delay Rates

| Segment | Region | Delay Rate |
|---|---|---:|
| Wholesale | West | 14.39% |
| Wholesale | Northeast | 14.06% |
| Enterprise | Midwest | 13.88% |
| Wholesale | South | 13.69% |
| Retail | Midwest | 13.41% |

### Calculation Methodology

The SQL view calculates the shipment delay percentage using:

```text
Late Shipment Rate =
Delayed Shipments / Total Shipments × 100
```

This is a shipment-based measure.

The view also provides a separate count of orders with at least one delayed shipment.

Therefore, **delayed shipments and delayed orders should not automatically be treated as equivalent measures**.

### Important Reporting Consideration

When aggregating results across customer segments or regions, the delay rate should be recalculated using shipment counts.

Averaging regional delay percentages without weighting by the relevant denominators may produce misleading results.

### Business Insight

Wholesale appears repeatedly among the highest reported regional delay rates.

This suggests that Wholesale shipment performance warrants additional investigation.

However, the existing results do not establish why these differences occur.

---

## 9.3 Customer Return Performance

### Highest Reported Return Rates

| Segment | Region | Return Rate |
|---|---|---:|
| Enterprise | South | 11.64% |
| Wholesale | Northeast | 10.91% |
| Wholesale | Midwest | 10.81% |
| Retail | Midwest | 10.56% |
| Wholesale | West | 10.56% |

### Calculation Methodology

The customer segment view calculates return rates using the proportion of orders associated with returns.

```text
Return Rate =
Orders With Returns / Total Orders × 100
```

The SQL view aggregates return records by order before calculating the customer segment results.

### Business Insight

Enterprise South recorded the highest return rate among the reported segment-region combinations.

Wholesale also appeared frequently among the highest return-rate combinations.

These results suggest opportunities for more detailed customer experience and return-reason analysis.

---

## 9.4 Customer Segment Summary

The Power BI dashboard reports the following aggregated customer segment metrics.

| Customer Segment | Displayed Delay Rate | Return Rate |
|---|---:|---:|
| Wholesale | 13.20% | 9.98% |
| Retail | 12.82% | 9.48% |
| Enterprise | 12.11% | 9.62% |

The displayed delay percentages should be interpreted according to the shipment-based definition implemented in the SQL view.

### Proposed Business Priorities

**Retail**

Investigate opportunities to maintain shipment reliability and support the segment generating the highest order value.

**Wholesale**

Review shipment delays and regional fulfillment performance.

**Enterprise**

Investigate elevated return rates in selected regions and evaluate potential customer experience concerns.

These are proposed analytical priorities rather than confirmed business decisions.

---

# 10. Operational Issue Identification

## Objective

Convert SQL KPI findings into structured operational issues that can support standardized business analysis.

The project uses the PostgreSQL view:

`opspilot.vw_ai_issue_candidates`

The output is exported to:

`data/processed/ai_issue_candidates.csv`

Although the SQL view retains its original AI-related name, it identifies issues using SQL-based calculations and predefined severity rules.

## Issue Distribution

| Issue Type | Total Issues |
|---|---:|
| Supplier Delay Risk | 25 |
| Warehouse Delay Risk | 10 |
| Product Stockout Risk | 6 |
| **Total** | **41** |

## Severity Distribution

| Severity | Issue Count |
|---|---:|
| High | 6 |
| Medium | 34 |
| Low | 1 |
| **Total** | **41** |

Severity levels are assigned using predefined thresholds.

They do not represent externally validated business impact assessments.

---

## 10.1 High-Severity Operational Issues

| Issue Type | Business Area | Metric | Value | Severity |
|---|---|---|---:|---|
| Product Stockout Risk | Grocery | Stockout Rate | 31.93% | High |
| Product Stockout Risk | Electronics | Stockout Rate | 31.76% | High |
| Product Stockout Risk | Health & Personal Care | Stockout Rate | 31.71% | High |
| Product Stockout Risk | Office Supplies | Stockout Rate | 31.69% | High |
| Product Stockout Risk | Apparel | Stockout Rate | 31.53% | High |
| Product Stockout Risk | Home Goods | Stockout Rate | 31.19% | High |

### Business Insight

All six product categories were classified as high-severity stockout risks under the project's predefined rules.

Grocery recorded the highest category-level stockout rate.

These findings support further investigation into inventory availability and replenishment planning.

---

## 10.2 Selected Medium-Severity Operational Issues

| Issue Type | Business Area | Metric | Value | Severity |
|---|---|---|---:|---|
| Warehouse Delay Risk | Los Angeles Fulfillment Center | Late Shipment Rate | 17.13% | Medium |
| Warehouse Delay Risk | Columbus Distribution Hub | Late Shipment Rate | 16.64% | Medium |
| Supplier Delay Risk | Supplier 17 | Supplier Delay Rate | 15.60% | Medium |
| Warehouse Delay Risk | Dallas Distribution Hub | Late Shipment Rate | 15.32% | Medium |
| Supplier Delay Risk | Supplier 2 | Supplier Delay Rate | 15.02% | Medium |

### Business Insight

Warehouse and supplier delays account for most of the medium-severity operational issues.

The reported results identify potential priorities for warehouse performance and supplier reliability investigations.

---

# 11. Automated Business Analysis Workflow

The SQL issue candidate results provide inputs to the Python business analysis workflow.

### Input File

`data/processed/ai_issue_candidates.csv`

### Python Script

`python/ai_business_analyst_workflow.py`

### Output File

`data/processed/ai_business_outputs.csv`

The workflow processes each issue record and generates structured business analysis outputs.

## Generated Deliverables

For each issue, the workflow produces:

1. Business issue summary
2. Root-cause hypothesis
3. Proposed business requirement
4. Jira-style epic
5. Jira-style user story
6. Acceptance criteria
7. Executive recommendation
8. Human review indicator

## Implementation Method

The workflow uses predefined Python rules and templates.

It does not currently call an LLM or use autonomous AI agents.

Root-cause hypotheses and recommendations are generated based on issue categories.

They do not represent independently validated operational conclusions.

## Verified Workflow Results

| Metric | Result |
|---|---:|
| Input Operational Issues | 41 |
| Generated Business Analysis Records | 41 |
| Jira-Style User Stories | 41 |
| Workflow Execution | Successful |

The project includes a separate Python script for generating the Jira-style backlog.

### Jira Backlog Generator

`python/jira_backlog_generator.py`

### Backlog Output

`jira/jira_user_stories.csv`

The backlog is generated as a CSV file.

The workflow does not create issues directly in a live Jira environment.

---

# 12. Overall Business Recommendations

The SQL analysis identifies multiple areas for further operational investigation.

## Priority 1 — Inventory Availability

**Finding:** Stockout rates exceed 31% across all six reported product categories.

### Proposed Actions

- Review inventory planning processes.
- Investigate reorder point configuration.
- Evaluate supplier replenishment timing.
- Examine inventory buffers.
- Introduce additional monitoring for elevated stockout rates.

### Business Rationale

Inventory availability is a significant operational concern within the synthetic dataset.

The project's severity rules classify all six product categories as high risk.

---

## Priority 2 — Warehouse Shipment Reliability

**Finding:** Los Angeles, Columbus, and Dallas recorded the highest late shipment rates.

### Proposed Actions

- Investigate fulfillment delays.
- Review operational capacity.
- Examine shipment processing performance.
- Compare warehouse-level delay reasons.
- Establish monitoring requirements for elevated delay rates.

---

## Priority 3 — Supplier Reliability

**Finding:** Supplier 17, Supplier 2, and Supplier 9 appear among the highest reported supplier delay rates.

### Proposed Actions

- Review supplier lead-time performance.
- Evaluate supplier reliability trends.
- Investigate discrepancies between risk scores and actual delay rates.
- Consider backup supplier options.
- Improve supplier performance monitoring.

---

## Priority 4 — Shipment Delay Reasons

**Finding:** Delays are distributed across weather, labor, inventory, system, supplier, and carrier categories.

### Proposed Actions

- Analyze the contribution of different delay reasons.
- Investigate operational constraints.
- Examine shipping costs associated with delays.
- Improve delay reason reporting and monitoring.

---

## Priority 5 — Product Returns

**Finding:** Apparel recorded the highest category-level return rate and total return cost.

### Proposed Actions

- Investigate return reasons.
- Analyze category-level return costs.
- Review fulfillment and delivery-related return patterns.
- Identify products with repeated returns.

---

## Priority 6 — Customer Segment Performance

**Finding:** Retail generated the highest order value, while Wholesale and selected Enterprise segment-region combinations showed elevated shipment delays or return rates.

### Proposed Actions

- Monitor Retail shipment reliability.
- Investigate Wholesale delivery performance.
- Review Enterprise return patterns in higher-rate regions.
- Compare segment performance using appropriately weighted KPIs.

---

# 13. Analytical Limitations

The SQL results should be interpreted with the following limitations.

### Synthetic Data

All operational data is synthetic.

The findings do not represent actual company performance.

### KPI Definitions

Different KPIs use different denominators.

Stockout rates, shipment delay rates, and return rates should not be directly compared as equivalent risk measures.

### Order Value

Total Order Value and Shipped Order Value represent different populations.

Neither metric independently establishes recognized accounting revenue.

### Root-Cause Analysis

Operational differences and recorded delay reasons do not establish causation.

Additional investigation would be required before attributing performance issues to specific operational processes.

### Severity Classification

Severity rankings are based on predefined project rules.

They have not been validated against an organization's actual risk tolerance or financial impact.

### Business Recommendations

Recommendations are preliminary proposals.

They require human review and additional operational evidence before implementation.

---

# 14. Future Improvements

Potential extensions include:

### SQL and Data Engineering

- Automated PostgreSQL data refresh
- Additional data validation
- Historical KPI calculations
- Performance benchmarking
- More detailed customer segment metrics

### Business Intelligence

- Historical operational trend analysis
- KPI targets and performance thresholds
- Additional Power BI drill-through functionality
- Power BI Service deployment

### Workflow Automation

- Automated export of SQL issue candidates
- Optional LLM integration
- Structured recommendation validation
- Human approval workflows
- Direct Jira API integration

These are proposed improvements and are not currently implemented.

---

# 15. Related Project Files

## SQL Implementation

- [Database Table Definitions](../sql/01_create_tables.sql)
- [KPI Analysis Queries](../sql/03_kpi_analysis_queries.sql)
- [Analytical SQL Views](../sql/04_create_analytics_views.sql)
- [Customer Segment Performance View](../sql/05_create_customer_segment_view.sql)

## Business Analysis Automation

- [Automated Business Analyst Workflow](../python/ai_business_analyst_workflow.py)
- [Jira Backlog Generator](../python/jira_backlog_generator.py)

## Documentation

- [Project README](../README.md)
- [Project Charter](project_charter.md)
- [Business Analyst Workflow Documentation](ai_workflow_documentation.md)
- [Business Analysis Output Schema](ai_output_schema.md)
- [Jira Backlog Documentation](jira_backlog_documentation.md)
- [Power BI Dashboard Documentation](../powerbi/powerbi_dashboard_documentation.md)

## Power BI Deliverable

[OpsPilot Power BI Dashboard](../powerbi/OpsPilot_AI_Dashboard.pbix)

---

# 16. Final Summary

The OpsPilot SQL analysis demonstrates how PostgreSQL and SQL can be used to evaluate supply chain performance and identify operational risks.

The analysis covers 25,000 orders, 24,368 shipments, 30,000 inventory records, and 2,405 return records.

The project uses SQL analytical views to support five Power BI dashboard pages and identify 41 operational issues.

A separate Python-based rule-driven workflow converts these issues into structured business analysis outputs and generates 41 Jira-style user stories.

The completed project demonstrates the integration of:

- SQL analytics
- PostgreSQL database development
- KPI definition and reconciliation
- Power BI reporting
- Operational risk analysis
- Python workflow automation
- Business requirements documentation
- Jira-style backlog preparation

The primary contribution is demonstrating how structured supply chain analytics can support business problem identification, proposed requirements, and operational decision-making within a reproducible portfolio project.
