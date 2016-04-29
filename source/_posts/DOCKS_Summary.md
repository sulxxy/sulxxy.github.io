title: DOCKS总结
date: 2015-09-20 15:44:11 
tags: [ DOCKS, NLP ]
---

# DOCKS简介
---
DOCKS全称为Domain- and Cloud-based Knowledge for Speech Recognition，由德国汉堡大学开发，旨在实现更加精确的域内识别。

# DOCKS所要解决的问题
---
目前的许多公司提供语音识别服务（ASR），这些服务大多都有着不错的识别率。但是这些服务无法被限定在一个特定的域内进行识别，以至于应用性不强。DOCKS希望在这些云服务的基础上，增加域的限制，以能够在特定环境下有更精确的识别。

# DOCKS提供的解决方案
---
为了达到这一目的，DOCKS采用了一种后期处理的机制。即：首先从云服务获取识别结果A，再对A进行后期处理，这里的后期处理主要是用了Sphinx4这个开源项目提供的类库。Sphinx4是可以通过XML等文件来进行配置的，配置的过程中可以加入特定的域（Sentencelist，语法模型之类）。在这里，有两点说明：
1. DOCKS从云服务获取到结果A后，并非直接交给Sphinx来处理，而是将A转化为音标，再交给Sphinx来处理。之所以这样做，主要是基于以下发现：从云服务返回的结果中，单词的错误率远高于音标的错误率，比如：“learn”会被识别为“Lauren”。将结果集转化为音标，可以更进一步的还原最原始的输入，从而降低识别的错误率。
2. Sphinx的处理过程：Sphinx分为三大块，Frontend， Decoder，Linguist。Frontend负责获取原始输入，并输出符合要求的Data类型。Linguist负责组织知识库等。Decoder结合来自Frontend的输出和Linguist知识库进行处理，返回最终的识别结果。结合DOCKS来看，Frontend的输入实际上是云服务返回的结果的注音，知识库里存储的是语法模型和音标等，这个Sphinx的后期处理过程完全是基于音标来实现的。
 
# DOCKS的测试方法
---
DOCKS主要测试了三类数据集：
1. Scripted HRI data set (SCRIPTED)
该项测试用于模仿自然环境。测试音源来自于两个非英语国家的两名说话者（一男一女），使用头戴式麦克风话筒进行录音。测试数据主要是按照预定义的语法规则写好的语句。一共采集了592组数据。不同于后面两个数据集的一点是：该语料库支持语法。
2. TIMIT Core Test Set (TIMIT)
该项测试用于测试云端的语音识别服务，输入语句非常任意。
3. Spontaneous HRI data set (SPONT)
作用同TIMIT Core Test Set(TIMIT)类似。

# DOCKS的优点和缺点
---
## 优点
1. 可以实现云服务与域限制二者的结合，拥有着更高的识别率。
2. 提出了一种基于音标的后期处理方式，无论中文还是英文，这一点带来的优化空间十分巨大。
3.  秉承了Sphinx模块化的优点，替换修改十分灵活。

## 缺点
1. 效率。这点问题的根源在于Sphinx。由于默认的Sphinx自带的语言模型文件特别大，所以DOCKS启动加载会耗费不短的时间。这一点可以通过精简语言模型文件或者创建自己的语言模型文件来优化。
 
# 对DOCKS的改进
---
对DOCKS主要改进了一下两点：
1. 语音分类
[SpeakerIdentification in DOCKS](http://sulxxy.github.io/2015/08/30/DOCKS_speakeridentify/)
2. 中文识别
[DOCKS中文识别——基于Baidu + Sentencelist方法](http://sulxxy.github.io/2015/09/11/DOCKS_Chinese_Recognization/)
