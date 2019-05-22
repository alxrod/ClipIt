from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import json
# password = articles

from config import db

class User(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	username = db.Column(db.String(80), unique=True, nullable=False)
	email = db.Column(db.String(120), unique=True, nullable=False)
	password = db.Column(db.String(80), unique=True, nullable=False)
	auth_token = db.Column(db.String(36), unique=True, nullable=True)

	def __repr__(self):
		return '<User %r>' % self.username

	def serialize(self):
		data = {
			"id": self.id, 
			"username": self.username,
			"email": self.email,
			"password": self.password,
			# Make sure to remove before deployment!!
			"token": self.auth_token,
		}
		return json.dumps(data)



class Article(db.Model):
	id = db.Column(db.Integer, primary_key=True)
	title = db.Column(db.String(80), unique=False, nullable=False)
	url = db.Column(db.String(300), unique=False, nullable=False)

 	receiver_id = db.Column(db.Integer, db.ForeignKey('user.id'),
        nullable=False)
 	receiver = db.relationship('User', foreign_keys=receiver_id, backref=db.backref('received_articles', lazy=True))
 	

 	sender_id = db.Column(db.Integer, db.ForeignKey('user.id'),
        nullable=False)
 	sender = db.relationship('User', foreign_keys=sender_id, backref=db.backref('sent_articles', lazy=True))


	def __repr__(self):
		return '<Article %r>' % self.title

	def serialize(self):
		data = {
			"id": self.id,
			"title": self.title,
			"url": self.url,
			"sender_id": self.sender_id,
			"receiver_id": self.receiver_id,
		}
		return json.dumps(data)

