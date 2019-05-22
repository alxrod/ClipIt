from flask import Flask, request
import json
from flask_sqlalchemy import SQLAlchemy
from persistence import User, Article, db
from config import app
import uuid


@app.route("/")
def all_data_pull():
	return json.dumps("All Information")

# Temp Developer API Routes
@app.route("/a-users")
def all_users():
	all_u = User.query.all()
	users = []
	for u in all_u:
		users.append(u.serialize())
	return json.dumps(users)

@app.route("/a-articles")
def all_articles():
	all_a = Article.query.all()
	articles = []
	for a in all_a:
		articles.append(a.serialize())
	return json.dumps(articles)


# ----------------------------------------------------------------------

@app.route("/article-b-sender/", methods = ['POST', 'GET'])
def articles_by_sender():
	uname = request.args.get('auth_token')
	print "\n\n\n\n\n ------------------------------------"
	print "Id is " + str(uname+1)
	user = User.query.filter_by(auth_token=uname).first()
	articles = user.sent_articles
	fixedArticles = []
	for a in articles:
		fixedArticles.append(a.serialize())
	return json.dumps(fixedArticles)

@app.route("/article-b-receiver/", methods = ['POST', 'GET'])
def articles_by_receiver():
	uname = request.args.get('auth_token')
	user = User.query.filter_by(auth_token=uname).first()
	articles = user.received_articles
	fixedArticles = []
	for a in articles:
		fixedArticles.append(a.serialize())
	return json.dumps(fixedArticles)

@app.route("/insert-user/", methods=['POST', 'GET'])
def insert_user():
	if request.method == "POST":
		uname = request.args.get("username")
		password = request.args.get("password")
		email = request.args.get("email")
		newU = User(username=uname,password=password,email=email)
		db.session.add(newU)
		db.session.commit()
		return json.dumps(newU.serialize())

@app.route("/insert-article/", methods=['POST', 'GET'])
def insert_article():
	if request.method == "POST":
		title = request.args.get("title")
		url = request.args.get("url")
		sender_id = request.args.get("sender_id")
		receiver_id = request.args.get("sender_id")
		sender = User.query.filter_by(id=sender_id).first()
		receiver = User.query.filter_by(id=receiver_id).first()
		newA = Article(title=title, url=url,sender=sender,receiver=receiver)
		db.session.add(newA)
		db.session.commit()
		print "saved"
		return json.dumps(newA.serialize())

	return json.dumps("Insert Article")



# Eventually I should really add some encryption here:
@app.route("/auth/", methods=["POST", "GET"])
def authenticate():
	if request.method == "POST":
		username = request.args.get("username")
		password = request.args.get("password")
		user = User.query.filter_by(username=username).first()
		if user:
			if password == user.password:
				print "Validated"
				dupToken = False
				tempToken = str(uuid.uuid1())
				dubUsers = User.query.filter_by(auth_token=tempToken).all()

				while len(dubUsers) != 0:
					tempToken = str(uuid.uuid1())
					dubUsers = User.query.filter_by(auth_token=tempToken).all()

				user.auth_token = tempToken
				db.session.commit()
				return json.dumps(user.auth_token)

			else:
				return json.dumps("incorrect-password")
		else:
			return json.dumps("invalid_user")
	return json.dumps("Improper authentication protocol")

