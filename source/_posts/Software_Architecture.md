title: Software Architecture
date: 2016-04-10 09:01:12
tags: [Summary]
---


# Description
---
In this course, we mainly talked about some key issues from the point of architecture of a software. We mainly focused following points: 
1. Software architecture styles
2. Software architecture quality attributes
3. Software architecture design
4. Software architecture evaluation

# Styles
---
A style describes a class of architectures and is independent on the problem. It can be reused and has its own properties. Let's take vehicles as an example. As we all know, there are lots kinds of vehicles, such as coupe, off-road, truck, racer. The truck is a kind of vehicle style. While its transmission can be manual or automatic and its color can be white or black, it must be able to carry goods. This characteristic makes truck different from of other kinds of vehicles. Every truck must fulfill this characteristic, otherwise it cannot be called a truck.
In software industry, there're some typical styles. 
1. Data flow
2. Blackboard
3. Virtual machine
4. Event system

## Data flow
In this kind of style, the data flows in a specific sequence. For instance, the process of the APS is a kind of this style. My materials are the data. Firstly, it will be inspected by the staff in the APS department. If there's no problem, my data will be delivered to you and the vice interviewer to dispose it again. In the end, all of my data will be delivered to the embassy. So, as you can see, the data moves from one process to another process sequentially. This is data flow. 
e.g. The shell scripts

## Blackboard
Every component can deliver its data to the blackboard. At the same time, other components are able to get the updated data from the blackboard. For example, a lot of scientists get together to deal with a hard problem. Once anyone of them have some idea, he or she can write his or her idea into the blackboard. Other scientists can read and use the latest data from the blackboard.

There're 3 parts in Blackboard style:
1. Knowledge source
2. Controller
3. Blackboard data structure

e.g. Clipboard in Microsoft Office

## Virtual machine
A virtual machine provides a virtual environment which shields the complex details under them. That means, virtual machine has a great cross-platform feature.  JVM is a typical virtual machine. All of java programs are running on the JVM instead of the physical machine. That why there's no keyword **sizeof** in Java. All of types take up the same memory from the point of programmers. JVM is responsible for the memory management. We don't have to care about it. When we type command **java -c**, we can get a byte code file. This file is delivered to JVM and interpreted by it.  

## Event system
Quora is a kind of event system. On Quora, we can star someone else. For example, I focused a professor. Once he answered some questions, I can get the notification. This operation was done by the system instead of the professor. The professor just needs to publish his content, he doesn't have to notify people who are staring him one by one. 

# Quality attributes
---
## Quality attribute scenarios
1. A scenario is a little story describing an interaction between a stakeholder and a system.
2. A use case is a kind of scenario.
3. A quality attribute scenario is a short description of how a system is required to response to some stimulus.
4. A quality attribute scenario has 6 parts:
	- source: an entity that generates a stimulus
	- stimulus: a condition that affects the system
	- artifact: the part of that was stimulated by the stimulus
	- environment: the condition under which the stimulus occurred
	- response: the activity that results because of the stimulus
	- response measure: the measure by which the system's response will be evaluated
5. System quality attributes:
	- Availability
	- Modifiability
	- Performance
	- Security
	- Testability
	- Usability

## Availability
The availability of a system is the probability that it will be operational when it is needed.

## Modifiability
Modifiability is about the cost of change.

## Performance
Performance is about timing.

## Security
Security is a measure of the system‘s ability to resist unauthorized usage while still providing its services to legitimate users.

## Testability
Software testability refers to the ease with which software can be made to demonstrate its faults through (typically execution-based) testing.

## Usability
Usability is concerned with how easy it is for the user to accomplish a desired task and the kind of user support the system provides.
[TODO]

# Tactics to design an architecture
---
We mainly talked about the following  kinds of tactics:
1. Availability tactics
2. Modifiability tactics
3. Performance tactics
4. Security
5. Testability
6. Usability

## Availability tactics
Keep fault from becoming failure or at least bound the affects of the fault and make repair possible.
1. Fault detection
	We can use ping/echo to achieve this goal. For example, a system consists of a monitor component and many other components. The monitor component pings every other component, and then other components send back an echo to the monitor component. The monitor component detects errors and faults according to the delay. 
	
	Also, the heartbeat is useful for fault detection. If we use heartbeat, the monitor component will ping other components periodically.
	
	At the same time, the exception mechanism in high level programming language is also a useful way to detect errors and faults.
2. Fault recovery
	In order to recovery from fault, we can use data redundancy strategy. That means, we use two or more machines to fulfill a mission. Normally, we get the result from the machine which calculates fast. However, when this machine goes wrong, the other machines can substitute it immediately. 
	
	Another strategy is to set checkpoint periodically or at some critical point. For example, when we use Microsoft Word, the program can save our documents automatically every 5 minutes. Once our computer gets wrong, Microsoft word can roll back to the latest checkpoint and restore from there.
3. Fault prevention
	There's an old saying in China, *I cannot fight against you, but I can stay away from you*. Sometimes, we can remove a component of a system from the operation to undergo some activities to prevent anticipated failures.
	
	Another way is to use transactions. A task can only have two states: **Not Started** and **Finished**. In database, we often use this kind of method. This can simplify the steps to recovery from fault and make the database more stable.

## Modifiability tactics
Control the time and the cost when implementing or testing a change.
1. Localize changes
In order to localize changes, we can make our software with high level cohesion and low level coupling. That means, every module fulfills a very simple function. Through this, modification can be made in one module. 
2. Prevent ripple effects
Ripple effects prevention can make the modification in one module not affect other modules. To fulfill this, we can maintain some fixed interfaces. Let take the meal order as an example. If I want to order a meal, we just need to make a phone call to the restaurant. Only if the telephone number of the restaurant doesn't change, customers can make the deal. And the chef in restaurant can change the cooking method in any way.
3. Defer binding time
For example, we can use configuration files to fulfill this. When we use configuration files, we can avoid to insert data into our program. Also, if we want to modify some parameters, we just need to modify the configuration files.

## Performance tactics
1. Resource demand
2. Resource management
3. Resource arbitration

## Security
1. Resisting attacks
Authentication and authorization. Authentication is ensuring that a user or remote computer is actually who it purports to be. Authorization ensures that the authenticated user has the proper rights to access data and services.

MD5 is another typical example. To prevent software not being modified, many software companies calculate MD5 for their product. This can maintain integrity. 
2. Detecting attacks
3. Recovering from attacks

## Testability 
1. Manage IO
Having specialized interfaces for testing to allow get the special output and trail some specific variables. 
2. Internal monitoring
IDE, set breakpoint 

## Usability
[TODO]

# Software architecture evaluation
---
1. ATAM: Architecture Trade-off Analysis Method
Purpose: make a trade off to find:
	1. Risk: May damage some quality attributes
	2. Non-risk: Improve quality attributes
	3. Sensitivity-point: a small change can make a great difference
	4. Tradeoffs: incluence one more attributes
2. Utility tree
From left to right: Utility -> Quality attributes -> Detailed quality attributes -> Scenario




