title: JAVA technology
date: 2016-05-01 19:43:54
tags: [JAVA, Summary]
---

# Description
---
In this course, we mainly learned the fundamentals of JAVA, JDBC, concurrency, network, GUI.

# Fundamentals of JAVA
---
## Class && Object
1. Everything is object.
2. We do not need to destroy objects by ourselves
3. Every objects has its own instance

## Inherit and Polymorphism
1. We use **extends** keyword
2. The constructor process:
class javapracticeExam extends practiceExam extends Exam, the constructor process is:
in constructor Exam -> in constructor practiceExam -> in constructor Exam
3. Override -> polymorphism, keep parameters same

## Exceptions
An **exceptional condition** is a problem that prevents the continuation of the current method or scope. With a nexceptional condition, you cannot continue processing because you don't have the information necessary to deal with the problem in the cuurent context. All you can do is jump out of the current context and relegate that problem to a higher context. This is what happens when you throw an exception.

## Inner class
[TODO]

## Interface
1. implements keyword
2. The **interface** keyword produces a completely abstract class, one that provides no implemetntation at all. An interface says, "All classes that implement this particular interface will look like this." Thus, any code that uses a particular interface knows what methods might be called for that interface, and that's all. So the interface is used to establish a "protocol" between classes.

# JDBC
---
1. MySQL jar package

# Concurrency
---
1. Multithreads 
	- implements Runnable
	- extends Thread
2. Synchronize
3. Bank example

# Network
---
1. serialiable
2. TCP

# GUI
---
[TODO]
