title: UML
date: 2016-04-24 10:00:12
categories: Curriculum Summary
---

# Description
---
UML means Unified Modeling Language. In this course, we talked about some typical models and diagrams.

# 4+1 model
---
## Scenarios
1. Describes the functionality of the system.
2. This view typically contains use case diagrams.

## Logical View
1. Describes the abstract descriptions of a **system's parts**. 
2. This view typically contains class diagrams, object diagrams, state diagrams and interaction diagrams.

## Development view
1. Describes how your system's parts are organized into modules and components.
2. This view typically contains package and component diagrams.

## Process view
1. Describes the processes within your system. It is partially helpful when visualizing what must happen within your system.
2. This view typically contains activity programs.

## Physical view
1. Describes how the system's design, as described in the three previous views, is then brought to life as a set of real-world entities.
2. This view typically contains deployment diagrams.

# Use case model
---

There are 3 elements:
1. Actor
Actors are entities that interface with the system.
2. Use case
A use case is a list of actions or event steps, typically defining the interactions between an actor and a system to achieve a goal.
3. Relationship
	- Extend relationships
		An extend relationship from use case A to use case B indicates that an instance of use case B may be augmented(subject to specific conditions specified in the extension) by the behavior specified by A. The behavior is inserted at the location defined by the extension point in B which is referenced by the extend relationship.
		[TODO Figure]
	- Include relationships
		An include relationship from use case A to use case B indicates that an instance of the use case A will also contain the behavior as specified by B. The behavior is included at the location which defined in A.
		[TODO Figure]
	- Generalization relationships
		A generalization from use case A to use case B indicates that A is a specialization of B.
		[TODO Figure]


# Analysis diagram
---
[TODO]

# Structural model
---
## Class diagram
1. Name
2. Attributions
3. Operations

## Relation
1. Generalization
A generalization is a specialization/generalization relationship in which object of the specialized element(the child) are substitutable for objects of the generalized element(the parent). In this way, the child shares the structure and the behavior of the parent. 
2. Realization
A realization is a semantic relationship between classifiers, wherein one classifier specifies a contract that another classifier guarantees to carry out.
3. Dependency
An dependency is a semantic relationship between two things in which a change to one thing(the independent thing) may affect the semantics of the other things(the dependent thing).
4. Association
An association is a structural relationship that describes a set of links, a link being a connection among objects.
5. Aggregation
A special form of association that models a whole-part relationship between an aggregate(the whole) and its parts.
	- has a
	- has a collection of
	- is composed of
## Components & Deployment
[TODO]

# Behaviour model
---
## Sequence diagram
A sequence diagram shows how processes operate with one another and what order. It is a construct of Message sequence chart.
1. Object
2. lifeline
3. messages

[TODO figure]
## State diagram
A state diagram shows states transition.
[TODO figure]

## Activity diagram
Activity diagrams are graphical representations of workflows of stepwise activities and actions with support for choice, iteration and concurrency. In UML, activity diagrams are intended to model both computational and organizational processes (i.e. workflows).

There are some elements:
1. Action states
2. Transitions
3. Decisions
4. Guard conditions
5. Synchronization bar
6. Initial and final point

Example:
![Activity diagram](http://7xssst.com2.z0.glb.clouddn.com/Activity%20Diagram%20demo.png)
