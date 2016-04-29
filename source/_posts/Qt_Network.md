title: Qt Note 5 -- Network
date: 2015-08-05 21:52:23
tags: [Qt]
---

# Introduction
---
Qt Network provides a set of APIs for programming applications that use TCP/IP. Operations such as requests, cookies, and sending data over HTTP are handled by various C++ classes.

To link against the Qt Network module, add this line to the project file:

	QT  +=  network

# Network programming with Qt
---
Qt network module offers classes that allow you write TCP/IP clients and servers. It offers lower-level classes such as QTCPSocket, QTCPServer and QUDPSocket that represents low level network concepts; and higher-level classes such as QNetworkRequest, QNetworkReply and QNetworkManager to perform network operations using common protocols.It also offers classes such as QNetworkConfiguration, QNetworkConfigurationManager and QNetworkSession that implement bearer management.

# HTTP and FTP
---
The Network Access API is a collection of classes for performing common network operations. The API provides an abstraction layer over the specific operations and protocols used (for example, getting and posting data over HTTP), and only exposes classes, functions, and signals for general or high level concepts.

Network requests are represented by the QNetworkRequest class, which also acts as a general container for information associated with a request, such as any header information and the encryption used. The URL specified when a request object is constructed determines the protocol used for a request. Currently HTTP, FTP and local file URLs are supported for uploading and downloading.

The coordination of network operations is performed by the QNetworkAccessManager class. Once a request has been created, this class is used to dispatch it and emit signals to report on its progress. The manager also coordinates the use of cookies to store data on the client, authentication requests, and the use of proxies.

Replies to network requests are represented by the QNetworkReply class; these are created by QNetworkAccessManager when a request is dispatched. The signals provided by QNetworkReply can be used to monitor each reply individually, or developers may choose to use the manager's signals for this purpose instead and discard references to replies. Since QNetworkReply is a subclass of QIODevice, replies can be handled synchronously or asynchronously; i.e., as blocking or non-blocking operations.

Each application or library can create one or more instances of QNetworkAccessManager to handle network communication.

# TCP
---
TCP (Transmission Control Protocol) is a low-level network protocol used by most Internet protocols, including HTTP and FTP, for data transfer. It is a reliable, **stream-oriented**, connection-oriented transport protocol. It is particularly well suited to the continuous transmission of data.

![](/img/QTCP.jpg)

The QTcpSocket class provides an interface for TCP. You can use QTcpSocket to implement standard network protocols such as POP3, SMTP, and NNTP, as well as custom protocols.

A TCP connection must be established to a remote **host and port** before any data transfer can begin. Once the connection has been established, the IP address and port of the peer are available through **QTcpSocket::peerAddress()** and **QTcpSocket::peerPort()**. At any time, the peer can close the connection, and data transfer will then stop immediately.

QTcpSocket works **asynchronously** and emits signals to report status changes and errors, just like QNetworkAccessManager. It relies on the event loop to detect incoming data and to automatically flush outgoing data. You can write data to the socket using QTcpSocket::write(), and read data using QTcpSocket::read(). QTcpSocket represents two independent streams of data: one for reading and one for writing.

Since QTcpSocket inherits QIODevice, you can use it with **QTextStream and QDataStream**. When reading from a QTcpSocket, you must make sure that enough data is available by calling **QTcpSocket::bytesAvailable()** beforehand.

If you need to handle incoming TCP connections (e.g., in a server application), use the QTcpServer class. <u>Call **QTcpServer::listen()** to set up the server, and connect to the **QTcpServer::newConnection()** signal, which is emitted once for every client that connects</u>. In your slot, call QTcpServer::nextPendingConnection() to accept the connection and use the returned QTcpSocket to communicate with the client.

Although most of its functions work asynchronously, <u>it's possible to use QTcpSocket synchronously (i.e., blocking).</u> To get blocking behavior, call QTcpSocket's waitFor...() functions; these suspend the calling thread until a signal has been emitted. For example, after calling the non-blocking QTcpSocket::connectToHost() function, call QTcpSocket::waitForConnected() to block the thread until the connected() signal has been emitted.

Synchronous sockets often lead to code with a simpler flow of control. The main disadvantage of the waitFor...() approach is that events won't be processed while a waitFor...() function is blocking. If used in the GUI thread, this might freeze the application's user interface. For this reason, we recommend that you use synchronous sockets only in non-GUI threads. When used synchronously, QTcpSocket doesn't require an event loop.

The Fortune Client and Fortune Server examples show how to use QTcpSocket and QTcpServer to write TCP client-server applications. See also Blocking Fortune Client for an example on how to use a synchronous QTcpSocket in a separate thread (without using an event loop), and Threaded Fortune Server for an example of a multithreaded TCP server with one thread per active client.

# UDP
---
UDP (User Datagram Protocol) is a lightweight, unreliable, datagram-oriented, connectionless protocol. It can be used when reliability isn't important. For example, a server that reports the time of day could choose UDP. If a datagram with the time of day is lost, the client can simply make another request.

![](/img/QUDP.jpg)

The QUdpSocket class allows you to send and receive **UDP datagrams**. It inherits QAbstractSocket, and it therefore shares most of QTcpSocket's interface. The main difference is that QUdpSocket transfers data as datagrams instead of as a continuous stream of data. In short, a datagram is a data packet of limited size (normally smaller than 512 bytes), containing the IP address and port of the datagram's sender and receiver in addition to the data being transferred.

QUdpSocket supports IPv4 broadcasting. Broadcasting is often used to implement network discovery protocols, such as finding which host on the network has the most free hard disk space. One host broadcasts a datagram to the network that all other hosts receive. Each host that receives a request then sends a reply back to the sender with its current amount of free disk space. The originator waits until it has received replies from all hosts, and can then choose the server with most free space to store data. To broadcast a datagram, simply send it to the special address QHostAddress::Broadcast (255.255.255.255), or to your local network's broadcast address.

QUdpSocket::bind() prepares the socket for accepting incoming datagrams, much like QTcpServer::listen() for TCP servers. Whenever one or more datagrams arrive, QUdpSocket emits the readyRead() signal. Call QUdpSocket::readDatagram() to read the datagram.

The Broadcast Sender and Broadcast Receiver examples show how to write a UDP sender and a UDP receiver using Qt.

QUdpSocket also supports multicasting. The Multicast Sender and Multicast Receiver examples show how to use write UDP multicast clients.

# Problems
---
1. The following code:
	{% codeblock %}	
	class MyServer: public QTcpServer{
		//...
	private:
		void incomingConnection(int sockID);
	}
	
	//definition of incomingConnection()
	void MyServer::incomingConnection(int sockID){
		//...
	}
	{% endcodeblock %}
	According to the official manual, the function incomingConnection() will be called if there is a new connection. But it never be called even though I started the client and sent request to the server.

	After tried a lot of method, I found that the new version Qt has changed the parameter **int sockID** to **qintptr sockID**.
	
	Another weird problem is that the initial code can be run in the Linux(Qt5), even through the parameter is still **int**. Different compilers has different results...
	
	Leave a web page which records some changes in Qt5:[Qt5 porting tips/findings](https://forum.qt.io/topic/21268/qt5-porting-tips-findings)
2. Another problem is about multithread and socket. I implement a server model like below:
	![](/img/serverModel.jpg)
	
	A server has lots of threads, which contains a unique socket for each thread. Now I want to send a msg from one socket to another without using network APIs(since these sockets have connected to its client). I have tried 3 methods:
	1. Directly call target thread's function like this:
		{% codeblock %}	
		//somewhere in thread.cpp
		target_thread->sendMsg(msg);
		And the function sendMsg():
		void Thread::sendMsg(Message* msg){
			socket->write(msg);
		}
		{% endcodeblock %}	
		There would be a runntime error like:
		{% codeblock %}	
		Socket notifiers cannot enabled or disabled from another thread.
		{% endcodeblock %}	
	2. So I tried the second method which commits the request to the server and let the server to send message to socket. But the same error still occurs. But it's closer to the final right answer. 
	3. According to the errors above, we can know that what we need to do is to make the write() function be called in its own thread. My solution is to receive msg in target thread first. Then send a received() signal in current thread and called corresponding slot to write msg to socket.
	{% codeblock %}	
	//somewhere like constructor
	connect(this, SIGNAL(msgReceived(Message*), this, SLOT(writeMsgtoSocket(Message*)));
	//definition of sendMsg()
	void Thread::sendMsg(Message* msg){
		m_Msg = msg;
		emit msgReceived(m_Msg);
	}
	{% endcodeblock %}	
	Through this way, we can successfully implement our requirement.

	
