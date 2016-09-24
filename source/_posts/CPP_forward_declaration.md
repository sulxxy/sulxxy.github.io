title: C++'s forward declaration
date: 2015-08-10 20:03:45
categories: Technique
tags: [C++]
---

## Problem description
The problem goes like this: I wrote 3 classes in different files A.h, B.h, C.h. A.h includes B.h and B.h includes C.h. For some specific requirement, I need use class A in C.h. What I did first was to include A.h in C.h. But fatally, the compiler gave errors like below:
{% codeblock %}	
E:\Projects\Qt\QQServer\serversocket.h:33: error: C2143: 语法错误 : 缺少“;”(在“*”的前面)
E:\Projects\Qt\QQServer\serversocket.h:33: error: C4430: 缺少类型说明符 - 假定为 int。注意:  C++ 不支持默认 int
{% endcodeblock %}	
## The reason of this problem
Obviously, it is a problem due to header files' including each other.
A simple example:
{% codeblock %}		
//testA.h
#ifndef _TESTA_H_
#define _TESTA_H_
#include "testB.h"
class A{
	B* m_b;
};
#endif
{% endcodeblock %}
{% codeblock %}
//testB.h
#ifndef _TESTB_H_
#define _TESTB_H_
#include "testA.h"
class B{
	A* m_a;
};
#endif
{% endcodeblock %}
Let's start from file testA.h. 
First of all, the macro \_TESTA\_H_ will be defined because it is the first time to enter testA.h. Then the compiler will enter testB.h because testB.h is included by testA.h. After entered testB.h, the macro \_TESTB\_H_ will be defined. Then the compiler will enter testA.h because the same reason. But now \_TESTA\_H_ has been defined. So the block of class A cannot be entered. So the declaration of A in testB.h is undefined from the point of class testB. So the problem occurs.

## Solution
To avoid this problem, we can use C++'s forward declaration. That is, we use statement **class testA;** instead of **including "testA.h"**. The forward declaration **just** tells compilers that *testA* is a class. This is highly recommanded. There are following reasons:
1. More effictive compiling. When testA.h changed, testB.h will also be recompiled if we use **include** statement. But it will be unneccessary if we use forward declaration.
2. Loose coupling.

## When can we use forward declaration
**We should use the forward declaration as far as possible. ** However, there are two restrictions: 
1. You can only **declare** variable. If you need to call some function of the declared class, you must include its header file. To avoid my above prolem, we can use forward in header file, and use include statement in cpp file.
2. You can only use **object pointer** to the declared class. This is easy to understand. When use a object, the compiler must know its size, which must include its header file. But the pointer is always 4 bytes, compilers do not have to know the object's size.
