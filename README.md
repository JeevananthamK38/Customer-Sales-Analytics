# Customer & Sales Performance Analytics – SQL Project

## Project Overview
This project focuses on analyzing customer purchasing behavior and revenue performance
using SQL. The goal is to derive meaningful business insights related to customer value,
sales trends, and revenue contribution.

## Business Context
The company wants to understand:
- How customers contribute to overall revenue
- Which customers are high, medium, or low value
- Customer inactivity patterns
- Top-performing customers based on total spending

## Database Schema
The analysis is based on the following tables:
- `customers` – customer details and signup information
- `orders` – customer order transactions with order dates and amounts

## Key Analysis Performed
- Total spending by each customer
- Customers with multiple orders and customers with no orders
- Customer segmentation using CASE WHEN (Low / Medium / High value)
- Monthly revenue analysis
- Ranking customers based on total spending
- Identifying inactive customers (no orders in 2022)
- Calculating contribution percentage of each customer to total revenue

## SQL Concepts Used
- INNER JOIN and LEFT JOIN
- Aggregate functions (SUM, COUNT, AVG)
- GROUP BY and HAVING
- CASE WHEN business logic
- Subqueries and derived tables
- Window functions (RANK, SUM() OVER)
- Date-based filtering

## Files in This Repository
- `customer_sales_analysis.sql` – Contains table creation, data insertion, and all analysis queries.

## Purpose
This project demonstrates my ability to use SQL for real-world data analysis,
translate business requirements into queries, and extract actionable insights.
