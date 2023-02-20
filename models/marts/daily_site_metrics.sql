with daily_metrics as (

  select
      visit_date,
      count(num_pageviews) as num_pageviews,
      count(num_hits) as num_total_visits,
      count(new_visits) as num_new_visits,
      count(num_bounces) as num_bounces,
      count(num_transactions) as num_transactions,
      avg(time_on_screen) as avg_time_on_screen
  from {{ ref('sessions') }}
  group by visit_date
  order by visit_date

)

select * from daily_metrics
