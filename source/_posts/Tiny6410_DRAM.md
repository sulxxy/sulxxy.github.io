title: Tiny6410 Note 2 -- DRAM Controller
date: 2015-06-16 09:14:00
tags: [Embedded Systems, Tiny6410]
---

# 一些关于Tiny6410中SDRAM的科普知识
[详解TINY6410硬件电路设计之二](http://www.eepw.com.cn/article/268241.htm)
顺便附上同系列的第一篇，关于Nand Flash的：
[详解TINY6410硬件电路设计之一](http://www.eepw.com.cn/article/267639.htm)

# 两种启动方式介绍
## SDBOOT：
程序被直接烧入SDRAM（S3C6410中，DRAM起始地址为0x50000000)开始运行。
## Nand BOOT：
程序首先被烧写到Nand Flash中的起始位置，每次上电后，Nand Flash的前8K地址被拷贝到S3C6410内部的SRAM中，然后CPU从SRAM的起始位置开始运行。SRAM中可以写入拷贝到DRAM中执行的代码，跳转到DRAM后，程序会继续执行。
顺便再粘一个链接：[关于从NAND Flash启动的问题，2440 启动问题 ， 拷贝4k程序 ，启动代码分析](http://blog.csdn.net/lanmanck/article/details/4194016)

代码方面暂时没啥可说的，比较简单，这部分主要是概念的理解。
