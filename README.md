# dbt sample project

## Overview

:wave: The following is a sample project to showcase setting up dbt - using dbt Core not Cloud - and BigQuery. The aim of this project is to showcase familiarity with dbt, data modeling, and custom configurations using publicly available data from BigQuery and not necessarily SQL complexity.

## Project setup

1. Install dbt Core & BigQuery adapter using Homebrew & pip. I have experience with the dbt IDE / cloud product as well but for personal or non-work projects i'd prefer to use dbt Core
2. Create a new BigQuery project (`dbt-test-375016`)
3. Create new dbt service account & coresponding json key so that dbt can read from and write to my new BigQuery test data warehouse. For this case I just gave the service account `BigQuery Editor` permissions, but in a work scenario we would have a much more granular permissions set up
4. Create a `profile.yml` file in the `.dbt` folder and add configurations for data warehouse
5. :tada: run `dbt debug` to make sure connection worked (it did :D)

## Setting up project scaffolding

1. Create `staging` folder & `marts` folder for basic project setup. Staging will be my transformed source data and marts will be my "final product" models
2. Use custom macro to drop the default behavior in dbt that prefaces your user name (dbt_ksipos in this case) to your dataset (`generate_schema_name`)
3. Update `dbt_project.yml` so that my staging models all send to a schema called `staging` and my production marts all send to a schema called `production`. Everthing will send to my default database (project in BQ language) which is called `analytics`
4. Create source yaml file (`src_staging`) to reference raw data in staging models and a models yaml file (`models_staging`) so that I can add documentation & tests, if needed
5. Create the same `models` file but in `marts` so I can document and test things at the mart level, if needed
6. added a `packages.yml` file so that I could install the `dbt utils` package which has[a lot of handy pre-built macros](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/) that can be reasily referenced & reused

## Adding sources & cleaning up the data

1. For each public dataset transformed in this project i've added the sources in the source yaml file
2. In the staging models i've done basic transformations, casting, and renaming. See specific files for documentation

## Public data transformed in this project

### [Google Analytics sample dataset](https://support.google.com/analytics/answer/7586738#zippy=%2Cin-this-article). This dataset
> The sample dataset contains obfuscated Google Analytics 360 data from the Google Merchandise Store, a real ecommerce store. The Google Merchandise Store sells Google branded merchandise. The data is typical of what you would see for an ecommerce website. It includes the following kinds of information:

> Traffic source data: information about where website visitors originate. This includes data about organic traffic, paid search traffic, display traffic, etc.

> Content data: information about the behavior of users on the site. This includes the URLs of pages that visitors look at, how they interact with content, etc.

> Transactional data: information about the transactions that occur on the Google Merchandise Store website

**Expand below to see the full raw (as it came from the source) dataset**

<details>

```
[{
  "visitorId": null,
  "visitNumber": "1",
  "visitId": "1501591568",
  "visitStartTime": "1501591568",
  "date": "20170801",
  "totals": {
    "visits": "1",
    "hits": "1",
    "pageviews": "1",
    "timeOnSite": null,
    "bounces": "1",
    "transactions": null,
    "transactionRevenue": null,
    "newVisits": "1",
    "screenviews": null,
    "uniqueScreenviews": null,
    "timeOnScreen": null,
    "totalTransactionRevenue": null,
    "sessionQualityDim": "1"
  },
  "trafficSource": {
    "referralPath": null,
    "campaign": "(not set)",
    "source": "(direct)",
    "medium": "(none)",
    "keyword": null,
    "adContent": null,
    "adwordsClickInfo": {
      "campaignId": null,
      "adGroupId": null,
      "creativeId": null,
      "criteriaId": null,
      "page": null,
      "slot": null,
      "criteriaParameters": "not available in demo dataset",
      "gclId": null,
      "customerId": null,
      "adNetworkType": null,
      "targetingCriteria": null,
      "isVideoAd": null
    },
    "isTrueDirect": null,
    "campaignCode": null
  },
  "device": {
    "browser": "Chrome",
    "browserVersion": "not available in demo dataset",
    "browserSize": "not available in demo dataset",
    "operatingSystem": "Windows",
    "operatingSystemVersion": "not available in demo dataset",
    "isMobile": "false",
    "mobileDeviceBranding": "not available in demo dataset",
    "mobileDeviceModel": "not available in demo dataset",
    "mobileInputSelector": "not available in demo dataset",
    "mobileDeviceInfo": "not available in demo dataset",
    "mobileDeviceMarketingName": "not available in demo dataset",
    "flashVersion": "not available in demo dataset",
    "javaEnabled": null,
    "language": "not available in demo dataset",
    "screenColors": "not available in demo dataset",
    "screenResolution": "not available in demo dataset",
    "deviceCategory": "desktop"
  },
  "geoNetwork": {
    "continent": "Europe",
    "subContinent": "Southern Europe",
    "country": "Greece",
    "region": "not available in demo dataset",
    "metro": "not available in demo dataset",
    "city": "not available in demo dataset",
    "cityId": "not available in demo dataset",
    "networkDomain": "tellas.gr",
    "latitude": "not available in demo dataset",
    "longitude": "not available in demo dataset",
    "networkLocation": "not available in demo dataset"
  },
  "customDimensions": [],
  "hits": [{
    "hitNumber": "1",
    "time": "0",
    "hour": "5",
    "minute": "46",
    "isSecure": null,
    "isInteraction": "true",
    "isEntrance": "true",
    "isExit": "true",
    "referer": "https://www.google.gr/",
    "page": {
      "pagePath": "/google+redesign/bags/google+zipper+front+sports+bag.axd",
      "hostname": "shop.googlemerchandisestore.com",
      "pageTitle": "Page Unavailable",
      "searchKeyword": null,
      "searchCategory": null,
      "pagePathLevel1": "/google+redesign/",
      "pagePathLevel2": "/bags/",
      "pagePathLevel3": "/google+zipper+front+sports+bag.axd",
      "pagePathLevel4": ""
    },
    "transaction": null,
    "item": null,
    "contentInfo": null,
    "appInfo": {
      "name": null,
      "version": null,
      "id": null,
      "installerId": null,
      "appInstallerId": null,
      "appName": null,
      "appVersion": null,
      "appId": null,
      "screenName": "shop.googlemerchandisestore.com/google+redesign/bags/google+zipper+front+sports+bag.axd",
      "landingScreenName": "shop.googlemerchandisestore.com/google+redesign/bags/google+zipper+front+sports+bag.axd",
      "exitScreenName": "shop.googlemerchandisestore.com/google+redesign/bags/google+zipper+front+sports+bag.axd",
      "screenDepth": "0"
    },
    "exceptionInfo": {
      "description": null,
      "isFatal": "true",
      "exceptions": null,
      "fatalExceptions": null
    },
    "eventInfo": null,
    "product": [],
    "promotion": [],
    "promotionActionInfo": null,
    "refund": null,
    "eCommerceAction": {
      "action_type": "0",
      "step": "1",
      "option": null
    },
    "experiment": [],
    "publisher": null,
    "customVariables": [],
    "customDimensions": [],
    "customMetrics": [],
    "type": "PAGE",
    "social": {
      "socialInteractionNetwork": null,
      "socialInteractionAction": null,
      "socialInteractions": null,
      "socialInteractionTarget": null,
      "socialNetwork": "(not set)",
      "uniqueSocialInteractions": null,
      "hasSocialSourceReferral": "No",
      "socialInteractionNetworkAction": " : "
    },
    "latencyTracking": null,
    "sourcePropertyInfo": null,
    "contentGroup": {
      "contentGroup1": "(not set)",
      "contentGroup2": "Bags",
      "contentGroup3": "(not set)",
      "contentGroup4": "(not set)",
      "contentGroup5": "(not set)",
      "previousContentGroup1": "(entrance)",
      "previousContentGroup2": "(entrance)",
      "previousContentGroup3": "(entrance)",
      "previousContentGroup4": "(entrance)",
      "previousContentGroup5": "(entrance)",
      "contentGroupUniqueViews1": null,
      "contentGroupUniqueViews2": "1",
      "contentGroupUniqueViews3": null,
      "contentGroupUniqueViews4": null,
      "contentGroupUniqueViews5": null
    },
    "dataSource": "web",
    "publisher_infos": []
  }],
  "fullVisitorId": "3418334011779872055",
  "userId": null,
  "clientId": null,
  "channelGrouping": "Organic Search",
  "socialEngagementType": "Not Socially Engaged"
}]

```
</details>

:point_right: In the google analytics dataset the cleaning for the `all_sessions` model involved casting strings to dates, accessing singular fields within multi-nested arrays, replacing characters in URLs, trimming characters on fields as well as just renaming many of the fields to follow a consistent naming and formatting structure.

**Expand below to see the schema for the cleaned up version of the above raw dataset.**

<details>

```

[{
  "visit_number": "1",
  "visit_id": "1501591568",
  "visit_date": "2017-08-01",
  "num_visits": "1",
  "num_hits": "1",
  "num_pageviews": "1",
  "time_on_screen": null,
  "num_bounces": "1",
  "num_transactions": null,
  "transaction_revenue": null,
  "new_visits": "1",
  "num_screenviews": null,
  "num_unique_screenviews": null,
  "total_transaction_revenue": null,
  "session_quality_dim": "1",
  "referral_path": null,
  "utm_campaign": "not set",
  "utm_source": "direct",
  "utm_medium": "none",
  "keyword": null,
  "ad_content": null,
  "campaign_id": null,
  "ad_group_id": null,
  "creative_id": null,
  "page": null,
  "slot": null,
  "customer_id": null,
  "is_video_ad": null,
  "browser": "Chrome",
  "operating_system": "Windows",
  "is_mobile": "false",
  "device_category": "desktop",
  "continent": "Europe",
  "sub_continent": "Southern Europe",
  "hit_number": "1",
  "hit_time": "0",
  "hit_hour": "5",
  "hit_minute": "46",
  "time": "5:46",
  "is_secure": null,
  "is_entrance": "true",
  "is_exit": "true",
  "referer": "https://www.google.gr/",
  "page_path": "/google-redesign/bags/google-zipper-front-sports-bag.axd",
  "host_name": "shop.googlemerchandisestore.com",
  "search_keyword": null,
  "search_category": null,
  "page_path_level_1": "/google-redesign/",
  "page_path_level_2": "/bags/",
  "page_path_level_3": "/google-zipper-front-sports-bag.axd",
  "page_path_level_4": "",
  "full_visitor_id": "3418334011779872055",
  "user_id": null,
  "client_id": null,
  "channel_grouping": "Organic Search",
  "social_engagement_type": "Not Socially Engaged",
  "custom_metrics_index": null,
  "custom_metrics_value": null
}]

```

</details>

## Production data

### Google Analytics

1. `daily_site_metrics`: a rollup of core daily metrics like number of pageviews, number of new visitors, number of bounces, etc. [model](https://github.com/ohitsmekatie/dbt-sample-project/blob/main/models/marts/daily_site_metrics.sql)

> **Note**
> the public dataset actually only spans one day so it's not super compelling to query in this form, but this could produce a nice rollup for a Marketing team to be able to self-serve key metrics by day

2. `daily_campaign_metrics`: a rollup of campaign metrics from site visitors like number of visitors by source and medium. [model](https://github.com/ohitsmekatie/dbt-sample-project/blob/main/models/marts/daily_campaign_metrics.sql)

> **Note**
> again, public dataset actually only spans one day. :) this type of rollup is something i've actually done in my day to day for our demand gen team. In a work scenario we also layer in ad metrics, and sales pipeline metrics to be able to get the whole view of how a campaign has done

3. `daily_top_paths`: a rollup to show the top 5 common paths per day that visitors take across the ecommerce site.

> **Note**
> again, again public dataset actually only spans one day. :) if i had other data to ennrich this, like sign up events, i would probably calculate something more like the top 5 paths that ended in a completed sign up

<img width="287" alt="Screen Shot 2023-02-20 at 8 43 06 PM" src="https://user-images.githubusercontent.com/9855295/220226396-709f6af3-5530-4a20-9c4a-2a4e18e3cdb2.png">
