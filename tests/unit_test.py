from app import db
from app.models import Student


def test_healthcheck(client):
    res = client.get("/api/v1/healthcheck")
    assert res.status_code == 200
    assert res.get_json()["status"] == "ok"


def test_add_student(client):
    res = client.post("/api/v1/students", json={
        "name": "John",
        "age": 22,
        "email": "john@test.com"
    })

    assert res.status_code == 201


def test_get_students_empty(client):
    res = client.get("/api/v1/students")
    assert res.status_code == 200
    assert res.get_json() == []


def test_get_single_student(client, app):
    with app.app_context():
        student = Student(name="Sam", age=20, email="sam@test.com")
        db.session.add(student)
        db.session.commit()

    res = client.get("/api/v1/students/1")
    assert res.status_code == 200