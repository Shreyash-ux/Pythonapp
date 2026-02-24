from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
import os

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL", "sqlite:///students.db")

    db.init_app(app)
    Migrate(app, db)

    from app.routes import api
    app.register_blueprint(api, url_prefix="/api/v1")

    return app