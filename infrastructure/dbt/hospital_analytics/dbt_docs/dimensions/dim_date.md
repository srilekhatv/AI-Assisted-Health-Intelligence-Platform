# Date Dimension (dim_date)

## Purpose
Provides a standardized calendar dimension to support time-based analysis
across all analytics fact tables (claims, coverage, utilization).

Centralizes all date logic to avoid repeated date transformations in fact models.

## Grain
One row per calendar date.

## Date Range
Covers dates from **2000-01-01** through **2030-12-31**, sufficient for CMS
DE-SynPUF historical analysis and future extensions.

## Keys
- **date_key**: Surrogate primary key in `YYYYMMDD` numeric format
- **full_date**: Native DATE value representing the calendar date

## Core Calendar Attributes
- day
- month
- month_name
- year
- quarter
- year_month (formatted as `YYYY-MM`)

## Day-of-Week Attributes
- day_of_week (Monday–Sunday)
- day_of_week_num (ISO standard: 1 = Monday, 7 = Sunday)

## Calendar Flags
- is_weekend
- is_month_start
- is_month_end
- is_holiday (currently defaulted to false; placeholder for future enrichment)

## Design Decisions
- Uses a numeric surrogate key (`YYYYMMDD`) for efficient joins
- ISO weekday numbering used for consistency across analytics
- Boolean flags included to simplify downstream KPI logic
- Date logic centralized to ensure consistent time-based analysis

## Usage
- Joined to fact tables using `date_key`
- Used for trend analysis, seasonality, period comparisons, and calendar-based KPIs
