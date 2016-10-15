title: Database
date: 2016-04-27 20:39:23
categories: Study Notes
tags: [Database]
---

# Description
---
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
Database is a kernal software of computer systems. The content of this course includes relational models, SQL, transactions and database design.

# Relational Models
---
## Relational Database
Relational database consists of a collection of **table**, each of which is assigned a unique name. A row in a table represents a *relationship* among a set of values.

## Keys
We must have a way to specify how tuples within a given relation are distinguished. This is expressed in terms of their attributes. That is, the values of the attributes of a tuple must be such that they can *uniquely identify* the tuple. In other words, no two tuples in a relation are allowed to have exactly the same value for all attributes.

A **superkey** is a set of one or more attributes that allow us to identify uniquely a tuple in the relation. The minimal superkeys whose subsets are not superkeys are called **candidate keys**.

We shall use the term **primary key** to denote a candidate key that is chosen by the database designer as the principal means of identifying tuples within a relation.

## Relational-Algebra Operations
1. The select operation
The **select** operation selects tuples that satisfy a given predicate.
2. The project operation
The **project** operation is a unary operation that returns its argument relation, with certain attributes left out.
3. The union operation
4. The set-difference operation
5. The Cartesian-product operation
The **Cartesian-product** operation, denoted by a cross, allows us to combine information from any two relations. We write the Cartesian product of relations r1 and r2 as r1 \* r2. [TODO MathType]
6. The rename operation
[TODO]
7. The set-intersection operation
8. The natural-join operation
9. The division operation
[TODO]
10. Generalized projection
[TODO]
11. Aggregate functions
12. Outer join
[TODO]

# SQL
---
## Basic SQL
## Integrity Constraints

# Transactions
---
## Transaction Concept
A **transaction** is a **unit** of program execution that accesses and possibly updates various data items.

To ensure integrity of the data, we require that the database system maintain the following properties of the transactions:
1. **Atomicity**. Either all operations of the transaction are reflected properly in the database, or none are.
2. **Consistency**. Execution of a transaction in isolation (that is, with no other transaction executing concurrently) preserves the consistency of the database.
3. **Isolation**. Even though multiple transactions may execute concurrently, the system guarantees that, for every pair of transactions Ti and Tj, it appears to Ti that either Tj finished execution before Ti started or Tj started execution after Ti finished. Thus, each transaction is unaware of other transactions executing concurrently in the system.
4. **Durability**. After a transaction completes successfully, the changes it has made to the database persist, even if there are system failures.

These properties are often called the **ACID properties**.

## A Simple Transaction Model
Let Ti be a transaction that transfers \$50 from account A to account B. This transaction can be defined as:
{% codeblock %}
Ti: read(A);
    A := A - 50;
    write(A);
    read(B);
    B := B + 50;
    write(B);
{% endcodeblock %}

Let us now consider each of the ACID properties.
1. Consistency: The consistency requirement here is that the sum of A and B be unchanged by the execution of the transaction.
2. Atomicity: Suppose that, just before the execution of transaction Ti, the values of accounts A and B are \$1000 and \$2000, respectively. Now suppose that, during the execution of transaction Ti, a failure occurs that prevents Ti from completing its execution successfully. Further, suppose that the failure happened after the write(A) operation but before the write(B) operation. In this case, the values of accounts A and B reflected in the database are \$950 and \$2000. The system destroyed \$50 as a result of this failure.
3. Durability: Once the execution of the transaction completes successfully, and th user who initiated the transaction has been notified that the transfer of funds has taken place, it must be the case that no system failure will result in a loss of data corresponding to this transfer of funds. The durability property guarantees that, once a transaction completes successfully, all the updates that it carried Out on the database persist, even if there is a system failure after the transaction completes execution.
4. As we saw earlier, the database is temporarily inconsistent while the transaction to transfer funds from A to B is executing, with the deducted total written to A and the increased total yet to be written to B. If a second concurrently running transaction reads A and B at this intermediate point and computes A + B, it will observe an inconsistent value. A way to avoid the problem of concurrently executing transactions is to execute transactions serially.

## Transaction State
A transaction must be in one of the following states:
1. **Active**, the initial state; the transaction stays in this state while it is executing
2. **Partially committed**, after the final statement has been executed
3. **Failed**, after the discovery that normal execution can no longer proceed
4. **Aborted**, after the transaction has been rolled back and the database has restored to its state prior to the start of the transactions
5. **Committed**, after successful completion

## Implementation of Atomicity and Durability
A simple but extremely inefficient way is **shadow copy**.

In the shadow-copy scheme, a transaction that wants to update the database first creates a complete copy of the database. All updates are done on the new database copy, leaving the original copy, the **shadow cop**, untouched, If at any point the transaction has to be aborted, the system merely deletes the new copy. The old copy of the database has bot been affected. 

## Concurrent Execution
Transaction processing systems usually allow multiple transactions to run concurrently. There are two good reasons for allowing concurrency:
1. Improved throughput and resource utilization. The CPU and the disks in a computer system can operate in parallel. Therefore, I/O activity can be done in parallel with processing at the CPU. The parallelism of the CPU and the I/O system can therefore be exploited to run multiple transactions in parallel.
2. Reduced waiting time. There may be a mix of transactions running on a system, some short and some long. If transactions run serially, a short transaction may have to wait for a preceding long transaction to complete. Concurrent execution reduces the unpredictable delays in running transactions. Moreover, it also reduces the **average response time**: the average time for a transaction to be completed after it has been submitted.

We should ensure consistency of the database under concurrent execution by making sure that any schedule that is executed has the same effect as a schedule that could have occurred without any concurrent execution. That is, the schedule should, in some sense, be equivalent to a serial schedule. We call this serializability.

## Serializability
We must understand how to determine, given a particular schedule S, whether the schedule is serializable. 

Consider a schedule S. We construct a directed graph, called a **precedence graph**, from S. This graph consists of a pair G = (V, E), where V is a set of vertices and E is a set of edges. The set of vertices consists of all the transactions  participating in the schedule. The set of edges consists of all edges Ti -> Tj for which one of three conditions holds:
1. Ti executes write(Q) before Tj executes read(Q)
2. Ti executes write(Q) before Tj executes write(Q)
3. Ti executes read(Q) before Tj executes write(Q)

If the precedence graph for S has a cycle, then schedule S is not conflict serializable. If the graph contains no cycles, then the schedule S is conflict serializable.

# Database Design
---
## The E-R Model
The **entity-relationship(E-R)** data model was developed to facilitate database design by allowing specification of an *enterprise schema* that represents the overall logical structure of a database. The E-R data model employs three basic notions: entity sets, relationship sets, and attributes.
1. Entity Sets
	An **entity** is a "thing" or "object" in the real world that is distinguishable from all other objects. For example, each person in an enterprise is an entity. An entity has a set of properties, and the values for some set of properties may uniquely identify an entity. For instance, a person may have a *person_id* property whose value uniquely identifies that person.
	An **entity set** is a set of entities of the same type that share the same properties. For example, the set of all persons who are customers at a given bank can be defined as the entity set *customer*. 
2. Relationship Sets
	A **relationship** is an association among several entities. For example, we can define a relationship that associates customer CA with loan LA. This relationship specifies that CA is a customer with loan number LA.
	A **relationship set** is a set of relationships of the same type. Formally, it is a mathematical relation on \\(n\ge2\\)(possibly nondistinct) entity sets. 
	TODO MathType
	The association between entity sets is referred to as  participation; tht is, the entity set E1, E2, E3,..., En **participate** in relationship set R. TODO: student_id, course_id->participate taking_course
3. Attributes
	For each attribute, there is a set of permitted values, called the **domain** of that attribute. For example, the domain of attribute scores in the records might be the set of all numbers ranging from 0 to 100.
	An attribute, as used in the E-R model, can be characterized by the following attribute types.
	- **Simple** and **composite** attributes. For instance, *student_id* is a simple attribute which cannot be divided into subparts. **Composite** attribute,s, on the other hands, can be divided into subparts. For example, an attribute *name* could be structured as a composite attribute consisting of *first_name*, *middle_initial* and *last_name*. 
	- **Single-valued** and **multivalued** attributes. Single-value attributes have a single value for a particular entity. For example, a student can only have one *student_id*. There may be instances where an attribute has a set of values for a specific entity. For example, a student may have zero, one, or several phone numbers.
	- **Derived** attribute. The value for this type of attribute can be derived from the values of other related attributes or entities. For example, *student* entity set has an attribute *age* that indicates the student's age. If the *student* entity set also has an attribute *date_of_birth*, we can calculate *age* from *date_of_birth* and the current date.

## Relational Database Design
1. Function Dependency
If there were a schema(A, B), then A is able to serve as the primary key. This rule is sepcified as a **functional dependency**. TODO MathJax: A -> B
2. Boyce-Codd Normal Form
