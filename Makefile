.PHONY: all bash prepare build clean down logs restart start status stop tail

SERVER_SERVICE_NAME = server

all: build start

bash:
	@docker-compose run --rm $(SERVER_SERVICE_NAME) bash

prepare:
	@docker-compose run --rm $(SERVER_SERVICE_NAME) cp ht.access .htaccess
	@docker-compose run --rm $(SERVER_SERVICE_NAME) cp _build/build.config.sample.php _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/host=localhost/host=db/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/dbname=revo_test/dbname=revolution/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/_USER', ''/_USER', 'revolution'/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/_PASS', ''/_PASS', 'revolution'/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) cp _build/build.properties.sample.php _build/build.properties.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/_test']= 'mysql:host=localhost;dbname=revo_test;charset=utf8';/_test']= 'mysql:host=db;dbname=revolution;charset=utf8';/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/_username']= ''/_username']= 'revolution'/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) sed -i "s/_password']= ''/_password']= 'revolution'/g" _build/build.config.php
	@docker-compose run --rm $(SERVER_SERVICE_NAME) php _build/transport.core.php

build:
	@docker-compose build

clean: stop
	@docker-compose rm --force

down:
	@docker-compose down

logs:
	@docker-compose logs -f

restart: stop start

start:
	@docker-compose up -d

status:
	@docker-compose ps

stop:
	@docker-compose stop

tail:
	@docker-compose logs $(SERVER_SERVICE_NAME)
