# Student CRUD REST API

## Setup
pip install -r requirements.txt

## Environment variables
DATABASE_URL=sqlite:///students.db

## Run
make run

## DB Migration
make migrate
make upgrade

## API Endpoints
POST /api/v1/students
GET /api/v1/students
GET /api/v1/students/{id}
PUT /api/v1/students/{id}
DELETE /api/v1/students/{id}