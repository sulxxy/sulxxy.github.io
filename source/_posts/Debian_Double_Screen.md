title: Debian 7 双屏配置
date: 2014-07-23 09:28:33
tags: [Debian]
---

笔者所用显示屏最大分辨率为1920\*1080，但在debian下无法显示1920\*1080分辨率，查资料发现可以通过配置/etc/X11/xorg.conf更改，但发现debian默认没有xorg.conf。解决方案是进入字符界面关了gnome（/etc/init.d/gdm3 stop)，然后

    X -configure, X -config xorg.conf.new
然后cp到/etc/X11/xorg.conf。
但接踵而至的问题是图形界面完全打不开了，显然是xorg.conf的问题。终于在下面的链接中找到了解决方案，附上链接：[Xorg.conf双屏配置解惑](http://blog.sina.com.cn/s/blog_7cd2354e01018s9j.html)，十分感谢原作者～
配置如下：

	\#MTstyle--shuiyue building 2012-8-27
	Section"ServerLayout"
	    Identifier"Layout0"
	    Screen0 "Screen0" 0 0
	    InputDevice"Keyboard0" "CoreKeyboard"
	    InputDevice"Mouse0" "CorePointer"
	    Option"Xinerama" "1" ##开启双屏显示
	EndSection
	
	Section"InputDevice" ##鼠标配置部分
	    Identifier"Mouse0"
	    Driver"mouse"
	    Option"Protocol" "auto"
	    Option"Device" "/dev/psaux"
	    Option"Emulate3Buttons" "no"
	    Option"ZAxisMapping" "4 5 6 7"
	EndSection
	
	Section"InputDevice" ##键盘配置部分
	    Identifier"Keyboard0"
	    Driver"kbd"
	EndSection
	
	Section"Monitor" ##这个重要！显示器配置部分
	    Identifier"Monitor0" ##显示器接口Monitor0
	     Modeline "1368x768_60.00"85.25 1368 1440 1576 1784 768 771 781 798 -hsync+vsync ##这个用下面所说的cvt命令得到	的参数！
	    VendorName"LVDS"
	    ModelName"CRT-0"
	    HorizSync28.0 – 55.0 ##水平刷新率
	    VertRefresh43.0 – 72.0 ##垂直刷新率
	    Option"DPMS"
	EndSection
	 
	Section"Monitor" ##外屏配置部分
	    Identifier"Monitor1" ##外屏显示器接口Monitor1
	    Modeline"1920x1080_60.00"173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync+vsync ##这个用下面所说的cvt命令	得到的参数！
	    VendorName"AOCF22"
	    ModelName"CRT-1"
	    HorizSync24.0 –82 ##显示器说明书上会明确标出，可相应更改
	    VertRefresh 50.0 –75 ##显示器说明书上会明确标出，可相应更改
	    Option"DPMS"
	    Option"PreferredMode" "1920x1080_60.00"
	    Option"LeftOf""Monitor0" ##配置双屏显示的位置，现在的为外屏位于笔记本屏幕的左边，其他可用的为“RightOf”（Monitor1位于	Monitor0的右边）。不配置这个Option则不会使用扩展屏，而是用复制屏幕选项！
	EndSection
	
	
	Section"Device" ##显卡配置部分
	    Identifier"Device0"
	    Driver"Intel"
	    VendorName"Intel Corporation"
	    BoardName"Generation Core Process"
	    Option"monitor-LVDS1" "Monitor0" ##配置显示器的输出端接口！这个用xrandr命令查看
	    Option"monitor-HDMI1" "Monitor1" ##配置显示器的输出端接口！这个用xrandr命令查看
	    BusID"PCI:0:2:0" ##用下面的lspci命令，这里使用的是十进制参数！
	EndSection
	
	Section"Screen" ##屏幕整合部分
	    Identifier"Screen0"
	    Device"Device0"
	    Monitor"Monitor0"
	    DefaultDepth24
	    SubSection"Display"
	           Depth24
	    EndSubSection
	EndSection

自动生成xorg.conf配置文件。
终端进入root，输入X-configure :1

![](/img/x1.jpg)

这样就在／root目录下生成了一个xorg.conf.new的配置文件了，可是这个配置文件基本上不符合使用要求，修改呗！
说说配置的过程，先用xrandr查看屏幕的情况。

![](/img/x2.jpg)

查看当前屏幕的最佳分辨率。
然后用cvt查找相关参数，注意，这里默认刷新频率是60Hz，如果显示器有特殊要求，则在后面加入刷新频率参数

	cvt 1920 1080
![](/img/x3.jpg)

用lspci ｜ grepVGA查找显卡的BusID
![](/img/x5.jpg)

获得所有必须的信息后，填写配置吧！写完配置后，输出到tty8查看成果呗，可以结合
/var/log/Xorg.1.log查看（WW）和（EE）解决一些问题。
输出到tty8的命令如下：
![](/img/x4.jpg)

确认配置完全无错后，可以把这个xorg.conf.new复制到/etc/X11/目录下并改名为”xorg.conf”。
重启，查看成果吧！顺便提一下，在xorg.conf设置了扩展屏后，lightdm下，鼠标左右移动可以选择那个屏幕作为密码输入窗口！分辨率都是最佳的。漂亮极了。或许有些人说配置xorg.conf太麻烦了，直接使用xrandr加脚本不是更好吗？的而且确，但是，xorg.conf配置好后可以确保系统检测错误的情况下，修改为正确的配置，而且使用xrandr加脚本自启动，会增加系统进入桌面的一些步骤，个人作为一个伪完美主义者，并不喜欢！所以说这个配置文件不是没有用的，只是对于新手来说，难于入手而已！对于日后有志于使用Archlinux的人说，设置xorg.conf是必须的。其实这道理大家都懂......



