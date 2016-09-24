title: Iterator and Generator in Python
date: 2016-08-25 10:05:12
categories: Study Notes
tags: [Python]
---

# Iterator
## What is iterator?
An <b>iterator</b> is an object which can be used to traverse a container(e.g., set, list) without concerning how the elements are stored inside containers. For example:
{% codeblock %}
la = [2, 3, 4]
for element in la:
	print element
{% endcodeblock %}
The output will be:
{% codeblock %}
2
3
4
{% endcodeblock %}
## Iterable and iterator in Python
Actually, the upper code block can be also written like following:
{% codeblock %}
la = [2, 3, 4]
la_it = iter(la)
try:
	while True:
		print la_it.next()
except StopIteration:
	pass
{% endcodeblock %}
Here we used <b>iter(iterable)</b> to get an iterator object from an iterable object. An <b>iterable</b> object is the object which has implemented <b>__iter__()</b> method. An <b>iterator</b> is the object which has implemented <b>next()</b> method.

Now, we can implement an iterator. Let's take Fibonacci as an example.
{% codeblock %}
class Fibs:
	def __init__(self):
		self.a = 0
		self.b = 1
	def __iter__(self):
		return self
	def next(self):
		self.a, self.b = self.b, self.a + self.b
		return self.a

fib = Fibs()
for element in fib:
	if element > 1000:
		print element
		break
{% endcodeblock %}
Now we can get the value of 1000th element in Fabonacci sequence.
## Get list from iterator
If we want to get a list which contains first *n* elements of Fibonacci sequence, we can modify the class Fibs():
{% codeblock %}
class Fibs:
	value = 0
	def __init__(self, n):
		self.max = n	
		self.a = 0
		self.b = 1
	def __iter__(self):
		return self
	def next(self):
		self.value += 1
		if self.value > self.max: raise StopIteration
		self.a, self.b = self.b, self.a + self.b
		return self.a
{% endcodeblock %}
And then, we use the constructor <b>list()</b> to cast iterator to list.
{% codeblock %}
fib = Fibs(10)
list_fib = list(fib)
{% endcodeblock %}
Now, we created a list which contains the first 10 elements of the Fibonacci sequence.
# Generators
A generator is a kind of iterator which is defined by function grammar and contains keyword **yield**. When a generator is called, it will return a iterator instead of running. Everytime a value is requested, the code in the generator will be excuted until encoutering **yield** statement. A **yield** statement means a value should be yielded.
## Create generators
For example, we want to traverse a 2-dimension list la:

	la = [[1,2],[3,4],[5]] 
function **traverse()**:
{% codeblock %}
def traverse(la):
	for sublist in la:
		for element in sublist:
			yield element
{% endcodeblock %}
Now, traverse() is the generator(a kind of iterator). If we want to get all of the elements in la:
{% codeblock %}
la = [[1,2],[3,4],[5]]
for ele in traverse(la):
	print ele
{% endcodeblock %}
The output is:
{% codeblock %}
1
2
3
4
5
{% endcodeblock %}
Of course, since traverse() is a kind of iterator, we can use the constructor **list()** to cast iterator to list:
{% codeblock %}
la_list = list(traverse(la))
{% endcodeblock %}
