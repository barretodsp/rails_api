# Rails

## Section
This short step-by-step shows how you can run this api locally.

Requirements: Ruby 2.5.1 | Ruby on Rails 5.2 | Rspec 3.9 | PostgreSQL 12.1

**Database**

Copy and past the following script into psql console to create role and databases for development, test and production envs.

```
CREATE ROLE storeapi WITH LOGIN PASSWORD 'sttk7878';
ALTER ROLE storeapi CREATEDB;
CREATE DATABASE store_development WITH ENCODING 'UTF8';
CREATE DATABASE store_test WITH ENCODING 'UTF8';
CREATE DATABASE store_prod WITH ENCODING 'UTF8';
```

**Setup & Run API**

Copy and past the following script into terminal (ubuntu) to setup and run api.


` ` ` 
$ bundle install  
$ rails db:migrate  
$ rails s  
` ` ` 


| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |


###
Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
