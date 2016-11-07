title: Fixed the error of "The server quit without updating pid file (/usr/local/mysql/data/)" when starting MySQL server
date: 2016.09.11 18:19:46
categories: Technique
tags: [MySQL]
---

# Problem Description
When starting the MySQL server using:

	$ /usr/local/mysql/support-files/mysql.server start
there was an error:

	The server quit without updating pid file (/usr/local/mysql/data/)
There may be serveral reasons for this problem, such as the Permissons of the $mysql/data, the running **mysqld** process, the content of the file **my.cnf**. The first two factors may be the main reasons.
<!-- more -->

# Solutions
For this kind of problem description, the most common reason is the **mysqld** process has been running, so we need to the PID of this process and kill it first. 

	$ ps -ef | grep mysqld
or:

	$ lsof -i tcp:3306
And then:

	$ kill PID
However, it seems that this does not work because it shows that there will be **mysqld** will we run **ps** command. On OS X, we can solve this problem by:

	$ sudo launchctl unload -w /Library/LaunchDaemons/com.mysql.mysql.plist
Now, we can run **ps** and **kill** again to kill **mysqld** process.

However, the server still cannot be started. When we run:

	$ /usr/local/mysql/bin/mysqld
There will be some error hints like:

	2016-09-11T08:19:44.546145Z 0 [Warning] Can't create test file /usr/local/mysql-5.7.15-osx10.11-x86_64/data/liuxuanxianying-2.lower-test
	2016-09-11T08:19:44.546174Z 0 [Warning] Can't create test file /usr/local/mysql-5.7.15-osx10.11-x86_64/data/liuxuanxianying-2.lower-test
	2016-09-11T08:19:44.546225Z 0 [ERROR] failed to set datadir to /usr/local/mysql-5.7.15-osx10.11-x86_64/data/
	2016-09-11T08:19:44.546235Z 0 [ERROR] Aborting
	
	2016-09-11T08:19:44.546297Z 0 [Note] Binlog end
	2016-09-11T08:19:44.546386Z 0 [Note] ./bin/mysqld: Shutdown complete
And:

	2016-09-11T08:22:27.222620Z 0 [ERROR] InnoDB: ./ib_logfile1 can't be opened in read-write mode.
	2016-09-11T08:22:27.222654Z 0 [ERROR] InnoDB: Plugin initialization aborted with error Generic error
	2016-09-11T08:22:27.525831Z 0 [ERROR] Plugin 'InnoDB' init function returned error.
	2016-09-11T08:22:27.525876Z 0 [ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
	2016-09-11T08:22:27.525892Z 0 [ERROR] Failed to initialize plugins.
	2016-09-11T08:22:27.525899Z 0 [ERROR] Aborting
	
	2016-09-11T08:22:27.525927Z 0 [Note] Binlog end
	2016-09-11T08:22:27.526055Z 0 [Note] Shutting down plugin 'CSV'
	2016-09-11T08:22:27.526671Z 0 [Note] ./bin/mysqld: Shutdown complete
And:

	2016-09-11T08:23:03.520447Z 0 [ERROR] InnoDB: Operating system error number 13 in a file operation.
	2016-09-11T08:23:03.520457Z 0 [ERROR] InnoDB: The error means mysqld does not have the access rights to the directory.
	2016-09-11T08:23:03.520465Z 0 [ERROR] InnoDB: Operating system error number 13 in a file operation.
	2016-09-11T08:23:03.520469Z 0 [ERROR] InnoDB: The error means mysqld does not have the access rights to the directory.
	2016-09-11T08:23:03.520473Z 0 [ERROR] InnoDB: Cannot open datafile './ibtmp1'
	2016-09-11T08:23:03.520476Z 0 [ERROR] InnoDB: Unable to create the shared innodb_temporary
	2016-09-11T08:23:03.520479Z 0 [ERROR] InnoDB: Plugin initialization aborted with error Cannot open a file
	2016-09-11T08:23:03.829192Z 0 [ERROR] Plugin 'InnoDB' init function returned error.
	2016-09-11T08:23:03.829230Z 0 [ERROR] Plugin 'InnoDB' registration as a STORAGE ENGINE failed.
	2016-09-11T08:23:03.829245Z 0 [ERROR] Failed to initialize plugins.
	2016-09-11T08:23:03.829253Z 0 [ERROR] Aborting
	
	2016-09-11T08:23:03.829279Z 0 [Note] Binlog end
	2016-09-11T08:23:03.829430Z 0 [Note] Shutting down plugin 'CSV'
	2016-09-11T08:23:03.829838Z 0 [Note] ./bin/mysqld: Shutdown complete
The reason for these errors is the improper permission of the $MySQL/data directory. In order to fix this problem, we can do the following steps:

	$ sudo chown -R root:wheel /usr/local/mysql
	$ sudo chmod -R 777 /usr/local/mysql

Now, we can start the mysql server again:

	$ /usr/local/mysql/bin/mysqld
Or:

	$ /usr/local/mysql/support-files/mysql.server start
After starting the server, we are able to connect to the server using:

	$ /usr/local/mysql/bin/mysql -u root -p 'Your Password'

