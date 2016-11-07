title: Data Communication and Computer Network
date: 2016-05-01 15:02:32
categories: Study Notes
tags: [Network]
---

# Description
---
We learned this course from the perspective of network architecture, such as physical layer, data link layer, Internet layer, transport layer, application layer(TCP model).
<!-- more -->

# Physical layer
---
1. This layer is responsible for the transmission of bit stream.
2. Transmission Media
	- Twisted pair: Cheap, most widely used;
	- Optical fiber: big capacity; light; small; free of electromagnetic field.
3. At the physical layer, we need to focus on how to encode signals. There are two kinds of signals: digital signal and analog signal. Also, there are two kinds of data: digital data and analog data. So there are 4 kinds of combination:
	- Digital data, digital signal
		This is the most simplest way. We can use directly use digital signal to represent digital data. There are some common encoding forms:
		- NRZ-L: Nonreturn to Zero-Level; 0 high level; 1 low level;
		- Bipolar-AMI: 0 no line signal; positive or negative level, alternating for successive ones
		- [TODO]
	- Digital data, analog signal
		- ASK(Amplitude Shift Keying)
		- FSK(Frequency Shift Keying)
		- PSK(Phase Shift Keying)
	- Analog data, digital signal
		- PAM sampler
	- Analog data, analog signal

# Data Link
---
There are three main functions in this level:
1. Regulate the flow of data
2. Deal with transmission errors

## Flow Control
1. Stop-and-waiting flow control
The simplest form of flow control, known as stop-and-wait flow control, works as follows. A source entity transmits a frame. After the destination entity receives the frame, it indicates its willingness to accept another frame by sending back an acknowledgment to the frame just received. The source must wait until it receives the acknowledgment before sending the next frame. The destination can thus stop the flow of data simply by withholding acknowledgment. This procedure works fine and, indeed, can hardly be improved upon when a message is sent in a few large frames.
2. Sliding window flow control
The sender and receiver hold a window of frames respectively. The window size is W. When A sends n frames, the window will shrink. When A receives n frames, the window will expand.
[TODO]

## Error Control
It is very normal to generate errors during transmissions. So, we need error control. When an error occurs, the error frame will be asked to send again. This mechanism is referred to as **automatic repeat request(ARQ)**. Three versions of ARQ have been standardized:
1. Stop-and-wait ARO
The source station transmits a single frame and then must await an acknowledgment. No other data frames can be sent until the destination station's reply arrives at the source station. 
The principal advantage of stop-and-wait ARQ is its simplicity.
2. Go-back-N ARQ
The form of error control based on sliding-window flow control that is most commonly used is called go-back-N ARQ. In this method, a station may send a series of frames sequentially numbered modulo some maximum value. If the destination station detects an error in a frame, it may send a negative acknowledgment for that frame.The destination station will discard that frame and all future incoming frames until the frame in error is correctly received. Thus, the source station, when it receives a REJ, must retransmit the frame in error plus all succeeding frames that were transmitted in the interim.
3. Selective-reject ARQ
With selective-reject ARQ, the only frames retransmitted are those that receive a negative acknowledgment.

## Ethernet
In the bottom of the data link layer, there is a sublayer called **Medium Access Control(MAC)**. 

# Internet
---
datagram, virtual circuit, end to end, computer to computer
IP protocol
IP address

# Transport
---
1. process to process
2. The ultimate goal of the transport layer is to provide efficient, reliable, and cost-effective data transmission service to its users, normally processes in the application layer.
3. Primitive
	- LISTEN: Block until some process tries to connect
	- CONNECT: Actively attempt to establish a connection
	- SEND: Send information
	- RECEIVE: Block until a DATA packet arrives
	- DISCONNECT: Request a release of the connection
4. Elements of transport protocols
	- Addressing: When an application process wishes to set up a connection to remote application process, it must specify which one to connect to. We use **port** to specify it. Similarly, we use **IP** to specify a host in network layer.
	- Connection establishment: hostA, hostB; A sends a connection request with seq=x;then, B receives the request, B sends back a acknowledgment with seq=y,ack=x, by doing this, A knows B is ready for connection. Then, after A receives the ack from B, A will send back a Data packet with ack=y, by doing this, B will know that A has known B is ready.
	- Connection release: the same

## TCP
TCP was specifically designed to provide a reliable end-to-end byte stream over an unreliable internetwork. An internet- work differs from a single network because different parts may have wildly dif- ferent topologies, bandwidths, delays, packet sizes, and other parameters. TCP was designed to dynamically adapt to properties of the internetwork and to be robust in the face of many kinds of failures.
1. The TCP service model
TCP service is obtained by both the sender and the receiver creating end points, called **socket**. Each socket has a socket number(address) consisting of the IP address of the host and a 16-bit number local to that host, called a **port**. 
2. The TCP segment header


## UDP
The Internet protocol suite supports a connectionless transport protocol called **UDP(User Datagram Protocol)**. UDP provides a way for applications to send encapsulated IP datagrams without having to establish a connection.
[TODO headers]
One area where it is especially useful is in client-server situations. Often, the client sends a short request to the server and expects a short reply back. If either the request or the is lost, the client can just time out and try again. Not only is the code simple, but fewer messages are required.
An application that uses UDP this way is DNS. In brief, a program that needs to kook up the IP address of some host name, for example, www.cs.berkeley.edu, can send a UDP packet containing the host name to a DNS server. The server replies with a UDP packet containing the host's IP address. 

# Application
---
## DNS
DNS means Domain Name System. It is primarily used for mapping host names to IP addresses. To map a name onto an IP address, an application program calls a library procedure called the **resolver**, passing it the name as a parameter.
The Internet is divided into over 250 **top-level domains**, where each domain covers many hosts. Each domain is partitioned into subdomains, and these are further partitioned, and so on.
In theory at least, a single name server could contain the entire DNS database and respond to all queries about it. In practice, this server would be so overloaded as to be useless. Furthermore, if it ever went down, the entire Internet would be crippled.
To avoid the problems associated with having only a single source of information, the DNS name space is divided into nonoverlapping **zones**. 

## Email
Sender User Agent -> Message Transfer Agent -> SMTP -> Message Transfer Agent -> Receiver User Agent
