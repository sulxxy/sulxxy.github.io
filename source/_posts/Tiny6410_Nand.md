title: Tiny6410 Note 3 -- Nand Flash Controller
date: 2015-06-28 09:18:00
categories: Technique
tags: [Embedded Systems, Tiny6410]
---

> 迁移自我的CSDN 博客：[Tiny6410学习笔记3——Nand Flash Controller](http://blog.csdn.net/sulxxy/article/details/46609653)

# Nand Flash简介
## 简介
相当于pc机的硬盘，保存系统运行所必须的操作系统、应用程序、用户数据以及运行过程中产生的一系列数据。掉电后数据仍可保存。
贴上Tiny6410所用的Nand Flash芯片的引脚配置图和信息，以后会用。
<!-- more -->
## 引脚
引脚配置图：
![引脚配置图](/img/pin.jpg)
引脚描述：
![引脚描述](/img/pindesc.jpg)

## 基本结构图
![Array Organization](/img/basicstruct.jpg)
![Array Organization2](/img/pindesc2.jpg)
由图中可以看到，一页有2KB的空间以及64*8bit的额外空间（韦东山老师的教学教程里称之为OOB，不在Nand Flash的编址范围之内，一般情况下不用）。可以看出，一页有2112\*8个cell（一个cell为1bit），一个block有64页，一个Device Register有2K个块（block）。

# Nand Flash Controller
## 硬件连接图
![Nand Flash 与 S3C6410的连线](/img/hdconn.jpg)
从图中可以看到，S3C6410只有数据总线与Nand Flash相连，而没有地址总线，这与SDRAM，SRAM，寄存器，网卡等都不相同，这也意味着Nand Flash有着另一种寻址方式，而不是由CPU统一编址。 
## Nand Flash访问方式
没有了地址总线，那么所有的命令、地址、数据都得由数据总线完成，如何确定是命令、地址还是数据，则是控制信号需要完成的工作。
基本访问步骤是：
1. 发出命令（CLE引脚）：
	读，写，擦除
	PS：读写操作都是以页为单位执行的，而擦除操作是以块为单位执行的。
	Nand Flash的Command Set：
	![command set](/img/cmmd.jpg)
	对S3C6410来说，这一步简化为写NFCMMD寄存器，将所需的命令通过Command Set表映射为一个16进制数，写入该寄存器即可。
2. 发出地址（ALE引脚）：
	对S3C6410来说，这一步简化为写NFADDR寄存器。
3. 传输数据（WE，RE引脚）：
	对S3C6410来说，这一步简化为写NFDATA寄存器。
4. 状态：
	对S3C6410来说，这一步简化为写NFSTAT寄存器。

# 代码示例
主要贴上nand.c部分的源码：
{% codeblock %}
	#define BASE 0x70200000 //can not use volatile unsigned char *
	#define NFCONF_OFFSET 0x00
	#define NFCONT_OFFSET 0x04
	#define NFCMMD_OFFSET 0x08
	#define NFDATA_OFFSET 0x10 
	#define NFADDR_OFFSET 0x0c
	#define NFSTAT_OFFSET 0x28
	
	#define __REG(x) (*(volatile unsigned long*)(x))
	#define __REGb(x) (*(volatile unsigned char*)(x))
	#define NFCONF __REG(BASE+NFCONF_OFFSET)
	#define NFCONT __REG(BASE+NFCONT_OFFSET)
	#define NFCMMD __REG(BASE+NFCMMD_OFFSET)
	#define NFDATA __REGb(BASE+NFDATA_OFFSET)
	#define NFADDR __REG(BASE+NFADDR_OFFSET)
	#define NFSTAT __REG(BASE+NFSTAT_OFFSET)
	
	void select_nand(){
		NFCONT &= ~(1<<1); 
	}
	
	void deselect_nand(){
		NFCONT |= (1<<1);
	}
	
	void write_addr(unsigned long addr){
		NFADDR = 0;
		NFADDR =  0;
		NFADDR =  (addr) & 0xff;
		NFADDR = (addr >> 8) & 0xff;
		NFADDR = (addr >> 16) & 0x07;
	}
	
	void write_cmd(unsigned char cmd){
		NFCMMD = cmd;
	}
	
	/*unsigned char read_data(){
		return NFDATA; 
	}*/
	
	void wait_idle(){
		while(!(NFSTAT & (1 << 0)));
	}
	void nand_init(){
		#define TACLS 7
		#define TWRPH0 7
		#define TWRPH1 7
		NFCONF = (TACLS << 12) | (TWRPH1 << 8) | (TWRPH0 << 4);
		NFCONT |= (0x3<<0); 
	}
	
	int copy2ddr(unsigned long nand_start_addr, unsigned int ddr_start_buf, unsigned int size){
		unsigned char* ddr_buf = (unsigned char*)ddr_start_buf;
		int i;
		int j;
		select_nand();
		size = (size/2048 + 1) * 2048;
		for(i = 0; i < (size >> 11);i++ ){
			select_nand();
			NFCMMD = 0;
			write_addr(i); 
			NFCMMD = 0x30;
			wait_idle();
			for(j = 0 ; j < 2048; j++){
				*ddr_buf = NFDATA;
				ddr_buf++;
			}
		}
		deselect_nand();
		return 0; //the return type cannot be void 
	}
{% endcodeblock %}

# 一些说明
## TWRPH0, TWRPH1, TACLS的计算
查看S3C6410芯片手册，可以看到下图：
![S3C6410_NFCON_Timing_Diagram](/img/S3C6410_NFCON_Timing_Diagram.jpg)
在对照nand芯片的图（以K9K8G08U0A芯片为例）：
![K9K8G08U0A_Timing_Diagram](/img/K9K8G08U0A_Timing_Diagram.jpg)
通过比对可以看出，TACLS相当于nand中的tcls-twp，TWRPH0相当于twp，TWRPH1相当于tclh；
对照nand芯片：
![K9K8G08U0A_Timing_Characteristics](/img/K9K8G08U0A_Timing_Characteristics.jpg)
以及S3C6410的NFCONF寄存器：
![S3C6410中的NFCONF](/img/S3C6410_NFCONF_Table.jpg)
同时，还得看看HCLK的值，从S3C6410手册容易看到，HCLK为133MHz，换为周期即7.5ns
所以：
HCLK*TACLS=HCLK*（tcls-twp)>=Duration即可。
Duration可以在nand芯片的Timing Characteristics（见上上图）中查到。
TWRPH0，TWRPH1遵循同样的道理。

## 汇编的一个知识点
r0, r1,r2寄存器用于存放参数，如：
{% codeblock %}
	adr r0, _start   			
	ldr r1, =_start  			
	ldr r2, =bss_start      	
	sub r2, r2, r1
	cmp r0,r1
	beq clean_bss
	bl copy2ddr		
{% endcodeblock %}
copy2ddr函数的三个参数分别就是r0,r1,r2.
## 写地址的运算方法
由于本方法每次都是按页读的，所以不需要考虑行地址（页内地址），只需要考虑页的地址就行了，这样就很容易理解写地址的函数了。
## 整个流程总结
由SRAM初始化DRAM和nand-->跳转到链接地址-->进行拷贝操作-->在dram中执行main函数。
