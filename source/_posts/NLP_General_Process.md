title: Basic Concepts of Speech
date: 2016-04-14 15:23:42
tags: [NLP, Sphinx]
---

# Description
---
This post mainly talks about some basic concepts of speech, most parts of which copy from [CMU Sphinx wiki](http://cmusphinx.sourceforge.net/wiki/tutorialconcepts). 
<!--本文主要介绍语音识别中一些常见的概念和基本思路，主要以翻译Sphinx官方的一篇wiki--[Basic concepts of speech](http://cmusphinx.sourceforge.net/wiki/tutorialconcepts)为主，必要时会加一些其他参考资料以及自己的理解。-->

# Basic concepts of speech 
---
Speech is a complex phenomenon. People rarely understand how is it produced and perceived. The naive perception is often that speech is built with words, and each word consists of phones. The reality is unfortunately very different. Speech is a dynamic process without clearly distinguished parts. It's always useful to get a sound editor and look into the recording of the speech and listen to it. Here is for example the speech recording in an audio editor.
<!--语音是一种复杂的现象。很少有人去观察语音是如何产生以及如何被感知的。通常的认知是，语音由单词组成，单词由音素组成。可实际并非如此。语音是一个动态连续的过程，没有明显的区间划分。我们可以通过声音编辑软件录音来看看真实的语音是什么样子的。-->
![Waveform](http://7xssst.com2.z0.glb.clouddn.com/waveform.png)
All modern descriptions of speech are to some degree probabilistic. That means that there are no certain boundaries between units, or between words. Speech to text translation and other applications of speech are never 100% correct. That idea is rather unusual for software developers, who usually work with deterministic systems. And it creates a lot of issues specific only to speech technology.
<!--目前所有关于语音的描述都是基于某种程度上的概率论理论。也就是说，声音单元之间，单词之间都没有明显的边界。声音到文字的转换以及其他语音服务都不可能将正确率做到100%。这对于软件开发者来说可能会相当不可思议，因为他们通常在一个确定的系统下工作。同时，这也产生了许多针对于语音技术领域的问题。-->

# Structure of speech
---
In current practice, speech structure is understood as follows:

Speech is a continuous audio stream where rather stable states mix with dynamically changed states. In this sequence of states, one can define more or less similar classes of sounds, or **phones**. Words are understood to be built of phones, but this is certainly not true. The acoustic properties of a waveform corresponding to a phone can vary greatly depending on many factors - phone context, speaker, style of speech and so on. The so called coarticulation makes phones sound very different from their “canonical” representation. Next, since transitions between words are more informative than stable regions, developers often talk about **diphones** - parts of phones between two consecutive phones. Sometimes developers talk about subphonetic units - different substates of a phone. Often three or more regions of a different nature can easily be found.
<!--语音是一个连续的音频流，它是由大部分的稳定态和部分动态改变的状态混合构成。一个单词的发声（波形）实际上取决于很多因素，而不仅仅是音素，例如音素上下文、说话者、语音风格等；协同发音（指的是一个音受前后相邻音的影响而发生变化，从发声机理上看就是人的发声器官在一个音转向另一个音时其特性只能渐变，从而使得后一个音的频谱与其他条件下的频谱产生差异。）的存在使得音素的感知与标准不一样，所以我们需要根据上下文来辨别音素。将一个音素划分为几个亚音素单元。-->

The number three is easily explained. The first part of the phone depends on its preceding phone, the middle part is stable, and the next part depends on the subsequent phone. That's why there are often three states in a phone selected for speech recognition.
<!--如：数字“three”，音素的第一部分与在它之前的音素存在关联，中间部分是稳定的部分，而最后一部分则与下一个音素存在关联，这就是为什么在用HMM模型做语音识别时，选择音素的三状态HMM模型。（上下文相关建模方法在建模时考虑了这一影响，从而使模型能更准确地描述语音，只考虑前一音的影响的称为Bi-Phone，考虑前一音和后一音的影响的称为 Tri-Phone。）-->

Sometimes phones are considered in context. Such phones in context are called **triphones** or even **quinphones**. For example “u with left phone b and right phone d” in the word “bad”. And it sounds a bit different from the same phone “u” with left phone b and right phone n“ in word “ban”. Please note that unlike diphones, they are matched with the same range in waveform as just phones. They just differ by name because they describe slightly different sounds.

For computational purpose it is helpful to detect parts of triphones instead of triphones as a whole, for example, to create a detector for a beginning of triphone and share it across many triphones. The whole variety of sound detectors can be represented by a small amount of distinct short sound detectors. Usually we use 4000 distinct short sound detectors to compose detectors for triphones. We call those detectors **senones**. A senone's dependence on context could be more complex than just left and right context. It can be a rather complex function defined by a decision tree, or in some other way.

Next, phones build subword units, like syllables. Sometimes, syllables are defined as “reduction-stable entities”. To illustrate, when speech becomes fast, phones often change, but syllables remain the same. Also, syllables are related to intonational contour. There are other ways to build subwords - morphologically-based in morphology-rich languages or phonetically-based. Subwords are often used in open vocabulary speech recognition.

Subwords form words. Words are important in speech recognition because they restrict combinations of phones significantly. If there are 40 phones and an average word has 7 phones, there must be 40^7 words. Luckily, even a very educated person rarely uses more then 20k words in his practice, which makes recognition way more feasible.

Words and other non-linguistic sounds, which we call **fillers** (breath, um, uh, cough), form **utterances**. They are separate chunks of audio between pauses. They don't necessary match sentences, which are more semantic concepts.

On the top of this, there are dialog acts like turns, but they go beyond the purpose of the document.

# Recognition process
---
The common way to recognize speech is the following: we take waveform, split it on utterances by silences then try to recognize what's being said in each utterance. To do that we want to take all possible combinations of words and try to match them with the audio. We choose the best matching combination. There are few important things in this match.

First of all it's a concept of **features**. Since number of parameters is large, we are trying to optimize it. Numbers that are calculated from speech usually by dividing speech on frames. Then for each frame of length typically 10 milliseconds we extract 39 numbers that represent the speech. That's called **feature vector**. They way to generates numbers is a subject of active investigation, but in simple case it's a derivative from spectrum.

Second it's a concept of the **model**. Model describes some mathematical object that gathers common attributes of the spoken word. In practice, for audio model of senone is gaussian mixture of it's three states - to put it simple, it's a most probable feature vector. From concept of the model the following issues raised - how good does model fits practice, can model be made better of it's internal model problems, how adaptive model is to the changed conditions.

The model of speech is called [Hidden Markov Model](http://en.wikipedia.org/wiki/Hidden_Markov_model) or HMM, it's a generic model that describes black-box communication channel. In this model process is described as a sequence of states which change each other with certain probability. This model is intended to describe any sequential process like speech. It has been proven to be really practical for speech decoding.

Third, it's a matching process itself. Since it would take a huge time more than universe existed to compare all feature vectors with all models, the search is often optimized by many tricks. At any points we maintain best matching variants and extend them as time goes producing best matching variants for the next frame.

The flow chart:
![Speech recognition flow chart](http://7xssst.com2.z0.glb.clouddn.com/Speech%20Recognition%20Flowchart.png)

# Models
---
According to the speech structure, three models are used in speech recognition to do the match:

An **acoustic model** contains acoustic properties for each senone. There are context-independent models that contain properties (most probable feature vectors for each phone) and context-dependent ones (built from senones with context).

A **phonetic dictionary** contains a mapping from words to phones. This mapping is not very effective. For example, only two to three pronunciation variants are noted in it, but it's practical enough most of the time. The dictionary is not the only variant of mapper from words to phones. It could be done with some complex function learned with a machine learning algorithm.

A **language model** is used to restrict word search. It defines which word could follow previously recognized words (remember that matching is a sequential process) and helps to significantly restrict the matching process by stripping words that are not probable. Most common language models used are n-gram language models-these contain statistics of word sequences-and finite state language models-these define speech sequences by finite state automation, sometimes with weights. To reach a good accuracy rate, your language model must be very successful in search space restriction. This means it should be very good at predicting the next word. A language model usually restricts the vocabulary considered to the words it contains. That's an issue for name recognition. To deal with this, a language model can contain smaller chunks like subwords or even phones. Please note that search space restriction in this case is usually worse and corresponding recognition accuracies are lower than with a word-based language model.

Those three entities are combined together in an engine to recognize speech. If you are going to apply your engine for some other language, you need to get such structures in place. For many languages there are acoustic models, phonetic dictionaries and even large vocabulary language models available for download.

# Other concepts used
---
1. **A Lattice** is a directed graph that represents variants of the recognition. Often, getting the best match is not practical; in that case, lattices are good intermediate formats to represent the recognition result.
2. **N-best lists** of variants are like lattices, though their representations are not as dense as the lattice ones.
3. **Word confusion networks** (sausages) are lattices where the strict order of nodes is taken from lattice edges.
4. **Speech database** - a set of typical recordings from the task database. If we develop dialog system it might be dialogs recorded from users. For dictation system it might be reading recordings. Speech databases are used to train, tune and test the decoding systems.
5. **Text databases** - sample texts collected for language model training and so on. Usually, databases of texts are collected in sample text form. The issue with collection is to put present documents (PDFs, web pages, scans) into spoken text form. That is, you need to remove tags and headings, to expand numbers to their spoken form, and to expand abbreviations.

# What is optimized
---
When speech recognition is being developed, the most complex issue is to make search precise (consider as many variants to match as possible) and to make it fast enough to not run for ages. There are also issues with making the model match the speech since models aren't perfect.

Usually the system is tested on a test database that is meant to represent the target task correctly.

The following characteristics are used:
1. **Word error rate**. Let we have original text and recognition text of length of N words. From them the I words were inserted D words were deleted and S words were substituted Word error rate is
<script> type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default"></script>
$$WER = (I + D + S) / N$$
WER is usually measured in percent.
2. **Accuracy**. It is almost the same thing as word error rate, but it doesn't count insertions.
$$Accuracy = (N - D - S) / N$$
Accuracy is actually a worse measure for most tasks, since insertions are also important in final results. But for some tasks, accuracy is a reasonable measure of the decoder performance.
3. **Speed**. Suppose the audio file was 2 hours and the decoding took 6 hours. Then speed is counted as \\(3*RT\\).
4. **ROC curves**. When we talk about detection tasks, there are false alarms and hits/misses; ROC curves are used. A curve is a graphic that describes the number of false alarms vs number of hits, and tries to find optimal point where the number of false alarms is small and number of hits matches 100%.

There are other properties that aren't often taken into account, but still important for many practical applications. Your first task should be to build such a measure and systematically apply it during the system development. Your second task is to collect the test database and test how does your application perform.
