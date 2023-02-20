## dbt sample project

:wave: The following is a sample project to showcase setting up dbt - using dbt core - and BigQuery. The aim of this project is to showcase familiarity with dbt, data modeling, and custom configurations using publicly available data from BigQuery.

### Project setup

1. Install dbt Core & BigQuery adapter using Homebrew & pip. I have experience with the dbt IDE / cloud product as well but for personal or non-work projects i'd prefer to use dbt Core
2. Create a new BigQuery project (`dbt-test-375016`)
3. Create new dbt service account & coresponding json key so that dbt can read from and write to my new BigQuery test data warehouse. For this case I just gave the service account `BigQuery Editor` permissions, but in a work scenario we would have a much more granular permissions set up
4. Create a `profile.yml` file in the `.dbt` folder and add configurations for data warehouse
5. :tada: run `dbt debug` to make sure connection worked (it did :D)

### Setting up project scaffolding

1. Create `staging` folder & `marts` folder for basic project setup. Staging will be my transformed source data and marts will be my "final product" models
2. Use custom macro to drop the default behavior in dbt that prefaces your user name (dbt_ksipos in this case) to your dataset (`generate_schema_name`)
3. Update `dbt_project.yml` so that my staging models all send to a schema called `staging` and my production marts all send to a schema called `production`. Everthing will send to my default database (project in BQ language) which is called `analytics`
4. Create source yaml file (`src_staging`) to reference raw data in staging models and a models yaml file (`models_staging`) so that I can add documentation & tests, if needed
5. Create the same `models` file but in `marts` so I can document and test things at the mart level, if needed
6. added a `packages.yml` file so that I could install the `dbt utils` package which has[a lot of handy pre-built macros](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/) that can be reasily referenced & reused

### Adding sources & cleaning up the data

1. For each public dataset transformed in this project i've added the sources in the source yaml file
2. In the staging models i've done basic transformations, casting, and renaming. See specific files for documentation

### Public data transformed in this project

1. [Google Analytics sample dataset](https://support.google.com/analytics/answer/7586738#zippy=%2Cin-this-article). This dataset
> The sample dataset contains obfuscated Google Analytics 360 data from the Google Merchandise Store, a real ecommerce store. The Google Merchandise Store sells Google branded merchandise. The data is typical of what you would see for an ecommerce website. It includes the following kinds of information:

> Traffic source data: information about where website visitors originate. This includes data about organic traffic, paid search traffic, display traffic, etc.

> Content data: information about the behavior of users on the site. This includes the URLs of pages that visitors look at, how they interact with content, etc.

> Transactional data: information about the transactions that occur on the Google Merchandise Store website
