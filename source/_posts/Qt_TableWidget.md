title: QTableWidget的美化
date: 2014-09-13 14:03:43
categories: Technique
tags: [Qt]
---

> 迁移自我的博客：[QTableWidget的美化](http://blog.csdn.net/sulxxy/article/details/39250299)

# 一些基本设置：
---
{% codeblock %}
    FriendTable->setFrameShape(QFrame::NoFrame);  //设置边框
    FriendTable->setHorizontalHeaderLabels(HeadList);  设置表头
    FriendTable->setSelectionMode(QAbstractItemView::SingleSelection);   设置选择的模式为单选择
    FriendTable->setSelectionBehavior(QAbstractItemView::SelectRows);设置选择行为时每次选择一行
    FriendTable->setShowGrid(false);   设置不显示格子线
    FriendTable->setFont(font);   设置字体
{% endcodeblock %}
<!-- more -->

# 设置表单背景或透明:
---
{% codeblock %}
    QPalette pal = musicTable->palette();
    pal.setBrush(this->backgroundRole(),QBrush(QPixmap("images/background.png")) );
    musicTable->setPalette( pal );
{% endcodeblock %}

# 设置它的背景图片，也可以将QBrush初始化为QColor来设置背景颜色
---
{% codeblock %}
    QPalette pll = musicTable->palette();
    pll.setBrush(QPalette::Base,QBrush(QColor(255,255,255,0)));
    musicTable->setPalette(pll);  //和QTextEdit一样，都可以使用样式表QPalette来修改它的背景颜色和背景图片，
									//这里我们把刷子设置为全透明的，就可以是透明的
{% endcodeblock %}

# 在QTableWidget列表中添加图片的方法:
---
{% codeblock %}
    QTableWidgetItem* cubesHeaderItem = new QTableWidgetItem(tr("Cubes"));
    cubesHeaderItem->setIcon(QIcon(QPixmap("1.png")));
    cubesHeaderItem->setTextAlignment(Qt::AlignVCenter);
     musicTable->setItem(1,1,cubesHeaderItem);   //在第一行第一列中显示图片
    /*******************表头的属性修改****************/
    musicTable->horizontalHeader()->resizeSection(0,150);  //修改表头第一列的宽度为150
    musicTable->horizontalHeader()->setFixedHeight(25);  //修改表头合适的高度
    musicTable->horizontalHeader()->setStyleSheet("QHeaderView::section {background-color:lightblue;color: black;padding-left: 4px;border: 1px solid #6c6c6c;}");//设置表头字体，颜色，模式
    FriendTable->verticalHeader()->setStyleSheet("QHeaderView::section {  background-color:skyblue;color: black;padding-left: 4px;border: 1px solid #6c6c6c}");   //设置纵列的边框项的字体颜色模式等
{% endcodeblock %}
本来想找找QT里有没有现成的API的，结果没有找到，只能自己写了。
实现也好实现，QTableWidgetItem里面有修改背景色的API，直接调用，然后用循环控制隔行换色即可。
实现代码：
{% codeblock %}
void test::changeColor(QTableWidget* tablewidget){
	for (int i = 0;i < tablewidget->rowCount();i++)
	{
  		if (i % 2 == 0)
  		{
			for (int j = 0;j < tablewidget->columnCount();j++)
   			{
 				QTableWidgetItem *item = tablewidget->item(i,j);
 				if (item)
				{
 					const QColor color = QColor(252,222,156);
  					item->setBackgroundColor(color);
 				}
   			}
 		}
	}
}
{% endcodeblock %}

# 向表中插入一项
---
{% codeblock %}
	QTableWidgetItem *num=new QTableWidgetItem(QTableWidgetItem::Type);
   	num->setCheckState(Qt::Unchecked);   //加入复选框
    	num->setIcon(QIcon("images/fetion.png"));  //加入ICon
    	num->setText(InfoList.at(i).name);
    	num->setFont(font);
    	num->setTextColor(color);
    	num->setFlags(num->flags(), Qt::ItemIsEditable);
    	int currentRow=FriendTable->rowCount();  //插入到最后
    	FriendTable->insertRow(currentRow);
    	FriendTable->setItem(currentRow,0,num);  //插入该Item
    	FriendTable->selectRow(0);   选择第一行
{% endcodeblock %}

# 删除某一行 列
---
{% codeblock %}
	FriendTable->removeRow(row);
	FriendTable->removeColumn (column );
{% endcodeblock %}

# 信号
---
{% codeblock %}
	void cellActivated ( int row, int column )
	void cellChanged ( int row, int column )
	void cellClicked ( int row, int column )
	void cellDoubleClicked ( int row, int column )
	void cellEntered ( int row, int column )
	void cellPressed ( int row, int column )
	void currentCellChanged ( int currentRow, int currentColumn, int previousRow, int previousColumn )
	void currentItemChanged ( QTableWidgetItem* current, QTableWidgetItem * previous )  改变Item了
	void itemActivated ( QTableWidgetItem* item )
	void itemChanged ( QTableWidgetItem* item )
	void itemClicked ( QTableWidgetItem* item )
	void itemDoubleClicked ( QTableWidgetItem* item )
	void itemEntered ( QTableWidgetItem* item )
	void itemPressed ( QTableWidgetItem* item )
	void itemSelectionChanged ()
{% endcodeblock %}

# QT QTableWidget中去掉默认自带的行号 
---
使用QToolBox自动拖出来的QTableWidget控件中是自带行号的，有时候需要去掉，去年在做到这个地方的时候没有找到，今天找到了相关的方法，特记录下来。
![QtTable1](/img/QtTable1.jpg)
如上，刚开始的时候左边默认自带序列号。
![QtTable2](/img/QtTable2.jpg)
{% codeblock %}
    QHeaderView* headerView = table的名字->verticalHeader();
    headerView->setHidden(true);
{% endcodeblock %}
加上上面的代码，就可以去掉左边的行号了。
http://hi.baidu.com/buptyoyo/blog/item/bb8cab3d93817ec97d1e7143.html

# 设置行的默认高度
---
{% codeblock %}
	tableWidget->verticalHeader()->setDefaultSectionSize(height)
{% endcodeblock %}
