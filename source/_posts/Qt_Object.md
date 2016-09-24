title: Qt Note 7 -- QObject
date: 2015-08-08 18:33:07
categories: Technique
tags: [Qt]
---

# Introduction
---
QObject is the base class of all Qt **objects** which do not include some classes like QString. 

QObjects organize themselves in object trees. When you create a QObject with another object as parent, the object will automatically add itself to the parent's children() list. The parent takes ownership of the object; i.e., it will automatically delete its children in its destructor. You can look for an object by name and optionally type using findChild() or findChildren().

# Thread Affinity
---
<u>**This part is very important when we use multithread.**</u>

A QObject instance is said to have a thread affinity, or that it lives in a certain thread. When a QObject receives a queued signal or a posted event, the slot or event handler will run <u>*in the thread that the object lives in.*</u>

**Note**: If a QObject has no thread affinity (that is, if thread() returns zero), or if it lives in a thread that has no running event loop, then it cannot receive queued signals or posted events.

By default, <u>*a QObject lives in the thread in which it is created*</u>. An object's thread affinity can be queried using thread() and changed using moveToThread().

All QObjects must live in the same thread as their parent. Consequently:
- setParent() will fail if the two QObjects involved live in different threads.
- When a QObject is moved to another thread, all its children will be automatically moved too.
- moveToThread() will fail if the QObject has a parent.
- If QObjects are created within QThread::run(), they <u>*cannot become children of the QThread object*</u> because the QThread does not live in the thread that calls QThread::run().

**Note**: <u>A QObject's member variables do not automatically become its children. The parent-child relationship must be set by either passing a pointer to the child's constructor, or by calling setParent()</u>. Without this step, the object's member variables will remain in the old thread when moveToThread() is called.

# Q\_DISABLE\_COPY
---
Disables the use of copy constructors and assignment operators for the given Class.

<u>**Instances of subclasses of QObject should not be thought of as values that can be copied or assigned, but as unique identities**</u>. This means that when you create your own subclass of QObject (director or indirect), you should not give it a copy constructor or an assignment operator. However, it may not enough to simply omit them from your class, because, if you mistakenly write some code that requires a copy constructor or an assignment operator (it's easy to do), your compiler will thoughtfully create it for you. You must do more.
