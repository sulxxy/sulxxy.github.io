title: Introduction to Software Engineering
date: 2016-04-10 16:06:45
tags: [Summary]
---

# Description
---
In this course, students are asked to understand the fundamental principles and concepts of software engineering, such as generic process models, software requirement, software design, software testing.

# Generic Process Models
---
## The Meaning of Process Model
When we provide a service or create a product, we always follow a sequence of steps to accomplish a set of tasks. The tasks are always performed in the same order each time. We can think of a set of ordered tasks as a **process**. A **process model** is an abstract representation of a process from some particular perspective as:
1. Specification
2. Design
3. Validation
4. Evolution

## Water Fall
This is a traditional development strategy. It is stage-oriented and linear. In waterfall, the stages are depicted as cascading from one to another. One development stage should be completed before the next begins. 
1. **Model diagram**
[TODO Figure]
2. **Pros**
	- Easy to understand and implement
	- Reinforce good habits: define before design, design before code
	- Works well on mature products
3. **Cons**
	- Difficult and expensive to make changes, inflexible 
	- Unrealistic to expect accurate requirement so early in the project
4. **Summary**
In conclusion, the waterfall model performs well for products with clear requirements, mature software architecture and development tools. When rapid development is needed, the waterfall model is not advisable. 

## V-shaped Model
The **V model** is a variation of the waterfall model that demonstrates how the testing activities are related to analysis and design.
1. **Model diagram**
[TODO Figure]
2. **Pros**
	- Simple and easy to use
	- Each has a specific deliveries
	- Higher chance of success over waterfall model
3. **Cons**
	- Very rigid like waterfall
	- Little flexibility

## Increments and Iterations
The system is designed so that it can be delivered in pieces, enabling the users to have some functionality while the rest is being developed. Thus, there are 2 systems functioning in parallels: the **production system** and the **development system**. 

There are many ways for the developers to decide how to organize development into releases. The two most popular approaches are **incremental development** and **iterative development**. In incremental development, the releases are defined by beginning with one small, functional **subsystem** and then adding functionality with each new release. However, iterative development delivers a full system at the very beginnings and then changes the functionality of each subsystem with each new release.
1. **Model diagrams**
2. **Pros**
	- Frequent releases allow developers to fix unanticipated problems globally and quickly
	- The development team can focus on different areas of expertise with different releases. For instance, one release can change the system from a command-driven one to GUI; another release can focus on improving system performance.

## Spiral Model
The spiral model is similar to the incremental model, with more emphases placed on risk analysis. The spiral model has four phases: Planning, Risk Analysis, Engineering and Evaluation. A software project repeatedly passes through these phases in iterations (called Spirals in this model). The baseline spiral, starting in the planning phase, requirements are gathered and risk is assessed. Each subsequent spiral builds on the baseline spiral. Requirements are gathered during the planning phase. In the risk analysis phase, a process is undertaken to identify risk and alternate solutions. A prototype is produced at the end of the risk analysis phase. Software is produced in the engineering phase, along with testing at the end of the phase. The evaluation phase allows the customer to evaluate the output of the project to date before the project continues to the next spiral.
1. **Model diagram**
[TODO Figure]
2. **Pros**
	- High amount of risk analysis
	- Software is produced very early
3. **Cons**
	- Can be a costly model to use
	- Project's success is highly dependent on risk analysis

# Software Requirement
---
A **requirement** is an expression of desired behavior.
## Requirement Process
[TODO P144]
We first work with our customers to elicit the requirements by asking questions, examining current behavior, or demonstrating similar systems. Next, we capture the requirements in a model or a prototype. This exercise helps us to better understand the required behavior. Once the requirements are well understood, we progress to the specification phase, in which we decide which parts of the required behavior will be implemented in software. During the validation, we check that our specification that cause us to revisit the customer and revise our models and specification. The eventual outcome of the requirements process is a **Software Requirements Specification(SRS)**, which is used to communicate to other software developers how the final product ought to behave.

## Requirements Elicitation
This process mainly collects the user's requirements. 
Formal questions should include several aspects, such as **functional requirement**, **quality requirement**, **design constraint**, **process constraint**.
1. What features and functions do you want? How will you use this functions?
2. Are there constraints on execution speed?
3. Who will use this system?
4. How much documentation is needed?
5. Are there constraints on the programming language because of existing software components?

## Analysis
This process involves understanding and modeling the desired behavior. There are some typical modeling notations:
1. Entity-Relationship diagrams
[TODO diagram]
	- An **entity**, depicted as a rectangle, represents a collection of real-world objects that have common properties and behaviors.
	- An **attribute** is an annotation on an entity that describes data or properties associated with the entity.
	- A **relationship** is depicted as an edge between two entities, with a diamond in the middle of the edge specifying the type of relationship.
	- ER diagrams are popular because:
	 	- They provide an overview of the program 
	 	- This view is relatively stable when changes are made to the problem's requirements. A change in requirements is more likely to be a change in how one or more entities behave than to be a change in the set of participating entities. 
2. Data-Flow diagrams
[TODO Figure]
A **data-flow diagram(DFD)** models functionality and the flow of data from one function to another.
	- A bubble represents a **process** that transforms data.
	- An arrow represents **data flow**, where an arrow into a bubble represents one of the function's outputs.
	- Data sources, represented by rectangles, are **actors**: entities that provide input data or receive the output results.

## Specification 
This process mainly involves documenting the behavior of the proposed software system.

## Prototyping Eequirements
Sometimes, our customers are uncertain of exactly what they want or need. As such, one way that we can elicit details is to build a prototype of the proposed system and to solicit feedback from potential users about what aspects they would like to see improved, which features are not so useful, or what functionality is missing. 

There are two approaches to prototyping: throwaway and evolutionary.
1. A **throwaway prototype** is software that is developed to learn more about a problem or about a proposed solution, and that is never intended to be part of the delivered software. 
2. An **evolutionary prototype** is software that is developed not only to help us answer questions but also to be incorporated into the final product. As such, we have to be much more careful in its development, because this software has to eventually exhibit the quality requirement of final product, and these qualities cannot be retrofitted.

## Validation
This process involves checking that our specification matches the user's requirements. In **requirement validaiton**, we check that our requirements definition accurately reflects the customer's need. In **verification**, we check that one document or artifact conforms to another. Verification ensures that we build the system right, whereas validation ensures that we build the right system.

# Software Design
---
[Software Architecture](http://liuzhiwei.me/Software_Architecture/)

# Software Testing
---
[TODO P408]
1. Unit testing
	- Examining the code
	- Proving code correct
	- Testing program components
2. Integration testing
	- Bottom-Up integration
	- Top-Down integration
		**Stub**: A special-purpose program to simlate the activity of the missing component.
3. Function testing
From now on, our approach is more closed box than open. We need not know which component is being executed; rather, we must know what the system is supposed to do.
4. Performance testing
System performance is measured against the performance objectives set by the customer as expressed in the nonfunctional requirements. 
	- Stress tests
	- Security tests
	- Volume tests
5. Acceptance testing
6. Installation testing
