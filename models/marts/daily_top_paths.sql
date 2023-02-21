with path_counts as (

    select
        visit_date,
        page_path_level_1,
        page_path_level_2,
        page_path_level_3,
        count(*) as num_visitors
    from {{ ref('sessions') }}
    -- a dbt macro for easily grouping by the number of fields
    {{ dbt_utils.group_by(n=4) }}
    order by visit_date, num_visitors desc

),

daily_top_5_paths as (

    select
        visit_date,
        page_path_level_1,
        page_path_level_2,
        page_path_level_3,
        num_visitors,
        rank() over(order by num_visitors desc) as rank
    from path_counts
    qualify rank <= 5
    order by rank
)

select * from daily_top_5_paths
