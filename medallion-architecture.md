# Medallion Architecture

## What Is It?
Organises a data pipeline into three layers. Data only moves to the next
layer when it meets that layer's quality requirements.

---

## The Three Layers

### 🥉 Bronze — Raw Zone
- Data lands exactly as it arrived from the source
- Nothing modified, deleted, or transformed
- Complete audit trail of everything received

### 🥈 Silver — Cleaned Zone
- Data validated, cleaned, quality rules applied
- Nulls handled, types cast, formats standardised
- Duplicates removed, bad records routed to errors

### 🥇 Gold — Analytics Zone
- Only clean validated data reaches here
- Modelled using Kimball star schema
- Business metrics and aggregate queries served here

---

## Simple Analogy
> A warehouse receiving stock:
> - **Bronze** = loading dock — everything arrives here first
> - **Silver** = sorting area — damaged goods separated
> - **Gold** = shop floor — only sellable stock reaches here

---

## Applied Pipeline

```
File uploaded to S3
        ↓
  [BRONZE LAYER]
  Validate file format
  Store raw — no changes
        ↓
  [SILVER LAYER]
  Apply DQ rules
  Clean and standardise
  Handle nulls
        ↓
  [GOLD LAYER]
  Star schema
  Analytics queries
```

---

## Key Principle
> Nothing is ever deleted from Bronze.
> It is the permanent record of what arrived.
