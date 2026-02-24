Create Virtual Environment
python -m venv venv
source venv/bin/activate   # Mac/Linux

Windows:

venv\Scripts\activate
3️⃣ Install Dependencies
pip install -r requirements.txt
⚙️ Environment Variables

Create .env file:

DATABASE_URL=sqlite:///students.db
▶️ Run Application

Using make:

make run

OR manually:

python run.py

App runs on:

http://127.0.0.1:5000
🗄️ Database Migration

Initialize database (first time only):

make migrate
make upgrade

Manual commands:

flask db init
flask db migrate -m "initial migration"
flask db upgrade
🧪 Run Tests
make test

or

pytest -v
🔌 API Endpoints
Healthcheck
GET /api/v1/healthcheck
Students
POST   /api/v1/students
GET    /api/v1/students
GET    /api/v1/students/{id}
PUT    /api/v1/students/{id}
DELETE /api/v1/students/{id}
🐳 Run with Docker
Build image
docker build -t student-api .
Run container
docker run --env-file .env -p 5000:5000 student-api
🧹 Makefile Commands
make run        # run app
make test       # run tests
make migrate    # create migration
make upgrade    # apply migration