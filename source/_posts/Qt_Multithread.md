title: Qt Note 6 -- Multithread
date: 2015-08-07 15:45:29
categories: Technique
tags: [Qt]
---

1. If you need a thread to handle event, do not forget to add **exec()** in the function **run()**;
2. Do not use **this** pointer as a parameter of some merber's constructors in the QThread and its subclasses. For instance:
{% codeblock %}	
SocketThread::SocketThread(qintptr socketDescriptor, QParent*)
	:QThread(parent){
	ServerSocket* socketsocket = new ServerSocket(this);
	//....
}  
{% endcodeblock %}

In this case, the program will have a runtime error like this: 	
{% codeblock %}	
	cannot create children for a parent in different thread.
{% endcodeblock %}	

