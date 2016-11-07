title:  Tiny6410无法使用usb下载功能的解决办法
date: 2015-06-05 08:11:23
categories: Technique
tags: [Tiny6410, Embedded Systems]
---

开发板：友善之臂Tiny6410

superboot：[superboot-6410](http://download.csdn.net/detail/u012016202/8564895)

主机操作系统：Debian 7

两点声明：

   1. 配套光盘里的superboot-6410是烧不进去的，原因不明，用上面的链接中的那个可以。
   2. 至今依旧没有解决minitools无法连上开发板的问题，笔者使用的是superboot中的下载运行功能，习惯终端操作，这样反而更方便些。
<!-- more -->

正文：

我使用的是dnw工具，这里记录下整个折腾流程吧，不愿意往下看的读者也可以直接点击[dnw2 for tiny6410](http://download.csdn.net/detail/u012016202/8564927)下载源文件，编译运行即可，下文都是记录之用。

dnw工具网上能找到两个版本，dnw和dnw2，当然使用之前先得保证电脑上装有libusb，这里就不赘述了。dnw需要写一个模块，加载进内核方能使用，可我之前并不成功，提示没有secbulk0这个文件，ls一下/dev/，确实没有，当时没有细想，现在想想可能是没有未模块注册设备的原因吧，具体写驱动的过程去年操作系统课上机实验做过，现在忘了，有空得温习一遍。后来找到了dnw2，当时参考的这篇文章[dnw for linux(ubuntu)绝对能用的](http://blog.chinaunix.net/uid-23086242-id-2552828.html)，IDVENDOR，IDPRODUCT通过lsusb就能查到，对应更改即可，还有就是下载地址需要改成0x50000000(仅限tiny6410），编译通过，运行会报错：

    	usb_bulk_write():no such file or directory

于是查了usb_bulk_write()函数相关，第二个参数ep是设备端点号，好吧，科普去，推荐一篇很好的帖子，十分十分感谢原作者：[ Linux下，查看USB设备信息](http://blog.csdn.net/gaojinshan/article/details/9787005)，尽管收获颇多，仍然没有解决我想要的问题，再看看这篇帖子：[我使用libusb的数据传输程序usb_bulk_write和usb_bulk_read函数使用实例](http://blog.chinaunix.net/uid-20564848-id-73127.html)，恩，0x02表示输出，0x81表示输入，到这就明朗了。源代码里的第二个参数是0x03，不知代表啥意思，总之改了就对了。至此，开发板可以接收消息了，不幸的是会出现data error的提示，依旧运行不了。
于是对照了之前下的dnw中的dnw_src目录下的dnw.c，发现dnw2中源代码作者没有写校验和的代码，于是照着添加进来，到这一步，再编译运行，就基本成功啦。
至此，就可以通过superboot中的下载运行功能直接跑裸机程序啦，十分方便，Minitools不用也罢。来张截图：
![Dnw2在superboot下下载运行](/img/dnw2.jpg)

- 后期添加：

   在做Nand Flash部分实验时发现，在进入superboot后，按v选项可以直接把bin文件传输到Nand Flash的起始位置，非常的方便。
