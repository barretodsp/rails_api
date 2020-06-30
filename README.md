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

Run the following commands into terminal (inside api folder) to setup and run api.


``` 
$ bundle install
$ rails db:migrate
$ rails s  
``` 


| HTTP verbs  | Paths | JSON content | Used for
| ------------- | ------------- | ------------- | ------------- |
| POST  | /product/add  | { "name": string, "price": float } | Create a product |
| POST  | /product/get_by_id  | { "id": integer } | Get a single product |
| POST  | /product/update  | { "id": integer, "name": string, "price": float } | Update a product |
| POST  | /product/delete  | { "id": integer } | Delete a product |
| POST  | /store/add  | { "name": string, "address": string } | Create a store |
| POST  | /store/get_by_id  | { "id": integer } | Get a single store |
| POST  | /store/update  | { "id": integer, "name": string, "address": string } | Update a store |
| POST  | /store/delete  | { "id": integer } | Delete a store |


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
