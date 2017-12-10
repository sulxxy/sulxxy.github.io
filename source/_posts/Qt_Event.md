title: Qt Note 4 -- Event
date: 2015-08-02 16:45:34

tags: [Qt]
---

# Introduction
---
The QEvent class is the base class of all event classes. Event objects contain event parameters.

Qt's main event loop (QCoreApplication::exec()) fetches native window system events from the event queue, translates them into QEvents, and sends the translated events to QObjects.

In general, events come from the underlying window system (spontaneous() returns true), but it is also possible to manually send events using QCoreApplication::sendEvent() and QCoreApplication::postEvent() (spontaneous() returns false).
<!-- more -->

QObjects receive events by having their **QObject::event()** function called. The function can be reimplemented in subclasses to customize event handling and add additional event types; QWidget::event() is a notable example. By default, events are dispatched to event handlers like QObject::timerEvent() and QWidget::mouseMoveEvent(). QObject::installEventFilter() allows an object to intercept events destined for another object.

The basic QEvent contains only an event type parameter and an "accept" flag. The accept flag set with accept(), and cleared with ignore(). It is set by default, but don't rely on this as subclasses may choose to clear it in their constructor.

Subclasses of QEvent contain additional parameters that describe the particular event.

# TimerEvent
---
The QTimerEvent class contains parameters that describe a timer event.

Timer events are sent at regular intervals to objects that have started one or more timers. Each timer has a unique identifier. A timer is started with **QObject::startTimer()** which return a timer id. That is, we can have more than one timer in a program.

The QTimer class provides a high-level programming interface that uses signals instead of events. It also provides single-shot timers.

The event handler QObject::timerEvent() receives timer events.

A small sample about QTimerEvent:
{% codeblock %}	
//somewhere like constructors or showEvent balabala
TimerID = QObject::startTimer(50);
//the definition of the timerEvent()
void Class:timerEvent(QTimerEvent* event){
if(event->timerID() == TimerID){
	//Your code here
}else{
	QWidget::timerEvent(event);         //This statement is weird, because I cannot find function 
						//timerEvent() in class QWidget from the Qt manual. 
					//But it really works. The timerEvent() can be found in QObject. 
					//And if we replace QWidget with QObject, it still work.
	}
}
{% endcodeblock %}	

# Event Source
---
In Qt, there are 3 ways to create an event:
1. Underlying window system: Qt will translate them into a specific event.
2. Qt Application
3. User-defined event:		
	1. sendEvent(QObject\* obj, QEvent\* event): *event* is directly sent to the obj. It must be created in stack
	2. postEvent(QObject\* obj, QEvent\* event): *event* is sent to the main event queue waiting to be disposed. It must be created in the heap.

# Process
---

# Event and Signal
---
We use signals when we use some widget, while we use events when we implement some widgets. To put it another way, we almost do not have to care about what underlying events happend. What we really need to care is how to we send a specific signal to call some specific slots.

# A problem
---
I write a program which sends an event to the event queue. The code is like this:
{% codeblock %}	
QEvent event(QEvent:Close);
QCoreApplication::sendEvent(this, &event);

//definition of event():
bool TEST::event(QEvent* event){
	if(event->type() == QEvent:Close){
		//...
	}
	return QWidget:event(event);
}
//or:
void TEST::closeEvent(QCloseEvent* event){
	//...
	qDebug() << event->isAccepted() << endl;
}
{% endcodeblock %}

However, it does not work even though it can be received by event() or closeEvent function. Also, the return value of isAccepted() is true. I think the reason is the object class *event* I created may miss something compared with the closeevent created by system. 

# Other issues
---
1. Function **event()** has higher priority than function **closeEvent()**;
Look at the following code:
{% codeblock %}		
bool TEST::event(){
	// code block 1
}
void TEST::closeEvent(CloseEvent* event){
	// code block 2
}
{% endcodeblock %}		

When I close the program, only the function event() is called. Only if I annoted the function event(), the closeEvent() can be called.
2. Write a custom event
A simple version like following:
{% codeblock %}		
static const QEvent::Type CustomType = (QEvent::Type)QEventRegisterType(QEvent::User + 123);

//In another block
QEvent event(CustomType);
QApplication::sendEvent(this, &event);
/*
or:
QEvent *event = new QEvent(CustomType);
QApplication::postEvent(this, event);
*/

//definition of function event():
void TEST::event(QEvent* event){
	if(event->type() == CustomType){
		// dispose function
	}
}
{% endcodeblock %}	
