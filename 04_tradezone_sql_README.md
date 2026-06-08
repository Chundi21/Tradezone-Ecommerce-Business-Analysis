# TradeZone — E-Commerce SQL Business Analysis

SQL-driven business analysis on TradeZone's Nigerian e-commerce database, uncovering revenue patterns, regional payment behaviour, and operational gaps through 8 analytical queries and a formal executive memo.

---

## Overview

Raw data sitting in a database doesn't make decisions; analysis does. This project takes TradeZone's transaction and customer data and turns it into something a business can act on: a clear picture of where revenue is coming from, where it isn't, and why the gap between Lagos and Kano isn't just a volume problem.

The deliverable wasn't just queries. It was an executive memo written for a non-technical audience, translating every finding into a concrete recommendation.


## Tech Stack

- **Database:** PostgreSQL
- **Language:** SQL
- **Output:** Executive Business Memo


## The Analysis

### 8 Core Queries Covering

| Query | Business Question |
|-------|-------------------|
| Revenue by product category | Where is money actually being made? |
| Revenue trend over time | Is growth consistent or seasonal? |
| Top customers by lifetime value | Who are the high-value accounts? |
| Order volume by region | Where is demand concentrated? |
| Payment method breakdown by city | How do Lagos vs Kano customers pay? |
| Average order value by platform | Which channels attract higher-spend customers? |
| Delivery performance by region | Where is fulfilment breaking down? |
| Month-over-month growth rate | Is the business accelerating or slowing? |

---

## Key Findings

**Revenue Growth: ₦101M → ₦614M**  
Strong overall growth, but heavily concentrated in a small number of product categories. Diversification risk is real.

**The Lagos–Kano Payment Gap**  
Lagos customers predominantly used card and digital wallet payments. Kano showed significantly higher cash-on-delivery rates. This isn't just a preference difference — it's an operational cost difference. Cash-on-delivery has higher failed-delivery rates and return costs, which directly compresses margins on Kano orders. The data suggests the business was treating both markets identically when they require different fulfilment and payment strategies.

**Regional Delivery Performance**  
Delivery success rates correlated strongly with payment method — regions with high COD usage showed meaningfully worse delivery completion rates.

---

## Executive Memo Summary

The analysis was packaged into a formal memo structured for non-technical stakeholders:
- **Context** — what was analyzed and why
- **Findings** — plain-English explanation of each key result
- **Recommendations** — three specific operational actions with projected impact
- **Caveats** — data limitations and assumptions stated clearly

---

## Project Structure

```
tradezone-sql-analysis/
├── queries/
│   ├── 01_revenue_by_category.sql
│   ├── 02_revenue_trend.sql
│   ├── 03_top_customers.sql
│   ├── 04_order_volume_by_region.sql
│   ├── 05_payment_method_by_city.sql
│   ├── 06_aov_by_platform.sql
│   ├── 07_delivery_performance.sql
│   └── 08_mom_growth_rate.sql
├── memo/
│   └── tradezone_executive_memo.pdf
└── README.md
```
