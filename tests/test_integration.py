def test_student_crud_flow(client):

    # CREATE
    res = client.post("/api/v1/students", json={
        "name": "Alice",
        "age": 21,
        "email": "alice@test.com"
    })
    assert res.status_code == 201

    # READ ALL
    res = client.get("/api/v1/students")
    data = res.get_json()
    assert len(data) == 1
    student_id = data[0]["id"]

    # UPDATE
    res = client.put(f"/api/v1/students/{student_id}", json={
        "name": "Alice Updated"
    })
    assert res.status_code == 200

    # READ SINGLE
    res = client.get(f"/api/v1/students/{student_id}")
    assert res.get_json()["name"] == "Alice Updated"

    # DELETE
    res = client.delete(f"/api/v1/students/{student_id}")
    assert res.status_code == 200

    # VERIFY DELETE
    res = client.get("/api/v1/students")
    assert res.get_json() == []
