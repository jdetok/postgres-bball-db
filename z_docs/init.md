# notes for creating container/database
- all the files in /sql are copied to `docker-entrypoint-initdb.d` & executed
`docker compose up` is run
## 0-init dir
- creates schemas
    - database with name from POSTGRES_DB .env var is created by default on build
## 1-tbl dir
- create tables
## 2-prc dir
- create procedures or functions