from flask import Blueprint, request, jsonify
from app import db
from app.models import Student

api = Blueprint("api", __name__)

@api.route("/healthcheck")
def health():
    return {"status": "ok"}, 200


@api.route("/students", methods=["POST"])
def add_student():
    data = request.json
    student = Student(**data)
    db.session.add(student)
    db.session.commit()
    return jsonify({"message": "Student added"}), 201


@api.route("/students", methods=["GET"])
def get_students():
    students = Student.query.all()
    return jsonify([
        {"id": s.id, "name": s.name, "age": s.age, "email": s.email}
        for s in students
    ])


@api.route("/students/<int:id>", methods=["GET"])
def get_student(id):
    s = Student.query.get_or_404(id)
    return jsonify({
        "id": s.id,
        "name": s.name,
        "age": s.age,
        "email": s.email
    })


@api.route("/students/<int:id>", methods=["PUT"])
def update_student(id):
    s = Student.query.get_or_404(id)
    data = request.json
    s.name = data.get("name", s.name)
    s.age = data.get("age", s.age)
    s.email = data.get("email", s.email)
    db.session.commit()
    return {"message": "updated"}, 200


@api.route("/students/<int:id>", methods=["DELETE"])
def delete_student(id):
    s = Student.query.get_or_404(id)
    db.session.delete(s)
    db.session.commit()
    return {"message": "deleted"}, 200