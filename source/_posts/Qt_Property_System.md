title: Qt Note 3 -- Qt's Property System
date: 2015-08-01 16:57:34
categories: Technique
tags: [Qt]
---

# Preface
---
Before talking about Qt's Property System, let us think about properties. Property is a kind of data member(field) which can be written and read. We can see it as an encapsulation to data member(field). But why do we need properties? A normal field with functions get() and set(args) can also implements this target. I think the most important advantage of property is it provides class users a convenient way to access internal state of class. What's the meaning of "convenient"? For instance, if we use field and functions get() and set(args), the code would be:
{% codeblock %}
	String id1 = employee.getID();
	String id2 = new String("Lew");
	employee.setID(id2);
{% endcodeblock %}

As we can see from above, it is not a very good class. As a class user, what we want is that we can use it more naturally and easily. We do not have to know every interface about every field(data member).
So, if we have property mechanism, we can do the same work like this:
{% codeblock %}
	employee.setProperty("ID", "Lew");
{% endcodeblock %}

And if we want to read some property, we can write like this:
{% codeblock %}
	String id = employee.Property("ID"); 
{% endcodeblock %}

This mechanism provides class user a more easy and reasonable way to use the class, because what we only need to know is the properties of the class. Of cause, when we set some property, argument is the most important issue we need to care about. So, let us see how Qt's Property System handle this problem in the next part.

# Qt's Property System
---
C++ programming language has not primitive about property system. But it is very important obviously. There are some non-standard C++ compilers implemented this function, such as **_declspec(property())** from MS. In order to implements cross-platform, Qt also has its own strategy to do this, which can work with any standard C++ compiler on every platform Qt supports.

## Requirements for Declaring Properties
To declare a property, we can use **Q_PROPERTY()** macro in a class that inherits **QObject**.
{% codeblock %}
	Q_PROPERTY(type name
		(READ getFunction [WRITE setFunction] |
		MEMBER memberName [(READ getFunction | WRITE setFunction)])
		[RESET resetFunction]
		[NOTIFY notifySignal]
		[REVISION int]
		[DESIGNABLE bool]
		[SCRIPTABLE bool]
		[STORED bool]
		[USER bool]
		[CONSTANT]
		[FINAL])
{% endcodeblock %}

Here are some typical examples of property declarations taken from class QWidget.
{% codeblock %}
	Q_PROPERTY(bool focus READ hasFocus)
	Q_PROPERTY(bool enabled READ isEnabled WRITE setEnabled)
	Q_PROPERTY(QCursor cursor READ cursor WRITE setCursor RESET unsetCursor)
{% endcodeblock %}

Here is an example showing how to export member variables as Qt properties using the MEMBER keyword. Note that a NOTIFY signal must be specified to allow QML property bindings.
{% codeblock %}
		Q_PROPERTY(QColor color MEMBER m_color NOTIFY colorChanged)
		Q_PROPERTY(qreal spacing MEMBER m_spacing NOTIFY spacingChanged)
		Q_PROPERTY(QString text MEMBER m_text NOTIFY textChanged)
		...
	signals:
		void colorChanged();
		void spacingChanged();
		void textChanged(const QString &newText);
	private:
		QColor  m_color;
		qreal   m_spacing;
		QString m_text;
{% endcodeblock %}

**A property behaves like a class data member, but it has additional features accessible through the Meta-Object System.**

What's we need to know is, the property type can be any type supported by **QVariant**, or it can be user-defiend type.

## Reading and Writing Properties with the Meta-Object System
We can call QObject::property() and QObject::setProperty() to read or write a property, **without knowing anything about the owning class except the property's name.** For instance:
{% codeblock %}
	QPushButton *button = new QPushButton;
	QObject *object = button;
	
	button->setDown(true);
	object->setProperty("down", true);
{% endcodeblock %}

Accessing properties by name lets you access classes you don't know about at compile time. You can discover a class's properties at run time by querying its QObject, QMetaObject, and QMetaProperties. We can use metaobject to access all the properties an object has. We can write code like following:
{% codeblock %}
	Object* object = ...;
	const QMetaObject metaobject = object->metaObject();
	int count = metaobject()->propertyCount();
	for(int i = 0; i < count; i++){
		QMetaProperty mp = metaobject->property(i);
		const char* name = mp.name();
		QVariant value = object->property(name);
		qDebug() << name << "   " << value << endl;
	}
{% endcodeblock %}

## A Simple Example
Suppose we have a class MyClass, which is derived from QObject and which uses the Q_OBJECT macro in its private section. We want to declare a property in MyClass to keep track of a priority value. The name of the property will be priority, and its type will be an enumeration type named Priority, which is defined in MyClass.

We declare the property with the Q_PROPERTY() macro in the private section of the class. The required READ function is named priority, and we include a WRITE function named setPriority. The enumeration type must be registered with the Meta-Object System using the Q_ENUMS() macro. Registering an enumeration type makes the enumerator names available for use in calls to QObject::setProperty(). We must also provide our own declarations for the READ and WRITE functions. The declaration of MyClass then might look like this:
{% codeblock %}
    	class MyClass : public QObject
    	{
    		Q_OBJECT
    		Q_PROPERTY(Priority priority READ priority WRITE setPriority NOTIFY 	priorityChanged)
	    	Q_ENUMS(Priority)
	    	
	public:
	    	MyClass(QObject *parent = 0);
	    	~MyClass();
	    	
	    	enum Priority { High, Low, VeryHigh, VeryLow };
	    	
	    	void setPriority(Priority priority)
	    	{
	    		m_priority = priority;
	    		emit priorityChanged(priority);
	    	}
	    	Priority priority() const
	    	{ return m_priority; }
	    	
	signals:
	    	void priorityChanged(Priority);
	    	
	private:
	    	Priority m_priority;
    	};
{% endcodeblock %}

**The READ function is const and returns the property type. The WRITE function returns void and has exactly one parameter of the property type. The meta-object compiler enforces these requirements.**
we have two ways to set its priority property:
{% codeblock %}
	MyClass *myinstance = new MyClass;
	QObject *object = myinstance;
	
	myinstance->setPriority(MyClass::VeryHigh);
	object->setProperty("priority", "VeryHigh");
{% endcodeblock %}

## Properties and Custom Types
Custom types used by properties need to be registered using the **Q_DECLARE_METATYPE()** macro so that their values can be stored in QVariant objects. This makes them suitable for use with both static properties declared using the Q_PROPERTY() macro in class definitions and dynamic properties created at run-time. For instance:
{% codeblock %}
	struct MyType{
		int i;
		...
	};
	
	Q_DECLARE_METATYPE(MyType)
{% endcodeblock %}

## Adding Additional Information to a Class
Connected to the property system is an additional macro, Q_CLASSINFO(), that can be used to attach additional name--value pairs to a class's meta-object, for example:
{% codeblock %}
	class MyClass : public QObject
	{
		Q_OBJECT
		Q_CLASSINFO("Author", "Pierre Gendron")
		Q_CLASSINFO("URL", "http://www.my-organization.qc.ca")
		
		public:
		...
	};
{% endcodeblock %}
{% codeblock %}
	class Test::public QObject{
		Q_OBJECT
		Q_CLASSINFO("property", "system")
		Test();
	}
{% endcodeblock %}

Then, in the main.cpp:
{% codeblock %}
	int main(int argc, char* argv[])
	{
		OBJTest* w = new OBJTest;
		int i = w->metaObject()->classInfoCount();
		qDebug() << i << endl;
		return 0;
	}
{% endcodeblock %}
Through this, we can get the class information.
