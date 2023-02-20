with all_sessions as (
    select * from {{ source('google_analytics_sample', 'ga_sessions_20170801' )}}
)

select * from all_sessions
