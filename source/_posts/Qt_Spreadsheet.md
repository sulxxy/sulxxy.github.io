title: Qt Note 1 -- Spreadsheet
date: 2015-07-31 09:00:00
tags: [Qt]
---

# Reference：

C++ GUI Programming with Qt4 Chapter 02 ~ Chapter 05.

# Artifact:
---
A Spreadsheet program based on QMainwindow, implements a basic sheet application.
The running screenshot:
![SpreadSheet](/img/SpreadSheet.jpg)

# Function
---

# Important issues:
---
1. Subclassing QMainWindow
{% codeblock %}	
	class MainWindow: public QMainWindow{
		Q_OBJECT
		...
	}
{% endcodeblock %}	

We can declare neccessary slots, signals, methods and variable here. About slots and signals, I have noted in another post [Qt Note 1 -- Signals and Slots](http://sulxxy.github.io/2015/07/31/Qt_Slot_and_Signal/).

2. Create Menus and Toolbars
This part has following core methods: 
{% codeblock %}	
	QMenu QMainWindow::menuBar(); //get the menu bar for the main window
	QAction* QMenu::addAction(); // add an action to the menu
{% endcodeblock %}	

About actions, we can use connect() method to connect the action with a specific slot when sending some signal.

Another import method here is the **setContextMenuPolicy**. We can create a context menu by using following code:
{% codeblock %}	
	void Mainwindow::createContextMenu(){
		spreadsheet->addAction(Act1);
		spreadsheet->addAction(Act2);
		spreadsheet->addAction(Act3);
		spreadsheet->setContextMenuPolicy(Qt::ActionsContextMenu);
	}
{% endcodeblock %}	
Above codes provide a context menu. When we clicked the right key of mouse, there're would be a menu frame(in this demo, the menu frame is Act1, Act2, Act3).
The toolbar is almost the same as the menubar. The only difference is to replace menuBar() with **addToolBar()**. 

3. Create Status Bar
We use **statusBar()** to get the status bar for the main window. After that, we can use **addWidget()** to add our own widgets to the status bar(In menubar and toolbar, what we used is **addAction()**). Because it is a status bar, we need to define updateStatus() to keep the status bar latest status.

**To be continued...**
