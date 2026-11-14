
OpsPilot AI | Business Analyst Workbench
Supply Chain Analytics, Power BI Dashboards & Automated Business Analysis
Technologies: Python | pandas | NumPy | PostgreSQL | SQL | Power BI | DAX | Rule-Based Automation | Jira-Style Backlogs | GitHub

Project Overview
OpsPilot AI is an end-to-end supply chain analytics and business analysis portfolio project. It uses synthetic operational data to demonstrate a workflow from data generation and validation to SQL-based analysis, interactive Power BI reporting, and automated business analysis deliverables.

I developed a PostgreSQL database and analytical views, built a five-page Power BI report, and implemented Python scripts that translate identified operational issues into root-cause hypotheses, proposed requirements, recommendations, acceptance criteria, and Jira-style user stories.

Implementation note: The current business analysis generator is rule-based: it uses Python conditional logic and predefined text templates. It does not invoke an LLM, operate as an autonomous AI agent, or create issues directly in Jira. The project name OpsPilot AI reflects its concept and potential direction, not a claim that those capabilities are currently implemented.

Business Questions
Where is stockout exposure highest across products and categories?
Which warehouses and regions have elevated late shipment rates?
Which suppliers have higher delay rates?
How do order value, delay rates, and return rates vary by customer segment?
Which operational issues should receive attention first?
How can those findings be structured as business requirements and development-ready user stories?
Workflow and Architecture
Python data_generator.py
        |
        v
Synthetic CSV data (data/raw/)
        |
        +--> Python data_quality_checks.py --> Data quality report
        |
        v
PostgreSQL tables (opspilot schema)
        |
        v
SQL KPI queries and analytical views
        |
        +-------------------------> Power BI: 5-page report
        |
        v
Issue candidates exported to data/processed/ai_issue_candidates.csv
        |
        v
Python rule-based business analyst workflow
        |
        v
ai_business_outputs.csv --> Interactive business analysis in Power BI
        |
        v
Python Jira backlog generator --> jira/jira_user_stories.csv
The SQL-to-CSV handoff is a manual export step in the current implementation. The backlog generator creates a Jira-style CSV, not a live Jira integration. Power BI reads PostgreSQL analytical views and prepared business analysis outputs.

Power BI Dashboard Showcase
Open the Power BI report · Read dashboard documentation

1. Executive Overview


Consolidates supply chain KPIs and prioritizes identified operational issues.

KPI	Reported value
Total orders	25,000
Shipped order value	$24.88M
Order fulfillment rate	97.47%
On-time delivery rate	86.82%
Late shipment rate	13.18%
Stockout rate	31.64%
Return rate	9.62%
Shipping cost per order	$19.08
The issue tables display severity classifications and rule-generated proposed actions. These are suggestions for analyst review, not confirmed root causes.

2. Inventory & Stockout Risk


Stockout rates by category and the ten highest-rate subcategories.
Weighted average inventory buffers and stockout record counts.
Grocery has a reported category stockout rate of approximately 31.93%; Computer Accessories has a reported subcategory rate of approximately 34.81%.
These findings point to areas for replenishment review; they do not establish the causes of stockouts.

3. Warehouse & Shipment Performance


Compares delays by warehouse and region, including a warehouse detail table and conditional risk formatting.

Warehouse	Late shipment rate
Los Angeles Fulfillment Center	17.13%
Columbus Distribution Hub	16.64%
Dallas Distribution Hub	15.32%
The report shows an overall late shipment rate of 13.18% and a weighted average shipment delay of approximately 0.60 days.

4. Supplier & Customer Performance


Displays supplier-level delay rates, order value by customer segment and region, customer-segment delayed-order rates, and return rates.

Supplier	Delay rate
Supplier 17	15.60%
Supplier 2	15.02%
Supplier 9	14.75%
Supplier 20	14.31%
Supplier 14	14.17%
Customer segment	Reported delayed-order rate	Return rate
Wholesale	13.20%	9.98%
Retail	12.82%	9.48%
Enterprise	12.11%	9.62%
Retail has the highest total order value in this synthetic dataset. Segment differences are descriptive, not proof of causation or statistically significant effects.

5. Business Insights & Recommendations


Select an issue from the dashboard's issue table to display its associated:

Root-cause hypothesis
Executive recommendation
Proposed business requirement
Jira-style user story
The underlying Python generator selects text templates using issue type and values from the issue candidates. Power BI uses DAX measures, including SELECTEDVALUE(), to show the relevant text for the selected issue. The current screenshot and report may still use the original “AI Business Insights & Recommendations” page label; the implementation is rule-based.

Technical Implementation
Python: Data Generation and Quality Checks
`python/data_generator.py` generates nine synthetic CSV tables (five dimensions and four facts) using a fixed random seed.
`python/data_quality_checks.py` checks record counts, missing values, duplicate identifiers, and foreign key references; results are written to `docs/data_quality_report.md`.
The generated source data are illustrative, not company operational records.
PostgreSQL: Relational Storage and KPI Views
The local database is named opspilot_ai, using the schema opspilot.

Script	Function
`01_create_tables.sql`
Creates relational tables
`03_kpi_analysis_queries.sql`
Analyzes operational KPIs
`04_create_analytics_views.sql`
Creates reporting views
`05_create_customer_segment_view.sql`
Creates the customer-segment performance view
The customer view aggregates shipment and return records to the order level before combining them with orders, avoiding one-to-many join inflation of order values.

Automated Business Analysis and Jira-Style Backlog
`python/ai_business_analyst_workflow.py` reads `data/processed/ai_issue_candidates.csv` and produces `ai_business_outputs.csv`.
Its conditional functions generate issue summaries, hypotheses, requirements, epics, stories, acceptance criteria, and recommendations using predefined rules/templates.
Each generated record includes a human_review_required flag.
`python/jira_backlog_generator.py` converts the analysis output into `jira/jira_user_stories.csv`.
Local execution check: The business analysis script processed 41 issue candidates, and the backlog script produced 41 Jira-style stories. These are generated drafts, not tickets submitted to a Jira instance.

Power BI and DAX
The report includes five pages, custom DAX measures, issue-selection interactions, conditional formatting, and comparisons across products, warehouses, suppliers, and customer segments. See the Power BI documentation for page-by-page details.

Data Validation and KPI Interpretation
The following order value totals were reconciled during the project:

Measure	Value
All orders	25,000
Orders with shipment records	24,368
Orders without shipment records	632
Total order value (all orders)	$25,502,432.32
Shipped order value	$24,880,425.10
Order value without shipment records	$622,007.22
Reconciliation: $24,880,425.10 + $622,007.22 = $25,502,432.32.

Interpretation: Total order value includes all orders; shipped order value includes orders that have shipment records. These are different populations, and neither should automatically be described as recognized revenue.

Running the Python Components
From the repository root, with Python installed:

python -m pip install -r requirements.txt
python python/data_generator.py
python python/data_quality_checks.py
The data generator writes files under data/raw/; the quality checker writes docs/data_quality_report.md.

To reproduce the database-driven portion, create the PostgreSQL database and load generated CSV files using the schema and load order documented in `docs/postgresql_load_validation.md`. Apply the SQL view scripts and export the resulting issue candidates to data/processed/ai_issue_candidates.csv. This extraction is not automated by the Python scripts in the repository.

With the issue-candidate CSV present, run:

python python/ai_business_analyst_workflow.py
python python/jira_backlog_generator.py
These commands regenerate data/processed/ai_business_outputs.csv and jira/jira_user_stories.csv, respectively, overwriting existing copies. They were run successfully locally, but a clean, automated database-to-dashboard rebuild has not been independently established.

To view the report, open `powerbi/OpsPilot_AI_Dashboard.pbix` in Power BI Desktop. Refresh requires access to the configured PostgreSQL source; the report is not a hosted public Power BI application.

Repository Structure
OpsPilot-AI-Business-Analyst-Workbench/
├── README.md
├── requirements.txt
├── data/
│   ├── raw/                         # Generated source CSV files
│   └── processed/
│       ├── ai_issue_candidates.csv
│       └── ai_business_outputs.csv
├── docs/                            # Data, SQL and workflow documentation
├── images/
│   └── Dahboard Images/             # Five report screenshots (folder name as stored)
├── jira/
│   └── jira_user_stories.csv
├── powerbi/
│   ├── OpsPilot_AI_Dashboard.pbix
│   └── powerbi_dashboard_documentation.md
├── python/
│   ├── data_generator.py
│   ├── data_quality_checks.py
│   ├── ai_business_analyst_workflow.py
│   └── jira_backlog_generator.py
└── sql/
    ├── 01_create_tables.sql
    ├── 03_kpi_analysis_queries.sql
    ├── 04_create_analytics_views.sql
    └── 05_create_customer_segment_view.sql
Skills Demonstrated
Business analysis: KPI definition, issue prioritization, root-cause hypothesis framing, proposed requirements, user stories, acceptance criteria, and stakeholder-oriented recommendations.

Analytics and BI: Python, data quality validation, relational modeling, SQL aggregation and analytical views, Power BI, DAX, data reconciliation, and executive dashboard design.

Workflow automation: Deterministic rule-based text generation and structured CSV backlog preparation with a human-review checkpoint.

Limitations and Future Work
Synthetic data: Results illustrate techniques and do not represent any real organization's performance.
Hypotheses, not verified causes: Recommendations require operational evidence and stakeholder review.
Rule-based, not LLM-powered: No LLM API calls or autonomous agents are implemented in the reviewed workflow.
Jira-style CSV, not Jira integration: The backlog is exported as a file; no Jira tickets are created through an API.
Partly manual pipeline: PostgreSQL loading, issue-candidate extraction, and Power BI source setup require local configuration.
Potential enhancements include automated extraction and refresh, automated tests for KPI parity, live Jira integration, optional LLM-assisted drafting with evaluation safeguards, and a deployable interactive report.

Project purpose: Demonstrate the progression from operational data to validated KPIs, decision-focused reporting, and structured business analysis deliverables—while clearly separating implemented features from future possibilities.
