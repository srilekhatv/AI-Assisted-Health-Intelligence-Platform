{{ config(materialized='table') }}

with date_spine as (

    select
        dateadd(
            day,
            seq4(),
            to_date('2000-01-01')
        ) as full_date
    from table(generator(rowcount => 11323))

),

filtered_dates as (

    select *
    from date_spine
    where full_date <= to_date('2030-12-31')

)

select
    to_number(to_char(full_date, 'YYYYMMDD')) as date_key,
    full_date,

    day(full_date)              as day,
    month(full_date)            as month,
    monthname(full_date)        as month_name,
    year(full_date)             as year,
    quarter(full_date)          as quarter,

    to_char(full_date, 'YYYY-MM') as year_month,

    dayname(full_date)          as day_of_week,
    dayofweekiso(full_date)     as day_of_week_num,

    case 
        when dayofweekiso(full_date) in (6, 7) then true
        else false
    end as is_weekend,

    case 
        when full_date = last_day(full_date, 'month') then true
        else false
    end as is_month_end,

    case 
        when day(full_date) = 1 then true
        else false
    end as is_month_start,

    false as is_holiday

from filtered_dates
order by full_date
