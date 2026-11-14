# OpsPilot AI | Power BI Dashboard Documentation

## 1. Project Overview

OpsPilot AI is an end-to-end Business Analytics and AI project focused on supply chain operations.

The Power BI component transforms operational data stored in PostgreSQL into interactive dashboards that support performance monitoring, operational risk identification, and business decision-making.

The report consists of five dashboard pages covering executive KPIs, inventory performance, warehouse operations, supplier and customer analysis, and AI-assisted business recommendations.

### Project Objectives

- Monitor supply chain performance using standardized KPIs.
- Identify inventory stockout risks.
- Analyze warehouse and shipment delays.
- Evaluate supplier reliability and customer segment performance.
- Prioritize operational issues based on risk and severity.
- Translate operational findings into AI-assisted business requirements, recommendations, and Jira-style user stories.

---

## 2. Technology Stack

| Technology | Application |
|---|---|
| Power BI Desktop | Dashboard development and visualization |
| PostgreSQL | Relational database and analytical views |
| SQL | Data aggregation and KPI analysis |
| DAX | Custom measures and calculations |
| Power Query | Data connection and transformation |
| Python | Data generation, validation, and AI-assisted workflows |
| Generative AI | Root-cause hypotheses and business analysis outputs |
| Jira-style Backlog | User stories and acceptance criteria |
| GitHub | Version control and project documentation |

---

## 3. Data Sources

The Power BI report connects to the PostgreSQL database:

**Database:** `opspilot_ai`

**Schema:** `opspilot`

### PostgreSQL Analytical Views

| View | Purpose |
|---|---|
| `vw_executive_kpi_summary` | Executive performance indicators |
| `vw_product_stockout_risk` | Inventory and stockout analysis |
| `vw_warehouse_performance` | Warehouse and shipment performance |
| `vw_supplier_delay_risk` | Supplier reliability analysis |
| `vw_ai_issue_candidates` | Operational issue identification and prioritization |
| `vw_customer_segment_performance` | Customer segment order value, delays, and returns |

### Additional Data

The report also uses AI-generated business analysis outputs and Jira-style user stories produced through the project's Python workflows.

These datasets support the interactive business requirements and AI recommendation displays.

---

# 4. Power BI Dashboard Pages

## Page 1: Executive Overview

### Purpose

Provide management with a consolidated view of supply chain performance and operational risks.

### Executive KPIs

| KPI | Displayed Value |
|---|---:|
| Total Orders | 25,000 |
| Shipped Order Value | $24.88M |
| Order Fulfillment Rate | 97.47% |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |
| Shipping Cost per Order | $19.08 |

### Dashboard Components

**KPI Cards**

Eight KPI cards summarize key operational indicators.

**Operational Issues by Severity**

A horizontal bar chart displays the distribution of identified operational issues.

**Issues by Risk Type**

A horizontal bar chart compares supplier delay, warehouse delay, and product stockout risks.

**Operational Risk Details**

A table displays risk type, business area, metric value, and severity.

**AI-Assisted Recommendations**

A table presents recommended actions associated with identified operational issues.

### Business Value

The dashboard helps stakeholders monitor performance, identify operational exceptions, and prioritize areas requiring further investigation.

---

## Page 2: Inventory & Stockout Risk

### Purpose

Evaluate inventory availability, stockout exposure, and inventory buffer levels across product categories.

### Dashboard Components

**Stockout Rate by Product Category**

Compares stockout rates across six product categories.

**Top 10 Subcategories by Stockout Rate**

Identifies subcategories experiencing the highest stockout rates.

**Weighted Average Inventory Buffer by Category**

Measures the difference between weighted average closing stock and weighted average reorder points.

**Total Stockout Records by Category**

Displays the number of recorded stockout occurrences across product categories.

### DAX Methodology

Weighted average inventory calculations use inventory record counts as weights.

```dax
Weighted Avg Closing Stock =
DIVIDE(
    SUMX(
        'product_stockout_risk',
        'product_stockout_risk'[avg_closing_stock] *
        'product_stockout_risk'[inventory_records]
    ),
    SUM('product_stockout_risk'[inventory_records])
)
```

```dax
Weighted Avg Reorder Point =
DIVIDE(
    SUMX(
        'product_stockout_risk',
        'product_stockout_risk'[avg_reorder_point] *
        'product_stockout_risk'[inventory_records]
    ),
    SUM('product_stockout_risk'[inventory_records])
)
```

```dax
Inventory Buffer =
[Weighted Avg Closing Stock] -
[Weighted Avg Reorder Point]
```

The inventory buffer is expressed in stock units and should not be interpreted as a percentage.

### Key Findings

Grocery recorded the highest category-level stockout rate at approximately 31.93%.

Computer Accessories recorded the highest displayed subcategory stockout rate at approximately 34.81%.

These categories represent potential priorities for replenishment and inventory planning reviews.

---

## Page 3: Warehouse & Shipment Performance

### Purpose

Analyze shipment reliability and identify warehouses and geographic regions experiencing elevated delivery delays.

### Dashboard Components

**Average Shipment Delay (Days)**

Displays the weighted average shipment delay.

**Top 3 Warehouses by Late Shipment Rate (%)**

Highlights the three warehouses with the highest late shipment percentages.

**Late Shipment Rate by Region (%)**

Compares regional shipment performance.

**Warehouse Performance Table**

Displays:

- Warehouse
- Region
- Total Orders
- Late Shipments
- Late Shipment Rate (%)
- Average Delay (Days)

### Key Findings

| Warehouse | Late Shipment Rate |
|---|---:|
| Los Angeles Fulfillment Center | 17.13% |
| Columbus Distribution Hub | 16.64% |
| Dallas Distribution Hub | 15.32% |

The overall late shipment rate is 13.18%.

The weighted average shipment delay is approximately 0.60 days.

### Conditional Formatting

The warehouse table uses color-coded risk indicators to highlight locations with elevated late shipment rates.

The formatting supports rapid identification of operational exceptions.

### Business Value

The dashboard helps operations teams identify warehouses requiring investigation into fulfillment processes, capacity constraints, and shipment coordination.

---

## Page 4: Supplier & Customer Performance

### Purpose

Evaluate supplier delivery reliability and customer segment performance.

### Supplier Analysis

**Top 5 Suppliers by Delay Rate (%)**

Identifies suppliers with the highest reported delay rates.

**Supplier Delay Risk — Performance Details**

Displays:

- Supplier
- Region
- Total Orders
- Delayed Orders
- Delay Rate (%)
- Risk Score

Conditional formatting highlights higher supplier delay rates.

### Supplier Findings

| Supplier | Delay Rate |
|---|---:|
| Supplier 17 | 15.60% |
| Supplier 2 | 15.02% |
| Supplier 9 | 14.75% |
| Supplier 20 | 14.31% |
| Supplier 14 | 14.17% |

### Customer Analysis

**Order Value by Customer Segment and Region**

Compares order value across Retail, Wholesale, and Enterprise customers in four geographic regions.

**Delayed Order Rate by Customer Segment (%)**

Measures the proportion of orders associated with delayed shipments.

**Return Rate by Customer Segment (%)**

Measures the proportion of orders associated with returns.

### Customer Findings

| Customer Segment | Delayed Order Rate | Return Rate |
|---|---:|---:|
| Wholesale | 13.20% | 9.98% |
| Retail | 12.82% | 9.48% |
| Enterprise | 12.11% | 9.62% |

Retail generates the highest total order value.

Wholesale has the highest displayed delayed-order and return rates.

These differences indicate areas for further analysis rather than establishing statistically significant performance gaps.

### Calculation Methodology

The customer segment measures aggregate order counts before calculating percentages.

**Delayed Order Rate**

Delayed Orders / Total Orders

**Return Rate**

Orders With Returns / Total Orders

The calculations use weighted aggregation rather than summing regional percentages.

---

## Page 5: AI Business Insights & Recommendations

### Purpose

Demonstrate how operational findings can be translated into structured business analysis outputs using AI-assisted workflows.

Implementation note: The dashboard retains its original AI-themed title. However, the current Python workflow generates business analysis outputs using predefined conditional rules and text templates. It does not call a large language model (LLM), use autonomous agents, or independently validate operational root causes. The displayed hypotheses, requirements, and recommendations are preliminary outputs requiring human review.
### Interactive Dashboard Components

**1. Select an Operational Issue**

A selection table displays:

- Business Area
- Issue Type
- Severity

Users select an operational issue to explore its associated analysis.

**2. AI-Generated Root Cause Hypothesis**

Displays a potential explanation for the selected operational issue.

**3. Executive Recommendation**

Provides a proposed business action addressing the selected issue.

**4. Business Requirement**

Translates the identified problem into a proposed business requirement.

**5. Jira User Story**

Displays a structured user story describing the intended functionality and business benefit.

### Interactive Workflow

Operational Issue

↓

Root-Cause Hypothesis

↓

Executive Recommendation

↓

Business Requirement

↓

Jira User Story

### DAX Implementation

The interactive displays use `SELECTEDVALUE()` to retrieve the corresponding business analysis output within the selected issue's filter context.

Example:

```dax
Selected Root Cause Hypothesis =
SELECTEDVALUE(
    'ai_business_outputs'[root_cause_hypothesis],
    "Select an operational issue from the table to view its AI-generated root-cause hypothesis."
)
```

Similar measures are used for executive recommendations, business requirements, and Jira user stories.

### Business Value

This dashboard demonstrates how AI-assisted business analysis can connect operational reporting to requirements documentation and delivery planning.

AI-generated hypotheses and recommendations are proposals requiring human validation before implementation.

---

# 5. Data Validation

Data validation was performed using PostgreSQL queries to examine order counts and monetary values.

### Order Value Reconciliation

| Metric | Validated Value |
|---|---:|
| Total Orders | 25,000 |
| Orders With Shipments | 24,368 |
| Orders Without Shipments | 632 |
| Total Order Value | $25,502,432.32 |
| Shipped Order Value | $24,880,425.10 |
| Order Value Without Shipments | $622,007.22 |

### Reconciliation

Shipped Order Value + Order Value Without Shipments = Total Order Value

$24,880,425.10 + $622,007.22 = $25,502,432.32

This reconciliation explains why the Executive Overview and customer-segment analysis use different order-value totals.

The Executive Overview's Shipped Order Value represents orders with shipment records.

The customer-segment analysis includes all orders.

These metrics are distinguished to avoid misleading comparisons.

---

# 6. Dashboard Design Principles

The Power BI report follows a consistent visual design.

### Theme

- Dark background
- High-contrast white text
- Consistent chart typography
- Teal and blue analytical visuals
- Red, amber, and green risk indicators

### Visualization Practices

- Descriptive chart titles
- Consistent percentage formatting
- Sorting for performance comparisons
- Top N filtering where relevant
- Conditional formatting for operational risks
- Interactive issue selection
- Tooltips for additional information
- Scrollable tables where necessary

The design emphasizes clarity, comparability, and business interpretation.

---

# 7. Business Analyst Skills Demonstrated

The dashboards demonstrate practical application of:

### Data Analysis

- SQL querying
- Data aggregation
- KPI calculations
- Data validation
- Weighted-average measures
- Operational performance analysis

### Business Intelligence

- Power BI report development
- DAX measure creation
- Dashboard design
- Interactive filtering
- Conditional formatting
- Data visualization

### Business Analysis

- Operational issue identification
- Risk classification
- Root-cause hypothesis development
- Business requirement documentation
- Executive recommendation development
- Jira-style user story creation

### AI-Assisted Workflows

- Structured business analysis outputs
- AI-generated recommendations
- Interactive AI insight presentation
- Human-in-the-loop review considerations

---

# 8. Limitations

The project uses synthetic supply chain data.

The findings are illustrative and do not represent actual organizational performance.

Operational associations do not establish causation.

AI-generated root-cause hypotheses, recommendations, and requirements require validation by relevant stakeholders.

The dashboard report is designed as a portfolio demonstration rather than a production deployment.

---

# 9. Future Improvements

Potential extensions include:

- Automated PostgreSQL data refresh
- Additional operational KPIs
- Historical performance trend analysis
- Target-based performance monitoring
- Automated validation of AI-generated outputs
- Expanded acceptance criteria reporting
- Further integration with Jira workflows
- Deployment through Power BI Service

---

# 10. Project Deliverable

**Power BI Report:** `OpsPilot_AI_Dashboard.pbix`

**Total Dashboard Pages:** 5

**Primary Data Platform:** PostgreSQL

**Reporting Platform:** Microsoft Power BI

**Supporting Technologies:** Python, SQL, DAX, Rule-Based Automation, Jira-Style Backlog Generation

The completed report demonstrates how operational analytics and AI-assisted business analysis can support the progression from performance monitoring to proposed business action.
