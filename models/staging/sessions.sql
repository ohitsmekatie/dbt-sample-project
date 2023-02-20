with all_sessions as (

    select

        visitnumber as visit_number,
        visitId as visit_id,
        -- all dates in this dataset were strings so casting into a format that's more reasonable
        parse_date('%Y%m%d', date) as visit_date,
        totals.visits as num_visits,
        totals.hits as num_hits,
        totals.pageviews as num_pageviews,
        totals.timeOnScreen as time_on_screen,
        totals.bounces as num_bounces,
        totals.transactions as num_transactions,
        totals.transactionRevenue as transaction_revenue,
        totals.newvisits as new_visits,
        totals.screenviews as num_screenviews,
        totals.uniqueScreenviews as num_unique_screenviews,
        totals.totalTransactionRevenue as total_transaction_revenue,
        totals.sessionQualityDim as session_quality_dim,
        trafficSource.referralPath as referral_path,
        -- dropping the parans that are included in these fields at the beginning and end 
        ltrim(rtrim(trafficSource.campaign, ')'), '(') as utm_campaign,
        ltrim(rtrim(trafficSource.source, ')'), '(') utm_source,
        ltrim(rtrim(trafficSource.medium, ')'), '(') as utm_medium,
        trafficsource.keyword as keyword,
        trafficSource.adContent as ad_content,
        trafficSource.adwordsClickInfo.campaignid as campaign_id,
        trafficSource.adwordsClickInfo.adGroupId as ad_group_id,
        trafficSource.adwordsClickInfo.creativeId as creative_id,
        trafficSource.adwordsClickInfo.page as page,
        trafficSource.adwordsClickInfo.slot as slot,
        trafficSource.adwordsClickInfo.customerId as customer_id,
        trafficSource.adwordsClickInfo.isVideoAd as is_video_ad,
        device.browser as browser,
        device.operatingSystem as operating_system,
        device.isMobile as is_mobile,
        device.deviceCategory as device_category,
        geonetwork.continent as continent,
        geonetwork.subContinent as sub_continent,
        -- accessing the array values as singular fields
        hits[safe_offset(0)].hitNumber as hit_number,
        hits[safe_offset(0)].time as hit_time,
        hits[safe_offset(0)].hour as hit_hour,
        hits[safe_offset(0)].minute as hit_minute,
        concat(hits[safe_offset(0)].hour, ':',  hits[safe_offset(0)].minute) as time,
        hits[safe_offset(0)].issecure as is_secure,
        hits[safe_offset(0)].isentrance as is_entrance,
        hits[safe_offset(0)].isexit as is_exit,
        hits[SAFE_OFFSET(0)].referer as referer,
        replace(hits[SAFE_OFFSET(0)].page.pagePath, '+', '-') as page_path,
        hits[SAFE_OFFSET(0)].page.hostname as host_name,
        hits[SAFE_OFFSET(0)].page.searchkeyword as search_keyword,
        hits[SAFE_OFFSET(0)].page.searchCategory as search_category,
        replace(hits[SAFE_OFFSET(0)].page.pagePathLevel1, '+', '-') as page_path_level_1,
        replace(hits[SAFE_OFFSET(0)].page.pagePathLevel2, '+', '-') as page_path_level_2,
        replace(hits[SAFE_OFFSET(0)].page.pagePathLevel3, '+', '-') as page_path_level_3,
        replace(hits[SAFE_OFFSET(0)].page.pagePathLevel4, '+', '-') as page_path_level_4,
        fullVisitorId	as full_visitor_id,
        userid as user_id,
        clientid as client_id,
        channelgrouping as channel_grouping,
        socialengagementtype as social_engagement_type,
        hits[SAFE_OFFSET(0)].customMetrics[SAFE_OFFSET(0)].index as custom_metrics_index,
        hits[SAFE_OFFSET(0)].customMetrics[SAFE_OFFSET(0)].value as custom_metrics_value

    from {{ source('google_analytics_sample', 'ga_sessions_20170801' )}}

)

select * from all_sessions
