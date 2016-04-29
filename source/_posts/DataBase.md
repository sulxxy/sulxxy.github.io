title: Database
date: 2016-04-27 20:39:23
tags: [Summary]
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
2. The project operation
3. The union operation
4. The set-difference operation
5. The Cartesian-product operation
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
	[TODO MathType]
	The association between entity sets is referred to as  participation; tht is, the entity set E1, E2, E3,..., En **participate** in relationship set R. [TODO: student_id, course_id->participate taking_course]
3. Attributes
	For each attribute, there is a set of permitted values, called the **domain** of that attribute. For eample, the domain of attribute scores in the records might be the set of all numbers ranging from 0 to 100.
	An attribute, as used in the E-R model, can be characterized by the following attribute types.
		- **Simple** and **composite** attributes. For instance, *student_id* is a simple attribute which cannot be divided into subparts. **Composite** attribute,s, on the other hands, can be divided into subparts. For example, an attribute *name* could be structured as a composite attribute consisting of *first_Oname*, *middle_initial* and *last_name*. 
		- **Single-valued** and **multivalued** attributes. Single-value attributes have a single value for a particular entity. For example, a student can only have one *student_id*. There may be instances where an attribute has a set of values for a specific entity. For example, a student may have zero, one, or several phone numbers.
		- **Derived** attribute. The value for this type of attribute can be derived from the values of other related attributes or entities. For example, *student* entity set has an attribute *age* that indicates the student's age. If the *student* entity set also has an attribute *date_of_birth*, we can caculate *age* from *date_of_birth* and the current date.

## Relational Database Design
