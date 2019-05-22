import requests


# User Creation
payload = {"username": "zack", "email": "zankner@gmail.com", "password": "p*ssword3"}
r = requests.post("http://127.0.0.1:5000/insert-user/",params=payload)

# Article Creation
# payload = {"title": "milton.edu", "url": "milton.edu", "sender_id": 1, "receiver_id": 2}
# r = requests.post("http://127.0.0.1:5000/insert-article/",params=payload)

# Authentication:
payload = {"username": "zack", "password": "p*ssword3"}
r = requests.post("http://127.0.0.1:5000/auth/",params=payload)
print r.content