title: Sphinx--Frontend分析
date: 2015-09-02 19:54:19
categories: Technique
tags: [ Sphinx, DOCKS, NLP ]
---

# 引言
---
在DOCKS项目中，一个重要的特性就是有效地结合了Google和Sphinx二者的优势。实现这一特性的重要因素在于，Sphinx具有良好的可扩展性和灵活性，用户可以用自己实现的前端替代Sphinx自带的前端。DOCKS正是通过实现了一个基于注音的前端，代替了Sphinx的前端。*本文着重介绍Sphinx的前端实现机制以及DOCKS是如何应用这一特性的。*
<!-- more -->

# Sphinx中的前端
---

## DataProcessor接口
Dat aProcessor接口主要用于执行信号处理，所有的数据处理类都需实现该接口。

## Frontend
Frontend包装了诸多数据处理单元，即包含了一系列数据处理的过程，Frontend的作用在于组织这些数据处理单元。举个例子，数据刚刚进入前端时，可能需要先进行快速傅里叶变换（FFT），那么我们可以先让数据流过专门进行FFT的数据处理单元，得到处理后的数据DP1；处理后的数据可能还需要进行高通滤波处理，那么再让它通过一个高通滤波器的处理单元。Frontend的具体结构如下图所示。
![Sphinx4 frontend](/img/frontend.jpg)

需要注意的是，每个数据处理单元都实现了DataProcessor接口，流经数据处理单元的数据都实现了Data接口。同时，对于前端数据的输入输出类型，并没有特殊的限制（参照刚刚说的那个例子）。这样一来，Sphinx的前端就具有了很大的灵活性。

## Frontend的工作流程
在Frontend中，可以通过调用getData()方法获取来自前端的数据。具体代码如下：
{% codeblock %}
FrontEnd frontend = ... // see how to obtain the front end below 
Data output = frontend.getData();
{% endcodeblock %}

调用getData()时，程序首先会调用数据处理单元链表中最后一个节点的getData()方法，该方法会触发倒数第二个数据处理单元的getData()方法。以此类推，直到第一个数据处理单元。需要注意的是，第一个数据单元会从一个输入单元获取数据，该输入单元是另一个数据处理单元，并没有在上图中显示出来。该输入单元可以放在前端中，当然也可以不放。如果不放在前端中，而是单独开发输入单元，那么可以调用前端的**setDataSource()**方法来设置输入单元。比如：
{% codeblock %}
	DataProcessor microphone = new Microphone(); 
	microphone.initialize(...); 
	frontend.setDataSource(microphone);
{% endcodeblock %}

## 配置前端
Sphin x前端需要通过配置文件来进行配置，基于配置文件的方式，极大的提高了前端的灵活性。下面举一个简单的例子：
{% codeblock %}
<component name="mfcFrontEnd" type="edu.cmu.sphinx.frontend.FrontEnd">
<propertylist name="pipeline">
<item>preemphasizer</item>
<item>windower</item>
<item>dft</item>
<item>melFilterBank</item>
<item>dct</item>
<item>batchCMN</item>
<item>featureExtractor</item>
</propertylist>
</component>
<component name="preemphasizer" type="edu.cmu.sphinx.frontend.filter.Preemphasizer"/>
<component name="windower" type="edu.cmu.sphinx.frontend.window.RaisedCosineWindower"/>
<component name="dft" type="edu.cmu.sphinx.frontend.transform.DiscreteFourierTransform"/>
<component name="melFilterBank" type="edu.cmu.sphinx.frontend.frequencywarp.MelFrequencyFilterBank"/>
<component name="dct" type="edu.cmu.sphinx.frontend.transform.DiscreteCosineTransform"/>
<component name="batchCMN" type="edu.cmu.sphinx.frontend.feature.BatchCMN"/>
<component name="featureExtractor" type="edu.cmu.sphinx.frontend.feature.DeltasFeatureExtractor"/>
{% endcodeblock %}

## 在代码中获取前端实例
在配置文件中配置好前端之后，需要在scorer中放入前端。在配置文件中：
{% codeblock %}
	<component name="scorer" type="edu.cmu.sphinx.decoder.scorer.SimpleAcousticScorer">
	<property name="frontend" value="mfcFrontEnd"/>
	</component>
{% endcodeblock %}

然后在代码中：
{% codeblock %}
	public void newProperties(PropertySheet ps) throws PropertyException {
		FrontEnd frontend = (FrontEnd) ps.getComponent("frontend", FrontEnd.class);
	}
{% endcodeblock %}
 
# DOCKS中PhoneFrontend前端的使用
---
前文已提及，在DOCKS中，一个核心的操作是使用了自定义的前端PhoneFrontend。相对Sphinx而言，PhoneFrontEnd比较简单。PhoneFrontend本身既是输入单元也是数据处理单元(或者说没有数据处理单元，PhoneFrontEnd的作用主要就是搬运，并没有对数据进行任何处理)，示意图如下：
![phonefrontend](/img/phonefrontend.png)

通过调用addPhonemes()方法可以向前端中添加数据（在DOCKS中，是注音），重写的getData()方法返回数据块。
