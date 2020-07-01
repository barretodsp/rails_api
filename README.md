# Rails

## Project Setup
This step-by-step shows how you can run this api locally.

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

**Run test**

There are 102 test cases. All is green!

``` 
$ bundle exec rspec 
``` 


## Endpoints

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
| POST  | /stock_item/add  | { "product_id": integer, "store_id": integer, "qty": integer } | Create a stock item |
| POST  | /stock_item/get_by_id  | { "id": integer } | Get a single stock item |
| POST  | /stock_item/add_qty  | { "id": integer, "qty": integer } | Increment quantity qty units |
| POST  | /stock_item/delete_qty  | { "id": integer, "qty": integer } | Decrement quantity in qty units |
| POST  | /stock_item/delete  | { "id": integer } | Delete a stock item |


## Usage Examples

**Create a Product**

```
curl -X POST -H 'Content-type: application/json' -d '{"price": 2.99, "name": "Product AAA"}' localhost:3000/product/add
```

**Get a Product**

```
curl -X POST -H 'Content-type: application/json' -d '{"id": 1}' localhost:3000/product/get_by_id
```

**Increase Quantity of StockItem**

```
curl -X POST -H 'Content-type: application/json' -d '{"id": 1, "qty": 5}' localhost:3000/stock_item/add_qty
```

**For Heroku calls, change 'localhost:3000' to 'https://rails-api-loja.herokuapp.com'.**
