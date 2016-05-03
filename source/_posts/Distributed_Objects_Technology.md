title: Distributed Objects Technology
date: 2016-05-03 14:41:42
tags: [Summary]
---

# Description
---
In this course, we mainly talked about distributed software. A distributed software is a software system in which components located on networked computers. There are 3 main parts:
1. Software components and middleware
2. CORBA
3. EJB

# Components and Middleware
---
## From 2 Layers to 3 Layers
In early stage, we do not have the concepts of middleware. That means, clients can access database directly. This can lead to many problems. For example, the clients have to process complex data; the database is not security. To deal with this problem, we use 3 layers, adding a middle layer between the client layer and database layer. An advantage is, the middle layer can provide lots of functions developed by developers. And complex computing tasks can be done by the middle layer.

## Components
Components need to be encapsulated extremely.
1. Programming language: A java client cannot know that the components are implemented using C++.
2. Physical location: A client does not know where is the components, in current process? In different process of the same machine? In another machine? The client will never know the answer.
3. The interface of components should never be changed while updating.

## Middleware
As developers, we always hope that we do not have to care about the underlying complex details. So, that's why we create middleware. For example, the operating system, the database management system can be seen as middleware. Operating systems shield the complex hardware details and provide a unified environment to applications. The precise definition of middleware is the software between operating systems and application systems, providing support and management for distributed application.

Middleware provides running environment for components, manages the life cycle of components. 

# CORBA
---
## Object Management Architecture

## procedure:
1. Object-oriented analysis and design
2. IDL -> interface
3. compile IDL using idlj, stub, skeleton 
4. client, server
5. deploy

## Client

## Server: POA



# EJB
---
[TODO]
