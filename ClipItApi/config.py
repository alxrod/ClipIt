from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////Users/alexrodriguez/Desktop/Github/ClipIt/ClipItApi/dev_server.db'
db = SQLAlchemy(app)
