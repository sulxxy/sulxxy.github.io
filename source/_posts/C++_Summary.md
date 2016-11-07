title: C++ Summary
date: 2016-01-26 10:09:29 
categories: Study Notes
tags: [C++]
---

# PART I: Built-in types and basic facilities
---
## Built-in types
1. Fundamental types: 
	* in teger: int, long, short
	* floating point
	* characters
	* void: cannot have an object
	* boolean
<!-- more -->

2. a user can define: Enumeration
	* range: (0, 2^n - 1), e.g. 
	{% codeblock %}	
		enum ae = {a = 1, b = 9}; // range from 0 to 15
	{% endcodeblock %}	
	* example:
	{% codeblock %}	
		enum SAMP{X, Y, Z};
		SAMP t1 = X;
 		SAMP t2 = Y;
	{% endcodeblock %}	

3. Other types 
	* structure
	{% codeblock %}	
		typedef struct{
		       int x;
		       char c;
		}T, \*TN;
		T a;
		TN pa = &a;
	{% endcodeblock %}	
	* class
	{% codeblock %}	
		class A{
		private:
		           int a;
		public:
		          A(int);
		          double trans(int); 
		};
	{% endcodeblock %}	
	* pointer
	* array
	* reference: a reference is an alternative name for an object
	{% codeblock %}	
		int i = 0;
		int& j = i;
		j++; // i++
	{% endcodeblock %}	

## Basic facilities:
1. Namespace
A namespace is a logical entity. We can put some related parts into a namespace. It is similar with the concept of packages. Namespace can be reopened at anytime and everywhere. For example:
{% codeblock %}
//file a
Namespace T{
	void print();
	class XT{
		//...
	};
}
// file b
void T::print(){
	//...
}
{% endcodeblock %}
2. Exception
	* Example
	{% codeblock %}
	// Definition
	double div(double a, double b){
		if(0 == b){
			throw(0);
		}
		return a/b;
	}
	// Call
	try{
		double a = 5;
		double b = 0;
	} catch(double e){
		cout << e << endl; // 0
	}
	{% endcodeblock %}
	* User-Defined exception class
	{% codeblock %}
	// Exception definition
	class My_Exception{
	public:
		void read_property();
		My_Exception(int);
	private:
		int n;
	};
	// Function Definition
	void testfun(int y) throw (My_Exception){
		//...
		throw My_Exection(2);
	}
	// Call
	try{
		testfun();
	}catch(My_Exection e){
		e.read_property();
	}
	{% endcodeblock %}


# PART II: Object-oriented programming
---
## Classes
1. Class Basics
	* A class is a user-defined type.
		{% codeblock %}	
		class Demo{
		public:
			Demo(int);
			Demo();
			void Sample_Member_Function(char);
		private:
			int ma;
			char mc;
		};
		Demo::Demo(int i){
			ma = i;
			mc = '';
		}
		void Demo::Sample_Member_Function(char c){
			//...
			return;
		}
		{% endcodeblock %}	
	* The <b>public</b> members provides the class's interfaces and the <b>private</b> members provides implementation details.
	* <b>class</b> and <b>struct</b>
		{% codeblock %}
		struct{ /*...*/};
		{% endcodeblock %}
		is the same as:
		{% codeblock %}
		class { public: /*...*/};
		{% endcodeblock %}
		I tend to use <b>struct</b> for classes that I think of as "just simple data structures". If I think of a class as "a proper type with an invariant", I use <b>class</b>. 
2. Data members & member functions
3. Constructors
	Declare explicit purposes of initializing objects.
4. Static
	A <b>static</b> class member is statically allocated rather than a part of each object of the class. Generally, the <b>static</b> member declaration acts as a declaration for a definition outside the class.
	{% codeblock %}	
	class S_Samp{
	private:
		int ma;
		static char mc;        //declaration
	public:
		/*...*/
	};
	char S_Samp::mc = '';          //definition
	{% endcodeblock %}	
5. Access control
6. Default arguments
7. Self-reference: this
	<b>*this</b> refers to the object for which a member function is invoked.
8. Constant member function

## Operating overloading
## Derived class

# PART III: Generic Programming
---
## Template
Templates provide direct support for generic programming, that is, programming using types as parameters. The C++ template mechanism allows a type to be a parameter in the definition of a class or a function.
[TODO]
