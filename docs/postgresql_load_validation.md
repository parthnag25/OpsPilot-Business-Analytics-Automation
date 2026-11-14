# OpsPilot | PostgreSQL Load Validation

## 1. Overview

This document describes the PostgreSQL database implementation, data loading process, validation procedures, and analytical views used in the OpsPilot Business Analyst Workbench.

OpsPilot uses synthetic supply chain data generated with Python and stored in PostgreSQL.

The database supports SQL-based operational analysis, Power BI reporting, and automated business analysis workflows.

### Validation Objectives

The validation process aims to:

- Confirm that the expected database tables exist.
- Verify record counts across operational datasets.
- Check primary key and foreign key relationships.
- Confirm that analytical SQL views are available.
- Reconcile order and shipment populations.
- Validate important KPI calculations.
- Document the limitations of the completed testing.

---

## 2. Database Configuration

| Property | Value |
|---|---|
| Database | `opspilot_ai` |
| Schema | `opspilot` |
| Database Platform | PostgreSQL |
| Database Administration | pgAdmin 4 |
| Source Data | Synthetic CSV files |
| Source Directory | `data/raw/` |
| Load Method | pgAdmin Import/Export Data |
| Analytical Layer | PostgreSQL SQL Views |
| Reporting Layer | Microsoft Power BI |
| Automation Layer | Python |

### Database Connection

The Power BI report connects to the local PostgreSQL database.

```text
Server: localhost
Database: opspilot_ai
Schema: opspilot
```

This connection reflects the local development environment.

Other users must configure PostgreSQL locally and adjust the Power BI data source connection if necessary.

---

## 3. Database Schema

The relational database contains nine tables.

These are organized into five dimension tables and four fact tables.

### Dimension Tables

| Table | Description |
|---|---|
| `dim_date` | Calendar information |
| `dim_supplier` | Supplier details and risk attributes |
| `dim_product` | Product information and supplier relationships |
| `dim_warehouse` | Warehouse locations, capacity, and labor availability |
| `dim_customer` | Customer segmentation and geographic information |

### Fact Tables

| Table | Description |
|---|---|
| `fact_orders` | Customer orders and fulfillment information |
| `fact_shipments` | Shipment details, delays, and shipping costs |
| `fact_inventory` | Inventory levels, reorder points, and stockout indicators |
| `fact_returns` | Product returns and associated costs |

### Schema Creation Script

The database structure is defined in:

`sql/01_create_tables.sql`

This script creates the `opspilot` schema and defines the dimension and fact tables.

It also establishes primary key and foreign key constraints.

**Important:** The script contains `DROP TABLE IF EXISTS` statements.

Executing it against an existing populated database can remove operational tables and their stored data. It should therefore be used only in an appropriate development or rebuild environment.

---

## 4. Synthetic Data Generation

Synthetic operational data is generated using:

`python/data_generator.py`

The script creates nine CSV files in:

`data/raw/`

### Generated Dataset Counts

| Dataset | Generated Records |
|---|---:|
| `dim_date.csv` | 731 |
| `dim_supplier.csv` | 25 |
| `dim_product.csv` | 100 |
| `dim_warehouse.csv` | 10 |
| `dim_customer.csv` | 2,000 |
| `fact_orders.csv` | 25,000 |
| `fact_shipments.csv` | 24,368 |
| `fact_inventory.csv` | 30,000 |
| `fact_returns.csv` | 2,405 |

### Execution Command

From the repository root:

```bash
python python/data_generator.py
```

The generator uses a fixed random seed to support reproducible synthetic data generation.

Running the script overwrites the existing generated CSV files.

---

## 5. Data Quality Validation

Before loading the generated data, the project uses:

`python/data_quality_checks.py`

### Validation Categories

The script checks:

- Dataset record counts
- Missing values
- Duplicate identifiers
- Foreign key consistency between related datasets

### Execution Command

```bash
python python/data_quality_checks.py
```

### Output

The validation report is generated at:

`docs/data_quality_report.md`

### Validation Result

During local project testing, the script executed successfully.

All implemented data quality checks were reported as passing.

This validates the checks implemented in the Python script. It does not independently establish that every possible data quality issue has been excluded.

---

## 6. Data Loading Process

The generated CSV files were loaded into PostgreSQL using pgAdmin.

### Recommended Load Order

| Step | Table | Reason |
|---:|---|---|
| 1 | `dim_date` | Parent table for inventory dates |
| 2 | `dim_supplier` | Parent table for products |
| 3 | `dim_warehouse` | Parent table for orders and inventory |
| 4 | `dim_customer` | Parent table for orders |
| 5 | `dim_product` | References suppliers |
| 6 | `fact_orders` | References customers, products, and warehouses |
| 7 | `fact_shipments` | References orders |
| 8 | `fact_inventory` | References dates, products, and warehouses |
| 9 | `fact_returns` | References orders and products |

Loading parent tables before dependent fact tables helps satisfy foreign key constraints.

### General Import Procedure

1. Open pgAdmin 4.
2. Connect to the `opspilot_ai` database.
3. Expand the `opspilot` schema.
4. Locate the required table.
5. Open **Import/Export Data**.
6. Select the corresponding CSV file.
7. Configure CSV format and header handling.
8. Execute the import.
9. Confirm that the operation completed successfully.
10. Repeat for the remaining tables in dependency order.

The CSV columns must correspond to the database table definitions.

---

## 7. PostgreSQL Row Count Validation

The following query checks the record counts of all nine tables.

```sql
SELECT 'dim_date' AS table_name, COUNT(*) AS row_count
FROM opspilot.dim_date

UNION ALL

SELECT 'dim_supplier', COUNT(*)
FROM opspilot.dim_supplier

UNION ALL

SELECT 'dim_product', COUNT(*)
FROM opspilot.dim_product

UNION ALL

SELECT 'dim_warehouse', COUNT(*)
FROM opspilot.dim_warehouse

UNION ALL

SELECT 'dim_customer', COUNT(*)
FROM opspilot.dim_customer

UNION ALL

SELECT 'fact_orders', COUNT(*)
FROM opspilot.fact_orders

UNION ALL

SELECT 'fact_shipments', COUNT(*)
FROM opspilot.fact_shipments

UNION ALL

SELECT 'fact_inventory', COUNT(*)
FROM opspilot.fact_inventory

UNION ALL

SELECT 'fact_returns', COUNT(*)
FROM opspilot.fact_returns

ORDER BY table_name;
```

### Expected Results

| Table | Expected Rows |
|---|---:|
| `dim_customer` | 2,000 |
| `dim_date` | 731 |
| `dim_product` | 100 |
| `dim_supplier` | 25 |
| `dim_warehouse` | 10 |
| `fact_inventory` | 30,000 |
| `fact_orders` | 25,000 |
| `fact_returns` | 2,405 |
| `fact_shipments` | 24,368 |

### Validation Status

The principal fact-table counts were checked in PostgreSQL during local testing and matched the expected results.

The project also successfully regenerated the corresponding synthetic datasets.

Matching record counts confirms the expected table populations but does not establish record-by-record equivalence between the database and regenerated CSV files.

---

## 8. Primary Key Validation

Primary keys are defined in:

`sql/01_create_tables.sql`

These constraints prevent duplicate primary key values in the corresponding tables.

### Example Validation Query

```sql
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM opspilot.fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

### Expected Result

No rows should be returned.

Similar checks can be performed for the remaining primary key columns.

---

## 9. Foreign Key Validation

The database schema includes foreign key constraints connecting the dimension and fact tables.

### Example: Order-to-Customer Validation

```sql
SELECT COUNT(*) AS invalid_customer_references
FROM opspilot.fact_orders o
LEFT JOIN opspilot.dim_customer c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

### Expected Result

```text
invalid_customer_references = 0
```

### Example: Shipment-to-Order Validation

```sql
SELECT COUNT(*) AS invalid_order_references
FROM opspilot.fact_shipments s
LEFT JOIN opspilot.fact_orders o
    ON s.order_id = o.order_id
WHERE o.order_id IS NULL;
```

### Expected Result

```text
invalid_order_references = 0
```

The Python data quality script also validates relationships between generated source datasets.

These SQL queries are provided for repeatable database-level validation.

---

## 10. Order and Shipment Reconciliation

The project contains:

- 25,000 orders
- 24,368 shipment records

The reported dataset also contains 24,368 orders associated with shipments.

### Order Population Validation

```sql
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE EXISTS (
            SELECT 1
            FROM opspilot.fact_shipments s
            WHERE s.order_id = o.order_id
        )
    ) AS orders_with_shipments,
    COUNT(*) FILTER (
        WHERE NOT EXISTS (
            SELECT 1
            FROM opspilot.fact_shipments s
            WHERE s.order_id = o.order_id
        )
    ) AS orders_without_shipments
FROM opspilot.fact_orders o;
```

### Expected Results

| Metric | Value |
|---|---:|
| Total Orders | 25,000 |
| Orders With Shipments | 24,368 |
| Orders Without Shipments | 632 |

### Interpretation

The difference between total orders and orders with shipment records represents orders without matching shipment records.

This is relevant when defining fulfillment metrics and comparing order-value populations.

---

## 11. Order Value Reconciliation

The project distinguishes total order value from shipped order value.

### Validation Query

```sql
SELECT
    ROUND(SUM(o.order_value), 2) AS total_order_value,

    ROUND(
        SUM(o.order_value) FILTER (
            WHERE EXISTS (
                SELECT 1
                FROM opspilot.fact_shipments s
                WHERE s.order_id = o.order_id
            )
        ),
        2
    ) AS shipped_order_value,

    ROUND(
        SUM(o.order_value) FILTER (
            WHERE NOT EXISTS (
                SELECT 1
                FROM opspilot.fact_shipments s
                WHERE s.order_id = o.order_id
            )
        ),
        2
    ) AS order_value_without_shipments

FROM opspilot.fact_orders o;
```

### Validated Results

| Metric | Value |
|---|---:|
| Total Order Value | $25,502,432.32 |
| Shipped Order Value | $24,880,425.10 |
| Order Value Without Shipments | $622,007.22 |

### Reconciliation

```text
$24,880,425.10
+
$622,007.22
=
$25,502,432.32
```

The values reconcile.

### Business Interpretation

Total Order Value includes every order recorded in the orders fact table.

Shipped Order Value includes orders associated with shipment records.

These measures should not automatically be described as recognized accounting revenue.

---

## 12. Executive KPI Validation

The executive KPI view is:

`opspilot.vw_executive_kpi_summary`

### View Query

```sql
SELECT *
FROM opspilot.vw_executive_kpi_summary;
```

### Reported Results

| KPI | Result |
|---|---:|
| Total Orders | 25,000 |
| Reported Order Value | $24,880,425.10 |
| Order Fulfillment Rate | 97.47% |
| On-Time Delivery Rate | 86.82% |
| Late Shipment Rate | 13.18% |
| Average Shipment Delay | 0.60 days |
| Stockout Rate | 31.64% |
| Return Rate | 9.62% |
| Average Shipping Cost | $19.08 |

### KPI Definition Considerations

The current SQL view calculates `order_fulfillment_rate_pct` using the percentage of orders whose status is not `Cancelled`.

It does not directly calculate the percentage of orders with shipment records.

Although both measures produce the same reported value for the current synthetic dataset, they represent different definitions.

Similarly, the current SQL view calculates `shipping_cost_per_order` using the average shipping cost of shipment records.

The label should therefore be interpreted as an average shipment cost unless the reporting definition is intentionally changed.

These distinctions should be considered when reviewing or extending the Power BI model.

---

## 13. Analytical Views

The project uses reusable PostgreSQL analytical views.

### View Definitions

| View | Purpose |
|---|---|
| `vw_executive_kpi_summary` | Executive operational KPIs |
| `vw_warehouse_performance` | Warehouse shipment performance |
| `vw_product_stockout_risk` | Product category and subcategory inventory analysis |
| `vw_supplier_delay_risk` | Supplier-associated shipment performance |
| `vw_ai_issue_candidates` | Operational issue classification |
| `vw_customer_segment_performance` | Customer order value, shipment delay, and return analysis |

### SQL Files

The first five analytical views are created using:

`sql/04_create_analytics_views.sql`

The customer segment performance view is created using:

`sql/05_create_customer_segment_view.sql`

### View Verification Query

```sql
SELECT
    table_schema,
    table_name
FROM information_schema.views
WHERE table_schema = 'opspilot'
ORDER BY table_name;
```

### Expected Result

The six analytical views should be listed.

---

## 14. Customer Segment Performance View

The customer segment analysis uses:

`opspilot.vw_customer_segment_performance`

This view aggregates shipment and return records before joining them to orders.

### Purpose

The aggregation helps prevent order values from being multiplied when multiple shipment or return records are associated with an order.

### Output Fields

| Field | Description |
|---|---|
| `customer_segment` | Customer segment |
| `region` | Customer geographic region |
| `total_orders` | Number of orders |
| `total_revenue` | Total recorded order value |
| `average_order_value` | Average order value |
| `delayed_orders` | Orders associated with delayed shipments |
| `late_shipment_rate_pct` | Percentage of shipment records delayed |
| `total_returns` | Orders associated with at least one return |
| `return_rate_pct` | Percentage of orders associated with returns |

### Validation Query

```sql
SELECT *
FROM opspilot.vw_customer_segment_performance
ORDER BY customer_segment, region;
```

### Important Calculation Detail

The view's `late_shipment_rate_pct` uses:

```text
Delayed Shipments / Total Shipments × 100
```

The `delayed_orders` field is a separate order-level count.

These measures should not be treated as interchangeable when multiple shipments per order are possible.

---

## 15. Operational Issue Candidates

The project identifies operational risks through:

`opspilot.vw_ai_issue_candidates`

Despite its original name, the view applies SQL calculations and predefined severity thresholds.

It does not perform autonomous AI-based issue detection.

### Validation Query

```sql
SELECT
    issue_type,
    severity,
    COUNT(*) AS issue_count
FROM opspilot.vw_ai_issue_candidates
GROUP BY issue_type, severity
ORDER BY issue_type, severity;
```

### Reported Issue Distribution

| Issue Type | Count |
|---|---:|
| Supplier Delay Risk | 25 |
| Warehouse Delay Risk | 10 |
| Product Stockout Risk | 6 |
| **Total** | **41** |

### Reported Severity Distribution

| Severity | Count |
|---|---:|
| High | 6 |
| Medium | 34 |
| Low | 1 |
| **Total** | **41** |

The severity classifications are based on predefined numerical thresholds.

They have not been validated against an organization's actual risk appetite or operational impact.

---

## 16. Power BI Connection Validation

The completed Power BI report is stored at:

`powerbi/OpsPilot_AI_Dashboard.pbix`

### Connection Details

```text
PostgreSQL Server: localhost
Database: opspilot_ai
Schema: opspilot
```

The report uses PostgreSQL analytical views and the generated business analysis output.

### Local Validation

During local testing, the user confirmed that the Power BI report refresh completed.

This supports the conclusion that the existing local Power BI model can access its configured data sources.

It does not establish that the complete Power BI solution can be rebuilt automatically in a new environment.

---

## 17. Validation Summary

| Validation Area | Status |
|---|---|
| Synthetic data generation | Passed |
| Nine CSV datasets generated | Passed |
| Python data quality checks | Passed |
| PostgreSQL fact-table counts | Matched expected values |
| Order-value reconciliation | Matched documented totals |
| Business analysis Python workflow | Executed successfully |
| Jira-style backlog generator | Executed successfully |
| Power BI refresh | Completed locally |
| Fresh database rebuild | Not independently tested |
| Record-by-record CSV/database comparison | Not independently tested |

### Interpretation

The completed validation confirms that the main components functioned in the existing development environment.

A full clean-environment reproducibility test would require rebuilding the database, importing the datasets, recreating the analytical views, and reconnecting Power BI.

---

## 18. Limitations and Future Improvements

### Current Limitations

- The project uses synthetic operational data.
- Database imports were performed using pgAdmin.
- The pipeline is not fully orchestrated.
- Database and Power BI configuration depends on the local environment.
- Matching record counts do not establish complete data equivalence.
- Some SQL KPI labels should be interpreted according to their implemented definitions.
- The customer segment view includes a database-specific ownership statement.
- The project is not deployed as a production data platform.

### Potential Improvements

- Automated PostgreSQL database initialization
- Automated CSV loading
- Database migration scripts
- Row-level reconciliation
- SQL-based data quality tests
- Automated analytical view validation
- Environment-independent database configuration
- Automated Power BI refresh

These improvements are proposed rather than implemented functionality.

---

## 19. Related Project Files

### SQL

- [Database Table Definitions](../sql/01_create_tables.sql)
- [KPI Analysis Queries](../sql/03_kpi_analysis_queries.sql)
- [Analytical SQL Views](../sql/04_create_analytics_views.sql)
- [Customer Segment View](../sql/05_create_customer_segment_view.sql)

### Python

- [Synthetic Data Generator](../python/data_generator.py)
- [Data Quality Validation](../python/data_quality_checks.py)
- [Business Analysis Workflow](../python/ai_business_analyst_workflow.py)

### Documentation

- [Project README](../README.md)
- [Data Dictionary](data_dictionary.md)
- [SQL KPI Results](sql_kpi_results_summary.md)
- [Power BI Dashboard Documentation](../powerbi/powerbi_dashboard_documentation.md)

---

## 20. Conclusion

The PostgreSQL implementation provides the primary analytical data foundation for OpsPilot.

The completed project uses nine relational tables and six analytical views to support supply chain performance analysis.

Local testing confirmed successful synthetic data generation, data quality validation, database record-count checks, business analysis workflow execution, and Power BI refresh.

The database supports the project's five Power BI dashboard pages and provides structured operational issue candidates for Python-based business analysis automation.

The implementation demonstrates practical relational database development, SQL analytics, KPI validation, and business intelligence integration within a portfolio project.
