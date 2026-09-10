# Supply Chain & Inventory Analytics

An end-to-end data analytics project analyzing supply chain operations, inventory risk, supplier performance, delivery efficiency, product profitability, and business performance using PostgreSQL and Power BI.

## Project Overview

The objective of this project is to analyze a supply chain dataset and identify business insights related to:

- Overall business and order performance
- Warehouse performance
- Supplier reliability and lead times
- Delivery and carrier performance
- Inventory levels and reorder risks
- Product sales and profitability
- Customer purchasing behavior

The project follows an end-to-end analytics workflow:

PostgreSQL → SQL Analysis → Data Modeling → DAX → Power BI Dashboard → Business Insights

---

## Tools & Technologies

- PostgreSQL
- SQL
- Power BI
- DAX
- pgAdmin 4

### SQL Concepts Used

- SELECT, WHERE, ORDER BY
- Aggregate Functions
- GROUP BY and HAVING
- INNER JOIN / Multiple-table JOINs
- CASE WHEN
- NULL handling
- Subqueries
- Correlated Subqueries
- CTEs
- Date and time analysis
- Window functions
- Conditional aggregation

---

## Database Overview

The PostgreSQL database contains the following tables:

| Table | Description |
|---|---|
| customers | Customer information |
| warehouses | Warehouse and capacity information |
| suppliers | Supplier details, lead times and reliability |
| products | Product, pricing and supplier information |
| orders | Customer orders and order values |
| order_items | Products and quantities within each order |
| shipments | Shipment, carrier and delivery information |
| inventory | Warehouse-level inventory and reorder information |

### Dataset Size

- 100 orders
- 148 order items
- 25 products
- 20 customers
- 10 suppliers
- 5 warehouses
- 90 shipments
- 100 inventory records

---

## SQL Analysis

The SQL analysis was used to answer business questions across several areas.

### Business Performance

- Total revenue
- Total orders
- Average order value
- Order status distribution
- Revenue by warehouse
- Customer order performance

### Supplier Analysis

- Supplier lead times
- Supplier reliability
- Products supplied by each supplier
- Suppliers with above-average reliability
- Supplier risk based on lead time and reliability

### Delivery Analysis

- Shipment status
- Delivery duration
- Late shipments
- Late delivery rates
- Carrier performance
- Warehouse delivery performance

### Inventory Analysis

- Inventory value
- Products below reorder levels
- Stock shortages
- Inventory risk by warehouse
- Stock versus reorder levels

### Product Analysis

- Product sales
- Units sold
- Product profitability
- Top products by profit
- Sales versus profitability

---

## Power BI Dashboard

The final Power BI dashboard contains three analytical pages.

### 1. Executive Dashboard

Provides a high-level overview of business performance.

Key metrics and visuals include:

- Total Revenue
- Total Orders
- Average Order Value
- Completed Orders
- Monthly Revenue Trend
- Revenue by Warehouse
- Order Status Distribution
- Revenue by Order Status

### 2. Supply Chain & Delivery

Focuses on logistics and operational performance.

Key metrics and visuals include:

- Total Shipments
- Late Shipments
- Late Delivery Rate
- Average Delivery Days
- Carrier Late Delivery Performance
- Late Delivery Rate by Warehouse
- Supplier Reliability vs Lead Time
- Average Delivery Time by Carrier

### 3. Inventory & Product

Focuses on inventory risk and product profitability.

Key metrics and visuals include:

- Total Inventory Value
- Inventory Records Below Reorder Level
- Total Units in Stock
- Total Product Profit
- Inventory Risk by Warehouse
- Top 10 Products by Profit
- Stock vs Reorder Level
- Product Sales vs Profitability

---

## Key Business Insights

### Business Performance

- Total order value is approximately ₹1.44M across 100 orders.
- The average order value is approximately ₹14.35K.
- 79% of orders were completed.

### Delivery Performance

- 27 delivered shipments were identified as late.
- The late delivery rate among delivered shipments was approximately 38%.
- Bangalore had the highest warehouse-level late delivery rate.
- Carrier performance varied significantly across logistics providers.

### Supplier Performance

- Suppliers with longer lead times generally showed lower reliability scores in the dataset.
- Suppliers with shorter lead times and higher reliability represent stronger operational candidates.

### Inventory

- Total inventory value is approximately ₹8.97M.
- 36 warehouse-product inventory records were below their reorder levels.
- Several products showed significant gaps between current stock and reorder levels.

### Product Profitability

- Electric Motor 10HP was the highest-profit product in the analysis.
- Product sales and profitability showed a positive relationship, while some products stood out as particularly strong contributors.

---

## Business Recommendations

Based on the analysis:

1. Review high late-delivery-rate carriers and investigate their shipment volumes and operational constraints.
2. Prioritize delivery improvements at warehouses with consistently high late-delivery rates.
3. Review suppliers with high lead times and lower reliability scores.
4. Prioritize replenishment for products with significant stock shortages.
5. Monitor high-profit products closely to avoid stockouts.
6. Use product-level profitability alongside sales volume when making inventory and purchasing decisions.

---

## Project Structure

```text
supply-chain-inventory-analytics/
│
├── README.md
│
├── sql/
│   └── supply_chain_analytics.sql
│
├── powerbi/
│   └── Supply_Chain_Inventory_Analytics.pbix
│
└── screenshots/
    ├── executive_dashboard.png
    ├── supply_chain_delivery.png
    └── inventory_product.png
