# Olist E-Commerce Customer and Delivery Analysis

## Project Overview

This project analyzes customer purchasing behavior and delivery performance in Olist's e-commerce data.

The analysis is designed for an E-commerce Operations and Customer Experience team. It focuses on two business questions:

1. How much do repeat customers contribute to sales?
2. Are late deliveries associated with lower customer review scores?

## Tools

- BigQuery
- SQL

## Data Scope

The analysis uses Olist e-commerce data provided through a bootcamp BigQuery dataset.

- Only delivered orders are included in the main analyses.
- Item sales refer to the `price` field in the order items data and exclude freight charges.
- Delivery analysis includes only orders with both actual and estimated delivery dates.

## Key Findings

### 1. Repeat customers represented a small share of customers but contributed disproportionately to sales

- Total customers: 93,358
- Repeat customers: 2,801 (3.00%)
- Repeat customer item sales: R$728,408.75
- Repeat customer share of item sales: 5.51%

Repeat customers accounted for only 3.00% of customers but generated 5.51% of delivered item sales. Their higher observed customer value was driven by additional purchases rather than a higher average order value.

### 2. 8.11% of eligible delivered orders arrived late

- On-time orders: 88,644 (91.89%)
- Late orders: 7,826 (8.11%)

An order was classified as late when its actual delivery date was after its estimated delivery date.

### 3. Late deliveries were associated with substantially lower review scores

| Delivery status | Reviewed orders | Average review score |
| --- | ---: | ---: |
| On time | 88,163 | 4.29 |
| Late | 7,661 | 2.57 |

Late deliveries received an average review score that was 1.72 points lower than on-time deliveries on a five-point scale.

## Recommendations

1. Prioritize actions that reduce late deliveries, as delivery delays are strongly associated with lower customer satisfaction.
2. Investigate late orders by seller, product category, and customer region to identify operational causes.
3. Test retention initiatives for customers after their first purchase, since repeat customers generated a disproportionate share of item sales.

## Project Structure

```text
.
├── README.md
└── sql/
    ├── 01_data_quality_checks.sql
    ├── 02_customer_retention.sql
    └── 03_delivery_and_satisfaction.sql
```

## Limitations

- The repeat-customer rate reflects purchases observed within the dataset period; it is not a lifetime retention rate.
- The delivery analysis identifies an association between late delivery and lower review scores. It does not establish causation.
- Some delivered orders were excluded from delivery analysis because required delivery dates were missing.