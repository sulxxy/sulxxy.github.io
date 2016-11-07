title: Operating System
date: 2016-04-10 21:09:42
categories: Study Notes
tags: [Operating System]
---

# Description
---
This course mainly talks about some important concepts of an operating system, which includes sessions of process management, memory management, file system, IO and dead lock.
<!-- more -->

# Processes & Threads
---
## Process
1. A process is an instance of an executing program, including the current values of the program counter, registers and variables.  
2. A process can have 3 states: **blocked**, **running**, **ready**.[TODO:Figure: Transform]
3. Every process has its own process space. A process table records all of information about the process(register, program counter, status word...)

## Thread
1. A thread is a kind of light-weight process.
2. Threads of a process can share the address space and the data.
3. e.g. A word processor
There is a file which contains many pages. I have 2 requests. Firstly, I delete the first page. Then I want to go to some page. If there is only one thread, we must wait the processor to reformat the file, then we can go to our specific page. However, if we use two threads, one thread is used to monitor the modification of the file and the another is used to go to our specific page. So, once the file were modified, the monitoring thread will reformat the file immediately. As a result, the another thread can give response to the user immediately.

## Interprocess communication
1. Race condition
One more processes are reading or writing some shared data and the final result depends on who runs precisely, are called **race condition**.
2. Mutual exclusion with busy waiting
	- Continuously testing a variable until some value appears is called **busy waiting**.
	- Peterson algorithm
		{% codeblock %}
		# define N 2 /*number of processes*/
		int turn;
		int interested[N];
		void enter_region(int process){
			int other;
			other = 1 - process;
			interested[process] = TRUE;
			turn = TRUE;
			while(process == turn && interested[other] == TRUE);
		}
		void leave_region(int process){
			interested[process] = FALSE;
		}
		{% endcodeblock %}
	- Busy waiting wastes a lot of CPU time, so we can use **block** instead of busy waiting.
3. Sleep and wake up
	- Sleep: cause the caller to block, that is, be suspended until another process wakes it up
	- Wake up: wake the process up
	- Producer-Consumer problem
4. Semaphores
	- A control flag
	- P(down)
		{% codeblock %}	
		if( semaphore > 0)
			semaphore--;
		else
			sleep current process;
		{% endcodeblock %}
	- V(up)
		{% codeblock %}
		semaphore++;
		if(there were processes sleeping on this semaphore){
			wake up one of them;
		}
		{% endcodeblock %}

## Scheduling
1. Preemptive and nonpreemptive 
2. Batch system
	- First-come first-served
	- Shortest job first
	- Shortest remaining time next
3. Interactive system
	- Round-robin
	- Priority
	- Multiple queues
	- Guaranteed scheduling
4. Real time system
	- [TODO]

# Memory Management
---
## Memory abstraction
1. No memory abstraction
The simplest memory abstraction is no abstraction at all. Every program simply saw the physical memory.
{% codeblock %}
MOV REGISTER1, 1000
{% endcodeblock %}
There are 2 drawbacks:
	1. This can easily cause program and system collapse since programs are able to access any physical memory address.
	2. It's very hard to get some parallelism in a system.
2. Address space
	An address space is the set of addresses that a process can use to address memory. Each process has its own address space, independent of those belonging to other processes. 
	In order to deal with memory overload, there are two approaches, **swapping** and **virtual memory**.
	1. Swapping
		Swapping consists of bringing in each process in its entirety, running it for a while, then putting it back on the disk.
		There are 2 ways to manage free memory:
		- Bitmaps
		- Free lists
		Drawback: Swapping can waste a lot of CPU time during swapping out and swapping in.
	2. Virtual memory
		More often, we use virtual memory.

## Virtual memory
The basic idea behind virtual memory is that each program has its own address space, which is broken up into chunks called **pages**. Each page is a contiguous range of addresses.

The program-generated addresses are called **virtual address** and form the **virtual address space**. The virtual addresses do not go directly to the memory bus. Instead, they go to an **MMU(Memory Management Unit)** that maps the virtual addresses onto the physical memory addresses.
![MMU](http://7xssst.com2.z0.glb.clouddn.com/MMU)

There is a very simple example shown in the following figure. The virtual address space is divide into fixed-size units called **pages**. The corresponding units in the physical memory are called **page frames**.  
When the program tries to access address 0, using the instruction:
{% codeblock %}
MOV REG, 0
{% endcodeblock %}

The virtual address 0 is sent to the MMU. The MMU sees that this virtual address falls in page 0, which according to its mapping is page frame 2. It thus transforms the address 0 to 8192 and outputs address 8192 onto the memory bus. 
![Virtual memory maps physical memory](http://7xssst.com2.z0.glb.clouddn.com/Virtual%20memory%20mapping)

Inside the MMU, it works like this:
![Inside MMU](http://7xssst.com2.z0.glb.clouddn.com/Inside_MMU)
The page number is used as an index into the **page table**. Once MMU gets a virtual address from CPU, it will get the page number from the address. Then, the MMU will query the page table through the page number. 
1. The query result is the physical page frame number if current page is present(Present bit means current page is in the memory; absent bit means current page is not in the memory). The page number address of virtual address will be replaced by the page frame address. At last, the MMU outputs the final physical address.
2. If current page is absent, **page fault** will happen. In this case, we must to choose some page to swap out from physical memory and swap in the current page to the memory. After that, current instruction will be executed again. In order to choose the right page to swap out, we need page replacement algorithms.

## Page replacement algorithms
1. The optimal page replacement algorithm
At the moment that a page fault occurs, some set of pages is in memory. One of these pages will be referenced on the very next instruction. The optimal page replacement algorithm says this page should be removed. However, this algorithm is impossible to implement because operating systems have no way of knowing when each of the pages will be referenced next.
2. The not recently used page replacement algorithm
class 0: not referenced, not modified
class 1: not referenced, modified
class 2: referenced, not modified
class 3: referenced, modified 
The NRU algorithm removes a page at random from the lowest-numbered nonempty class. From class 1 and 2, implicit in this algorithm is the idea that it is better to remove a modified page that has not been referenced in at least one clock tick than a clean page that is in heavy used. 
3. The first-in, first-out page replacement algorithm
[TODO]
4. The second-chance page replacement algorithm
5. The clock page replacement algorithm
6. The least recently used page replacement algorithm
7. Simulating LRU in software
8. The working set page replacement algorithm
9. the WSClock page replacement algorithm

# File System
---
[TODO]
## File system layout

# IO
---
## Principles of IO hardware
[TODO]
## Principles of IO software
1. Programmed IO
2. Interrupt-driven IO
3. DMA(Direct Memory Access)
	1. CPU programs the DMA controller
	2. DMA requests transfer to memory
	3. Data transferred
	4. Ack
	5. Interrupt when done
4. Disk
[TODO]

# Dead lock
---
For many applications, a process needs exclusive access to not one resource, but several. For example, two processes each want to record a scanned document on a CD. Process A requests permission to use the scanner and is granted it. Process B is programmed differently and requests the CD recorder first and is also granted it. Now A asks for the CD recorder, but the request is denied until B releases it. Unfortunately, instead of releasing the CD recorder, B asks for the scanner. At this point both processes are blocked and will remain so forever. This situation is called a **deadlock**.

Deadlock can be defined formally as follows:

*A set of processes is deadlocked if each process in the set is waiting for an event that only another process in the set can cause.*

## Conditions for resource deadlocks
1. Mutual exclusion condition. Each resource is either currently assigned to exactly one process or is available.
2. Hold and wait condition. Processes currently holding resources that were granted earlier can request new resources.
3. No preemption condition. No preemption condition. Resources previously granted cannot be forcibly taken away from a process. They must be explicitly released by the process holding them.
4. Circular wait condition. There must be a circular chain of two or more processes, each of which is waiting for a resource held by the next member of the chain.

## Deadlock Detection
[TODO Resource graph]

## Deadlock Prevention
1. Mutual exclusion: Spool everything
2. Hold and wait: Request all resources initially
3. No preemption: Take resources away
4. Circular wait: Order resources numerically

