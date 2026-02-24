run:
	python run.py

migrate:
	flask db migrate

upgrade:
	flask db upgrade

test:
	pytest