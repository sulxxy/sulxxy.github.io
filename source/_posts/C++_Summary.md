title: C++ Summary
date: 2016-01-26 10:09:29 
tags: [C++, Summary]
---

# PART I: Built-in types and basic facilities
## Built-in types:
### Fundamental types: 
* in teger: int, long, short
* floating point
* characters
* void: cannot have an object
* boolean

### a user can define: Enumeration
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

### Other types: 
* structure
	{% codeblock %}	
		typedef struct{
		       int x;
		       char c;
		}T, *TN;
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
### Namespace

### Exception

# PART II: Object-oriented and generic programming
## Classes
* C lass Basics
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
		
			struct{ /*...*/};
		is the same as:
		
			class{public: /*...*/};
		I tend to use <b>struct</b> for classes that I think of as "just simple data structures". If I think of a class as "a proper type with an invariant", I use <b>class</b>. 

* Data members & member functions
* Constructors
	
	Declare explicit purposes of initializing objects.
* Static
	
	A <b>static</b> class member is statically allocated rather than a part of each object of the class. Generally, the <b>static</b> member declaration acts as a declaration for a definition outside the class.
	{% codeblock %}	
		class S_Samp{
		private:
			int ma;
			static char mc;                                          //declaration
		public:
			/*...*/
		};
		char S_Samp::mc = '';                                                //definition
	{% endcodeblock %}	
	
* Access control
* Default arguments
* Self-reference: this
	
	<b>*this</b> refers to the object for which a member function is invoked.
* constant member function

## Operating overloading
## Derived class
## Template
