# OpsPilot | Data Dictionary

## 1. Overview

This document defines the relational database tables, fields, relationships, and analytical metrics used in the OpsPilot Business Analyst Workbench.

OpsPilot is an end-to-end supply chain analytics and automated business analysis project developed using Python, PostgreSQL, SQL, Power BI, and DAX.

The project uses synthetic supply chain data to demonstrate:

- Relational database development
- Operational KPI analysis
- Inventory and shipment performance monitoring
- Supplier and customer analysis
- Business intelligence reporting
- Rule-based business analysis automation
- Jira-style backlog generation

The dictionary reflects the PostgreSQL table definitions and analytical views in the project repository.

---

## 2. Database Overview

| Property | Value |
|---|---|
| Database | `opspilot_ai` |
| Schema | `opspilot` |
| Database Platform | PostgreSQL |
| Dimension Tables | 5 |
| Fact Tables | 4 |
| Total Tables | 9 |
| Analytical Views | 6 |
| Data Source | Synthetic supply chain data |

### Relational Model

The database follows a dimensional-style structure combining operational dimension tables with fact tables.

Dimension tables provide descriptive attributes.

Fact tables contain operational events and measurements.

### Table Relationships

```text
dim_supplier
     |
     v
dim_product
     |
     +----------------------+
     |                      |
     v                      v
fact_orders             fact_inventory
     |                      |
     +----------------------+
     |
     +----------------------+
     |                      |
     v                      v
fact_shipments          fact_returns
```

Additional relationships include:

- `dim_customer` → `fact_orders`
- `dim_warehouse` → `fact_orders`
- `dim_warehouse` → `fact_inventory`
- `dim_date` → `fact_inventory`
- `dim_product` → `fact_returns`

Not every date field is implemented as a foreign key to the date dimension.

---

# 3. Dimension Tables

## 3.1 dim_date

### Purpose

Stores calendar information used for time-based operational analysis.

**Primary Key:** `date_key`

**Record Count:** 731

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `date_key` | INTEGER | Unique calendar date identifier |
| `full_date` | DATE | Actual calendar date |
| `year` | INTEGER | Calendar year |
| `quarter` | INTEGER | Calendar quarter |
| `month` | INTEGER | Calendar month number |
| `month_name` | VARCHAR(20) | Calendar month name |
| `week_number` | INTEGER | Week number |
| `day_name` | VARCHAR(20) | Day name |

### Relationships

`date_key` is referenced by:

`fact_inventory.date_key`

### Analytical Usage

The table supports inventory analysis by date.

---

## 3.2 dim_supplier

### Purpose

Stores supplier attributes used for reliability and operational risk analysis.

**Primary Key:** `supplier_id`

**Record Count:** 25

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `supplier_id` | VARCHAR(20) | Unique supplier identifier |
| `supplier_name` | VARCHAR(100) | Supplier display name |
| `supplier_region` | VARCHAR(50) | Supplier geographic region |
| `standard_lead_time_days` | INTEGER | Expected supplier lead time |
| `supplier_risk_score` | INTEGER | Synthetic supplier risk rating |

### Relationships

`dim_supplier.supplier_id` is referenced by:

`dim_product.supplier_id`

### Analytical Usage

- Supplier delay analysis
- Supplier geographic analysis
- Lead-time monitoring
- Supplier risk comparisons

### Important Note

The supplier risk score is a synthetic attribute.

Its relationship with observed shipment delays must be evaluated rather than assumed.

---

## 3.3 dim_product

### Purpose

Stores product-level information used for order analysis, inventory monitoring, supplier relationships, and returns.

**Primary Key:** `product_id`

**Record Count:** 100

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `product_id` | VARCHAR(20) | Unique product identifier |
| `product_name` | VARCHAR(150) | Product display name |
| `category` | VARCHAR(75) | Product category |
| `subcategory` | VARCHAR(75) | Product subcategory |
| `unit_cost` | NUMERIC(12,2) | Cost per product unit |
| `unit_price` | NUMERIC(12,2) | Price per product unit |
| `supplier_id` | VARCHAR(20) | Supplier associated with the product |

### Relationships

**Foreign Key:**

`dim_product.supplier_id`

References:

`dim_supplier.supplier_id`

**Referenced By:**

- `fact_orders.product_id`
- `fact_inventory.product_id`
- `fact_returns.product_id`

### Analytical Usage

- Product category performance
- Subcategory stockout analysis
- Supplier-linked order analysis
- Product return analysis

---

## 3.4 dim_warehouse

### Purpose

Stores warehouse information used to analyze fulfillment performance, capacity, and shipment reliability.

**Primary Key:** `warehouse_id`

**Record Count:** 10

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `warehouse_id` | VARCHAR(20) | Unique warehouse identifier |
| `warehouse_name` | VARCHAR(150) | Warehouse name |
| `region` | VARCHAR(50) | Warehouse geographic region |
| `state` | VARCHAR(10) | Warehouse state |
| `capacity_units` | INTEGER | Reported warehouse capacity in units |
| `labor_hours_available` | INTEGER | Reported available labor hours |

### Relationships

`dim_warehouse.warehouse_id` is referenced by:

- `fact_orders.warehouse_id`
- `fact_inventory.warehouse_id`

### Analytical Usage

- Warehouse delay performance
- Regional shipment analysis
- Inventory by warehouse
- Capacity-related operational investigation

### Important Note

The database contains warehouse capacity and labor availability attributes.

However, these fields alone do not establish a validated warehouse utilization metric.

---

## 3.5 dim_customer

### Purpose

Stores customer segmentation and geographic information.

**Primary Key:** `customer_id`

**Record Count:** 2,000

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `customer_id` | VARCHAR(20) | Unique customer identifier |
| `customer_segment` | VARCHAR(50) | Retail, Wholesale, or Enterprise |
| `state` | VARCHAR(10) | Customer state |
| `region` | VARCHAR(50) | Customer geographic region |

### Relationships

`dim_customer.customer_id` is referenced by:

`fact_orders.customer_id`

### Analytical Usage

- Customer segment order-value analysis
- Regional order analysis
- Customer shipment performance
- Customer return analysis

---

# 4. Fact Tables

## 4.1 fact_orders

### Purpose

Stores customer order records used for operational demand, fulfillment, and order-value analysis.

**Primary Key:** `order_id`

**Record Count:** 25,000

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `order_id` | VARCHAR(20) | Unique order identifier |
| `order_date` | DATE | Order placement date |
| `customer_id` | VARCHAR(20) | Customer placing the order |
| `product_id` | VARCHAR(20) | Product associated with the order |
| `warehouse_id` | VARCHAR(20) | Warehouse assigned to fulfillment |
| `quantity_ordered` | INTEGER | Quantity of units ordered |
| `order_value` | NUMERIC(12,2) | Recorded monetary value of the order |
| `promised_delivery_date` | DATE | Promised delivery date |
| `actual_delivery_date` | DATE | Recorded actual delivery date, nullable |
| `order_status` | VARCHAR(30) | Recorded order status |

### Foreign Keys

| Column | References |
|---|---|
| `customer_id` | `dim_customer.customer_id` |
| `product_id` | `dim_product.product_id` |
| `warehouse_id` | `dim_warehouse.warehouse_id` |

### Relationships

The order fact table is referenced by:

- `fact_shipments.order_id`
- `fact_returns.order_id`

### Analytical Usage

- Order volume
- Order value
- Fulfillment classification
- Customer performance
- Warehouse performance
- Product demand

### KPI Consideration

The order status field is used by the current executive SQL view to calculate its reported fulfillment rate.

That calculation counts orders whose status is not `Cancelled`.

This differs conceptually from calculating fulfillment based on the existence of shipment records.

---

## 4.2 fact_shipments

### Purpose

Stores shipment-level operational information.

**Primary Key:** `shipment_id`

**Record Count:** 24,368

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `shipment_id` | VARCHAR(20) | Unique shipment identifier |
| `order_id` | VARCHAR(20) | Order associated with shipment |
| `carrier` | VARCHAR(50) | Shipment carrier |
| `shipping_method` | VARCHAR(50) | Selected shipping method |
| `shipping_cost` | NUMERIC(12,2) | Recorded shipment cost |
| `delay_days` | INTEGER | Recorded number of delay days |
| `delay_reason` | VARCHAR(75) | Recorded shipment delay category |

### Foreign Key

`fact_shipments.order_id`

References:

`fact_orders.order_id`

### Analytical Usage

- On-time shipment rate
- Late shipment rate
- Shipment delay reasons
- Average shipment delay
- Shipping cost analysis
- Warehouse performance
- Supplier-associated delay analysis

### Delay Classification

The current analytical SQL uses:

```sql
delay_days = 0
```

to identify on-time shipments.

It uses:

```sql
delay_days > 0
```

to identify delayed shipments.

### Important Note

The table does not independently establish the operational cause of a delay.

The `delay_reason` field contains the recorded category associated with the shipment.

---

## 4.3 fact_inventory

### Purpose

Stores inventory records used to evaluate inventory availability and stockout exposure.

**Primary Key:** `inventory_id`

**Record Count:** 30,000

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `inventory_id` | VARCHAR(20) | Unique inventory record identifier |
| `date_key` | INTEGER | Associated calendar date |
| `product_id` | VARCHAR(20) | Product associated with inventory |
| `warehouse_id` | VARCHAR(20) | Warehouse associated with inventory |
| `opening_stock` | INTEGER | Opening inventory quantity |
| `closing_stock` | INTEGER | Closing inventory quantity |
| `reorder_point` | INTEGER | Inventory replenishment threshold |
| `stockout_flag` | BOOLEAN | Indicator identifying a stockout record |

### Foreign Keys

| Column | References |
|---|---|
| `date_key` | `dim_date.date_key` |
| `product_id` | `dim_product.product_id` |
| `warehouse_id` | `dim_warehouse.warehouse_id` |

### Analytical Usage

- Stockout rate
- Product category inventory analysis
- Inventory availability
- Weighted inventory buffer analysis
- Reorder point comparisons

### Stockout Indicator

The project calculates stockout rates using:

```sql
stockout_flag = TRUE
```

### Important Note

A stockout record does not automatically represent a lost customer order.

The stockout rate is based on inventory records rather than customer transactions.

---

## 4.4 fact_returns

### Purpose

Stores product return information.

**Primary Key:** `return_id`

**Record Count:** 2,405

### Field Definitions

| Column | PostgreSQL Type | Description |
|---|---|---|
| `return_id` | VARCHAR(20) | Unique return identifier |
| `order_id` | VARCHAR(20) | Order associated with return |
| `product_id` | VARCHAR(20) | Product associated with return |
| `return_date` | DATE | Recorded return date |
| `return_reason` | VARCHAR(100) | Recorded reason for return |
| `return_cost` | NUMERIC(12,2) | Monetary cost associated with return |

### Foreign Keys

| Column | References |
|---|---|
| `order_id` | `fact_orders.order_id` |
| `product_id` | `dim_product.product_id` |

### Analytical Usage

- Return rates
- Return costs
- Category-level return analysis
- Customer segment return analysis

### Return Rate Consideration

The executive KPI view calculates return rate using the number of distinct orders associated with returns.

```text
Distinct Orders With Returns / Total Orders × 100
```

This avoids treating multiple return records for one order as multiple returned orders.

---

# 5. Database Relationships

The following foreign key relationships are implemented in the PostgreSQL schema.

| Source Table | Foreign Key | Referenced Table | Primary Key |
|---|---|---|---|
| `dim_product` | `supplier_id` | `dim_supplier` | `supplier_id` |
| `fact_orders` | `customer_id` | `dim_customer` | `customer_id` |
| `fact_orders` | `product_id` | `dim_product` | `product_id` |
| `fact_orders` | `warehouse_id` | `dim_warehouse` | `warehouse_id` |
| `fact_shipments` | `order_id` | `fact_orders` | `order_id` |
| `fact_inventory` | `date_key` | `dim_date` | `date_key` |
| `fact_inventory` | `product_id` | `dim_product` | `product_id` |
| `fact_inventory` | `warehouse_id` | `dim_warehouse` | `warehouse_id` |
| `fact_returns` | `order_id` | `fact_orders` | `order_id` |
| `fact_returns` | `product_id` | `dim_product` | `product_id` |

### Relationship Considerations

The analytical views aggregate data at different levels.

Examples include:

- One row per warehouse
- One row per supplier
- One row per product category and subcategory
- One row per customer segment and region

These reporting grains must be considered when interpreting totals and aggregating metrics.

---

# 6. Analytical Views

The project includes six PostgreSQL analytical views.

## 6.1 vw_executive_kpi_summary

### Purpose

Provides executive-level supply chain performance indicators.

### Output Fields

| Field | Description |
|---|---|
| `total_orders` | Total recorded orders |
| `total_revenue` | Value of orders whose status is not `Cancelled` |
| `order_fulfillment_rate_pct` | Percentage of orders whose status is not `Cancelled` |
| `on_time_delivery_rate_pct` | Percentage of shipments with zero delay days |
| `late_shipment_rate_pct` | Percentage of shipments with positive delay days |
| `average_delay_days` | Average shipment delay |
| `stockout_rate_pct` | Percentage of inventory records flagged as stockouts |
| `return_rate_pct` | Percentage of distinct orders associated with returns |
| `shipping_cost_per_order` | Average shipping cost per shipment record |

### Important Definition Notes

The SQL view retains the field name `total_revenue`.

However, its implemented calculation sums order values for orders whose status is not `Cancelled`.

The field does not independently establish recognized accounting revenue.

Likewise, the current fulfillment metric is status-based rather than directly shipment-based.

The `shipping_cost_per_order` field is calculated using average shipment cost.

These details should be considered when labeling or comparing dashboard KPIs.

---

## 6.2 vw_warehouse_performance

### Purpose

Provides shipment performance metrics by warehouse.

### Output Fields

| Field | Description |
|---|---|
| `warehouse_id` | Warehouse identifier |
| `warehouse_name` | Warehouse name |
| `region` | Warehouse region |
| `state` | Warehouse state |
| `total_orders` | Distinct orders represented in joined shipment records |
| `total_revenue` | Sum of order values in the joined shipment population |
| `late_shipments` | Number of shipment records with positive delay days |
| `late_shipment_rate_pct` | Delayed shipments divided by total shipments |
| `average_delay_days` | Average shipment delay |
| `average_shipping_cost` | Average shipment cost |
| `capacity_units` | Warehouse capacity |
| `labor_hours_available` | Available labor hours |

### Reporting Grain

One row per warehouse.

---

## 6.3 vw_product_stockout_risk

### Purpose

Provides inventory metrics by product category and subcategory.

### Output Fields

| Field | Description |
|---|---|
| `category` | Product category |
| `subcategory` | Product subcategory |
| `inventory_records` | Number of inventory records |
| `stockout_records` | Number of records flagged as stockouts |
| `stockout_rate_pct` | Percentage of records flagged as stockouts |
| `avg_opening_stock` | Average opening inventory quantity |
| `avg_closing_stock` | Average closing inventory quantity |
| `avg_reorder_point` | Average reorder point |

### Reporting Grain

One row per product category and subcategory combination.

### Important Aggregation Note

When calculating category-level averages from subcategory-level results, averages should be weighted by the relevant inventory record counts.

This avoids giving small and large subcategories equal influence when their underlying record counts differ.

---

## 6.4 vw_supplier_delay_risk

### Purpose

Provides supplier-associated shipment delay metrics.

### Output Fields

| Field | Description |
|---|---|
| `supplier_id` | Supplier identifier |
| `supplier_name` | Supplier name |
| `supplier_region` | Supplier region |
| `standard_lead_time_days` | Expected supplier lead time |
| `supplier_risk_score` | Synthetic supplier risk rating |
| `total_orders` | Distinct orders associated with the supplier in the joined shipment population |
| `delayed_orders` | Count of joined shipment records with positive delay days |
| `supplier_delay_rate_pct` | Percentage of supplier-associated shipment records delayed |
| `avg_delay_days` | Average shipment delay |
| `total_shipping_cost` | Sum of shipment costs |

### Reporting Grain

One row per supplier.

### Important Definition Note

The SQL field `delayed_orders` counts delayed shipment records rather than explicitly counting distinct delayed orders.

This difference matters if an order can have multiple shipment records.

The supplier delay rate is also shipment-based.

---

## 6.5 vw_ai_issue_candidates

### Purpose

Identifies operational issues from calculated KPIs.

Although the view retains its original AI-themed name, it uses SQL rules rather than a machine learning model or LLM.

### Output Fields

| Field | Description |
|---|---|
| `issue_type` | Operational issue category |
| `business_area` | Affected supplier, warehouse, or product category |
| `metric_name` | KPI name |
| `metric_value` | Calculated KPI value |
| `severity` | Severity assigned using predefined thresholds |
| `severity_rank` | Numeric severity ranking |
| `recommended_analysis_action` | Rule-generated analysis recommendation |

### Severity Thresholds

| Metric Value | Severity | Severity Rank |
|---|---|---:|
| 20% or higher | High | 1 |
| 10% to less than 20% | Medium | 2 |
| Below 10% | Low | 3 |

The same numerical thresholds are applied to the operational issue candidates.

They are project-defined analytical thresholds rather than externally validated business risk standards.

### Supported Issue Types

- Product Stockout Risk
- Warehouse Delay Risk
- Supplier Delay Risk

### Reported Results

| Issue Type | Records |
|---|---:|
| Product Stockout Risk | 6 |
| Warehouse Delay Risk | 10 |
| Supplier Delay Risk | 25 |
| **Total** | **41** |

---

## 6.6 vw_customer_segment_performance

### Purpose

Provides order value, shipment delay, and return metrics by customer segment and region.

### Reporting Grain

One row per customer segment and region combination.

### Output Fields

| Field | Description |
|---|---|
| `customer_segment` | Retail, Wholesale, or Enterprise |
| `region` | Customer geographic region |
| `total_orders` | Number of orders |
| `total_revenue` | Total recorded order value |
| `average_order_value` | Average order value |
| `delayed_orders` | Orders with at least one delayed shipment |
| `late_shipment_rate_pct` | Delayed shipment records divided by all shipment records |
| `total_returns` | Orders associated with one or more return records |
| `return_rate_pct` | Percentage of orders associated with returns |

### SQL Design

The view uses common table expressions to aggregate shipment and return records before joining them to orders.

This helps prevent inflated order values caused by joins across multiple fact records.

### KPI Distinction

The field `delayed_orders` is an order-level count.

The field `late_shipment_rate_pct` uses a shipment-level denominator.

These are related but distinct metrics.

### Order Value Consideration

The field `total_revenue` is named according to the implemented SQL view.

Its calculation represents total recorded order value.

It should not independently be interpreted as recognized accounting revenue.

---

# 7. KPI Dictionary

The following table summarizes the principal KPIs used in the project.

| KPI | Definition | Primary Source |
|---|---|---|
| Total Orders | Count of all recorded orders | `fact_orders` |
| Total Order Value | Sum of order values across all orders | `fact_orders` |
| Non-Cancelled Order Value | Sum of order values for orders not marked Cancelled | `vw_executive_kpi_summary` |
| Shipped Order Value | Sum of order values for orders associated with shipments | Order/shipment reconciliation |
| Order Fulfillment Rate | Percentage of non-cancelled orders in the current executive SQL view | `vw_executive_kpi_summary` |
| On-Time Delivery Rate | Shipments with zero delay divided by total shipments | `fact_shipments` |
| Late Shipment Rate | Shipments with positive delay divided by total shipments | `fact_shipments` |
| Average Shipment Delay | Average shipment delay days | `fact_shipments` |
| Stockout Rate | Stockout records divided by inventory records | `fact_inventory` |
| Return Rate | Distinct orders with returns divided by total orders | `fact_returns`, `fact_orders` |
| Average Shipping Cost | Average shipping cost per shipment record | `fact_shipments` |
| Supplier Delay Rate | Delayed supplier-associated shipments divided by total supplier-associated shipments | `vw_supplier_delay_risk` |
| Inventory Buffer | Weighted average closing stock minus weighted average reorder point | `vw_product_stockout_risk` and Power BI |
| Customer Segment Return Rate | Orders with returns divided by total segment orders | `vw_customer_segment_performance` |
| Customer Segment Shipment Delay Rate | Delayed shipments divided by total shipments in the segment | `vw_customer_segment_performance` |

---

# 8. Validated Project Metrics

The completed project reports the following values.

| Metric | Value |
|---|---:|
| Total Orders | 25,000 |
| Total Shipments | 24,368 |
| Inventory Records | 30,000 |
| Return Records | 2,405 |
| Total Order Value | $25,502,432.32 |
| Shipped Order Value | $24,880,425.10 |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |
| Average Shipment Delay | 0.60 days |

### Important Note

These values describe the project's synthetic dataset.

They do not represent actual company performance.

---

# 9. Business Analysis Automation Data

The project also uses structured CSV datasets to support automated business analysis.

These CSV files are not part of the nine PostgreSQL base tables.

## 9.1 Operational Issue Candidates

**File:**

`data/processed/ai_issue_candidates.csv`

### Fields

| Field | Description |
|---|---|
| `issue_type` | Operational issue category |
| `business_area` | Associated operational area |
| `metric_name` | KPI name |
| `metric_value` | KPI value |
| `severity` | Assigned severity |
| `severity_rank` | Numeric severity ranking |
| `recommended_analysis_action` | Suggested analysis action, where included in the exported source |

The Python business analysis script uses the issue and KPI fields to generate structured documentation.

---

## 9.2 Business Analysis Outputs

**File:**

`data/processed/ai_business_outputs.csv`

### Fields

| Field | Description |
|---|---|
| `issue_type` | Operational issue category |
| `business_area` | Associated operational area |
| `metric_name` | KPI name |
| `metric_value` | KPI value |
| `severity` | Assigned severity |
| `severity_rank` | Numerical severity ranking |
| `business_issue_summary` | Rule-generated issue summary |
| `root_cause_hypothesis` | Potential operational explanation |
| `business_requirement` | Proposed business requirement |
| `jira_epic` | Generated epic title |
| `jira_user_story` | Generated user story |
| `acceptance_criteria` | Proposed acceptance criteria |
| `executive_recommendation` | Proposed management action |
| `human_review_required` | Human review indicator |

### Implementation Note

These outputs are generated using Python conditional rules and predefined text templates.

The current workflow does not call an LLM.

---

## 9.3 Jira-Style Backlog

**File:**

`jira/jira_user_stories.csv`

### Fields

| Field | Description |
|---|---|
| `issue_key` | Locally generated sequential issue identifier |
| `issue_type` | Backlog issue type |
| `summary` | Generated issue summary |
| `epic_name` | Proposed epic title |
| `user_story` | Proposed user story |
| `acceptance_criteria` | Proposed acceptance criteria |
| `priority` | Priority mapped from operational severity |
| `status` | Initial backlog status |
| `labels` | Predefined categorization labels |
| `business_area` | Associated operational area |
| `metric_name` | KPI name |
| `metric_value` | KPI value |
| `severity` | Operational severity |
| `human_review_required` | Human review indicator |

The backlog generator produces a CSV file.

It does not automatically create issues in Jira.

---

# 10. Data Quality and Validation

The project includes data quality checks implemented in:

`python/data_quality_checks.py`

### Validation Areas

- Missing values
- Duplicate identifiers
- Foreign key consistency
- Dataset record counts

### Validation Report

`docs/data_quality_report.md`

The local data quality checks were reported as passing.

### Database Validation

PostgreSQL validation also included record-count checks and order-value reconciliation.

Additional details are documented in:

`docs/postgresql_load_validation.md`

---

# 11. Data Modeling Considerations

## 11.1 Reporting Grain

Different analytical views operate at different levels.

For example:

- Executive KPIs represent overall performance.
- Warehouse metrics are aggregated by warehouse.
- Supplier metrics are aggregated by supplier.
- Inventory metrics are grouped by category and subcategory.
- Customer metrics are grouped by segment and region.

Measures should be interpreted according to their reporting grain.

## 11.2 Aggregated Percentages

Rates should be recalculated from underlying counts when aggregating multiple groups.

For example:

```text
Combined Late Shipment Rate =
Total Delayed Shipments / Total Shipments × 100
```

Directly summing or averaging percentages can produce misleading results when group sizes differ.

## 11.3 Multiple Fact Tables

Combining orders, shipments, and returns without appropriate aggregation can duplicate records and inflate monetary totals.

The customer segment view addresses this risk by aggregating shipment and return data before joining it to orders.

## 11.4 Monetary Definitions

Order value, shipped order value, shipping cost, and return cost represent different financial concepts.

They should not be treated as interchangeable metrics.

The project does not independently establish recognized revenue or profitability.

---

# 12. Current Limitations

The dataset has several limitations:

- All operational records are synthetic.
- Supplier risk scores are simulated.
- Operational findings do not establish causation.
- No production ERP system is connected.
- The project does not include actual customer financial records.
- Some SQL output field names retain their original development terminology.
- KPI definitions require attention to denominators and reporting grain.
- The automated business analysis workflow uses predefined templates.
- The project does not currently use autonomous AI agents or LLM-generated outputs.
- Generated requirements and recommendations require human review.

---

# 13. Related Project Files

### Database Implementation

- [Create Database Tables](../sql/01_create_tables.sql)
- [KPI Analysis Queries](../sql/03_kpi_analysis_queries.sql)
- [Analytical SQL Views](../sql/04_create_analytics_views.sql)
- [Customer Segment View](../sql/05_create_customer_segment_view.sql)

### Python Implementation

- [Synthetic Data Generator](../python/data_generator.py)
- [Data Quality Checks](../python/data_quality_checks.py)
- [Business Analyst Workflow](../python/ai_business_analyst_workflow.py)
- [Jira Backlog Generator](../python/jira_backlog_generator.py)

### Documentation

- [Project README](../README.md)
- [Project Charter](project_charter.md)
- [PostgreSQL Load Validation](postgresql_load_validation.md)
- [SQL KPI Results Summary](sql_kpi_results_summary.md)
- [Power BI Documentation](../powerbi/powerbi_dashboard_documentation.md)

---

# 14. Conclusion

The OpsPilot data dictionary documents the relational tables, analytical views, and structured workflow datasets used in the project.

The database contains five dimension tables, four fact tables, and six analytical views.

These components support the analysis of 25,000 orders, 24,368 shipments, 30,000 inventory records, and 2,405 return records.

The PostgreSQL data model provides the foundation for five Power BI dashboard pages and the Python-based business analysis workflow.

The project demonstrates the practical integration of data modeling, SQL analytics, KPI development, business intelligence, and structured workflow automation.
