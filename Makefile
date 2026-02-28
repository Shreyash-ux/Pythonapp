IMAGE=student-api
VERSION=1.0.0

start-db:
	docker-compose up -d db

migrate:
	docker-compose run --rm api flask db upgrade

build-api:
	docker build -t $(IMAGE):$(VERSION) .

run-api: start-db migrate
	docker-compose up -d api