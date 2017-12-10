title: Make Flask program visible across the network
date: 2017-01-22 11:25:12

tags: [ Python, Flask ]
---

Flask programs would run on the localhost in default and cannot be accessed by other users inside the network. To make it visible to all users in the network, we need to use the following setting when starting the program:

> $ flask run --host=0.0.0.0

Or write the configuration in the code:

> app.run(host='0.0.0.0')

since having written the *app.run()* in the file, to start the server, we just need to:

> ./server.py


