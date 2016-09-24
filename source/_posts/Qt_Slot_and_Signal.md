title: Qt Note 2 -- Signals and Slots
date: 2015-07-31 10:32:39
categories: Technique
tags: [Qt]
---

# Introduction
---
The signals and slots mechanism is a central feature of Qt which made by Qt's meta-object system.
- A signal is emitted when a particular event occurs. A slot is a function that is called in response to a particular signal. Qt's widgets have many predefined signals and slots. And we can also add our own signals and slots.
![a diagram about Signals and Slots](/img/Signals_and_Slots.jpg)
- Signals and slots are loosely coupled: A class which emits a signal **neither knows nor cares** which slots receive the signal. Likewise, a slot **neither knows nor cares** whether there are some signals connected to it. It is just a normal member function labeld by **slots**.
- We can connect as many as signals as we want to a single slot, and a signal can be connected to as many slots as we need. It is possible to connect a signal directly to another signal(In this case, the receiver will send signal imediately whenever the first is emitted.).

# Building Connection
---
There are several ways to connect signals and slots.
1. Function_Pointer_Based:
{% codeblock %}	
	connect(sender, &QObject::Destroyed, this, &MyObject::objectDestroyed);
{% endcodeblock %}	
It allows the compiler to check that the signal's arguments are compatible with the slot's arguments. Arguments can also be implicitly converted by the compiler if needed. 
<u>**However I have a problem here. I write following code:**</u>
{% codeblock %}	
	connect(qs, &QSingalMapper::mapped, this, &MainWindow::test); 
{% endcodeblock %}	
The compiler gives the following error:
{% codeblock %}	
	E:\Projects\Qt\Signals_Slot\mainwindow.cpp:24: error: C2664: 
	“QMetaObject::Connection QObject::connect(const QObject*,const char*,const char*,Qt::ConnectionType) const”: 
	无法将参数 2 从“overloaded-function”转换为“const char*”
	上下文不允许消除重载函数的歧义
{% endcodeblock %}	
It seems that the compiler thought I am using 
{% codeblock %}	
	QMetaObject::Connection QObject::connect(const QObject * sender, const QMetaMethod & signal, const QObject * receiver, const QMetaMethod & method, Qt::ConnectionType type = Qt::AutoConnection)
{% endcodeblock %}	
However:
{% codeblock %}	
	QMetaObject::Connection QObject::connect(const QObject* sender, PointerToMemberFunction signal, const QObject* context, Functor functor, Qt::ConnectionType type = Qt::AutoConnection)
{% endcodeblock %}	
But the following code is right:
{% codeblock %}	
	QLabel* label = new QLabel;
	QLineEdit* lineEdit = new QLineEdit;
	QObject::connect(lineEdit, &QLineEdit::textChanged,
       					label,  &QLabel::setText);
{% endcodeblock %}	
I cannot figure it out. 
[TODO]This part will be updated once I knew it.

2. String_Based:
{% codeblock %}	
	connect(qs, SIGNAL(mapped(QString)), this, SLOT(test(QString)));
{% endcodeblock %}	
This way is easier to understand. SIGNAL() and SLOT() are macros. They change the arguments to a string. Note that signal and slot **arguments are not checked** by the compiler when using this QObject::connect() overload. The signature passed to SIGNAL() must not have fewer arguments than the signature passed to SLOT(). Otherwise, there would be runtime error, because the slot will be expecting a QObject that the signal will not send. 

3. C++11 lambdas:
{% codeblock %}	
	connect(sender, &QObject::destroyed, [=](){ this->m_objects.remove(sender); });
{% endcodeblock %}	
Note that if your compiler does not support C++11 variadic templates, this syntax only works if the signal and slot have 6 arguments or less. I have not tried this before.

# Advanced features
---
1. For cases where you may require information on the sender of the signal, Qt provides the QObject::sender() function, which returns a pointer to the object that sent the signal.For example:
{% codeblock %}	
	//in somewhere:
	connect(pushButton1, SIGNAL(clicked()), this, SLOT(test());
	The definition of test():
	void MainWindow::test(){
		QPushButton* pb = qobject_cast<QPushButton*)(sender());
		pb->setEnable(false);
	}
{% endcodeblock %}	
Through this, the pushButton1 will be disabled after click it.
**Note that the sender() can only be called in the excution of the slot function**.

2. The QSignalMapper class is provided for situations where many signals are connected to the same slot and the slot needs to handle each signal differently.
Suppose you have three push buttons that determine which file you will open: "Tax File", "Accounts File", or "Report File".
In order to open the correct file, you use QSignalMapper::setMapping() to map all the QPushButton::clicked() signals to a QSignalMapper object. Then you connect the file's QPushButton::clicked() signal to the QSignalMapper::map() slot.
For example:
{% codeblock %}	
	signalMapper = new QSignalMapper(this);
	signalMapper->setMapping(taxFileButton, QString("taxfile.txt"));
	signalMapper->setMapping(accountFileButton, QString("accountsfile.txt"));
	signalMapper->setMapping(reportFileButton, QString("reportfile.txt"));
	connect(taxFileButton, &QPushButton::clicked,
		signalMapper, &QSignalMapper::map);
	connect(accountFileButton, &QPushButton::clicked,
		signalMapper, &QSignalMapper::map);
	connect(reportFileButton, &QPushButton::clicked,
		signalMapper, &QSignalMapper::map);
{% endcodeblock %}	
