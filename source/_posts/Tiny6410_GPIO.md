title: Tiny6410 Note 1 -- GPIO
date: 2015-06-15 09:02:43
tags: [Embedded Systems, Tiny6410]
---

# GPIO硬件介绍
GPIO（General Purpose I/O Ports)意为通用输入输出端口，也就是一些引脚，通过它们输出高低电平或者通过它们读入引脚的状态——高电平还是低电平。

在S3C6410芯片中，包含187个引脚，有17个端口，分别是GPA，GPB，...，GPQ。可以通过设置寄存器来确定某个引脚是用于输入、输出还是其他特殊功能。
## 通过寄存器来操作GPIO引脚
既然一个引脚可以用于输入、输出和其他功能，那么一定有寄存器用来选择这些功能；对于输入，一定可以通过读取某个寄存器的值来确定引脚是高电平还是低电平；对于输出，则可以通过将高低电平写入某个寄存器实现。
在S3C6410中，每个端口有GP*CON,GP*DAT,GP*PUD,GP*CONSLP,GP*PUDSLP四种寄存器（PS：在GPK中，有GPKCON0和GPKCON1两组，有的可能只有四种中的几个，详见用户手册)。

### GP*CON
即co nfiguration，用于配置该端口中每个引脚的功能。如果当前位被用于输出，则可以在DAT寄存器中对应位写入0或1使得该引脚输出低或高电平；如果当前位被用作输入，此时DAT无用。
### GP*DAT
该寄存器用于读写引脚：如果当前引脚被用于输出，则可以在DAT寄存器中对应位写入值使得该引脚输出低或高电平；如果当前引脚被用作输入，此时DAT无用。
### GP*PUD
Reserved.
### GP*CONSLP
Reserved.
### GP*PUDSLP
Reserved.
# 一个简单的实验
电路图：参照原理图：
 ![原理图](/img/gpio.jpg)
可以看出，四个LED分别是GPK4，GPK5，GPK6，GPK7。

再通过芯片手册不难查处GPK中各种寄存器对应的物理地址。
实验代码部分：
首先是汇编部分，对开发板进行一些预处理：
{% codeblock %}
	// 启动代码
	.global _start
	
	_start:
	
	// 把外设的基地址告诉CPU
    	ldr r0, =0x70000000 					//对于6410来说,内存(0x00000000～0x60000000),外设(0x70000000-0x7fffffff)
    	orr r0, r0, #0x13						//外设大小:256M
    	mcr p15,0,r0,c15,c2,4       			//把r0的值(包括了外设基地址+外设大小)写给cpu
	
	// 关看门狗
	ldr r0, =0x7E004000
	mov r1, #0
	str r1, [r0] 
	
	// 设置栈
	ldr sp, =0x0c002000
	
	// 调用C函数点灯
	bl main
	
	halt:
		b halt	
{% endcodeblock %}
然后是c语言的功能代码：
{% codeblock %}
	int main()
	{
		// 配置引脚
		volatile unsigned long *gpkcon0 = (volatile unsigned long *)0x7F008800;
		volatile unsigned long *gpkdat = (volatile unsigned long *)0x7F008808;
	
		*gpkcon0 = 0x11110000;
		*gpkdat = 0x10;  //GPK占16位，但由于LED只用到了GPKCON0，即前八位，故这里只有前八位
		return 0;
	}
{% endcodeblock %}
最后是Makefile：
{% codeblock %}
	led.bin: start.o main.o
		arm-linux-ld -Ttext 0x50000000 -o led.elf $^
		arm-linux-objcopy -O binary led.elf led.bin
		arm-linux-objdump -D led.elf > led_elf.dis
	%.o : %.S
		arm-linux-gcc -o $@ $< -c
	
	%.o : %.c
		arm-linux-gcc -o $@ $< -c 
	
	clean:
		rm *.o *.elf *.bin *.dis  -rf
{% endcodeblock %}

不同CPU有不同的内存起始地址，S3C6410是0x50000000。
{% blockquote %}
\$^表示所有的依赖项;
\$<表示第一个依赖项；
$@表示目标项。
{% endblockquote %}

编译完成后，采用工具将bin文件下载开发板，运行即可。关于下载运行工具，在我的另一篇文章中有详细叙述。[ tiny6410无法使用usb下载功能的解决办法](http://blog.csdn.net/sulxxy/article/details/44885585)

# 总结
至此，一个最简单的GPIO实验完成。主要学习了两点：嵌入式开发的基本步骤；软件控制硬件的原理和流程。
