with daily_campaign_metrics as (

    select
        visit_date,
        utm_source,
        utm_medium,
        utm_campaign,
        count(num_pageviews) as num_pageviews,
        count(new_visits) as num_new_visits,
        avg(time_on_screen) as avg_time_on_screen
    from {{ ref ('sessions') }}
    group by 1, 2, 3, 4
    order by 1

)

select * from daily_campaign_metrics
