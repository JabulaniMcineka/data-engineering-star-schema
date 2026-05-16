# Data Engineering Fundamentals — Personal Learning Portfolio

A documented journey through core data engineering concepts, hands-on projects,
and applied learning. Built to deepen foundational knowledge and prepare for
enterprise-scale data engineering work.

---

## 📚 Study Progress

| Resource | Status | Progress |
|---|---|---|
| Fundamentals of Data Engineering — Joe Reis & Matt Housley | 🔄 In Progress | Chapter 8 Complete |
| 100 Days of Code — Python | 🔄 In Progress | Day 22 |
| AWS Certified Cloud Practitioner | ✅ Complete | Certified |
| AWS Certified Data Engineer Associate | ✅ Complete | Certified |
| Weekend Data Engineering Workshops | 🔄 Ongoing | Weekly |

---

## 📂 Repository Structure

```
data-engineering-fundamentals/
├── README.md
├── chapter-notes/
│   └── chapter-08-queries-modeling-transformation.md
├── projects/
│   └── star-schema-retail/
│       ├── README.md
│       ├── sql/
│       │   ├── 01_schema.sql
│       │   ├── 02_dimensions.sql
│       │   ├── 03_facts.sql
│       │   └── 04_analytics.sql
│       └── data/
│           ├── products.csv
│           └── sales.csv
└── concepts/
    ├── medallion-architecture.md
    ├── slowly-changing-dimensions.md
    └── dimensional-modelling.md
```

---

## 🚀 Projects

### Star Schema — Retail Pipeline
A complete dimensional model built from scratch applying Kimball methodology.
Includes fact table, dimension tables, SCD Type 2 implementation, and analytics queries.

### AWS Medallion Pipeline
Event-driven data ingestion pipeline using AWS Lambda, S3, and Python.
Applies Bronze → Silver → Gold architecture with data quality gates.

---

## 📖 Chapter Notes

- [Chapter 8 — Queries, Modeling and Transformation](chapter-notes/chapter-08-queries-modeling-transformation.md)

---

## 🎯 Learning Goals

- [ ] Complete Fundamentals of Data Engineering textbook
- [ ] Complete 100 Days of Python
- [ ] Build a dbt project applying ELT transformation patterns
- [ ] Implement SCD Type 2 on a real dataset
- [ ] Gain Agile project exposure
- [ ] Study Apache Flink for streaming transformations
