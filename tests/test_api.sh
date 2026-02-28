#!/bin/bash

BASE_URL="http://13.233.173.148:5000/api/v1"

print_call () {
  echo "--------------------------------------------"
  echo "METHOD : $1"
  echo "URL    : $2"
  echo "--------------------------------------------"
}

echo "🚀 Starting API Tests"
echo ""

# 1️⃣ Healthcheck
print_call "GET" "$BASE_URL/healthcheck"
curl -s -X GET $BASE_URL/healthcheck
echo -e "\n"

# 2️⃣ Add Student
print_call "POST" "$BASE_URL/students"
curl -s -X POST $BASE_URL/students \
-H "Content-Type: application/json" \
-d '{
  "name": "John Doe",
  "age": 22,
  "email": "john@example.com"
}'
echo -e "\n"

# 3️⃣ Get All Students
print_call "GET" "$BASE_URL/students"
curl -s -X GET $BASE_URL/students
echo -e "\n"

# 4️⃣ Get Student by ID
print_call "GET" "$BASE_URL/students/1"
curl -s -X GET $BASE_URL/students/1
echo -e "\n"

# 5️⃣ Update Student
print_call "PUT" "$BASE_URL/students/1"
curl -s -X PUT $BASE_URL/students/1 \
-H "Content-Type: application/json" \
-d '{
  "name": "John Updated",
  "age": 23
}'
echo -e "\n"

# 6️⃣ Verify Update
print_call "GET" "$BASE_URL/students/1"
curl -s -X GET $BASE_URL/students/1
echo -e "\n"

# 7️⃣ Delete Student
print_call "DELETE" "$BASE_URL/students/1"
curl -s -X DELETE $BASE_URL/students/1
echo -e "\n"

# 8️⃣ Final List
print_call "GET" "$BASE_URL/students"
curl -s -X GET $BASE_URL/students
echo -e "\n"

echo "✅ API testing finished"