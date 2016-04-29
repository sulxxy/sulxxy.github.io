title: SpeakerIdentification in DOCKS
date: 2015-08-30 10:55:28
tags: [ DOCKS, NLP ]
---

# Speaker Identification in DOCKS
---
本篇文章目的在于给DOCKS项目添加识别说话者身份的功能。借助于Sphinx4里的SpeakerIdentification可以实现这一功能。
## 基本实现原理
每读入一段音频后，通过cluster方法可以获取到一个记录说话者的特征的数组(该数组最底层是有Sphinx的前端Frontend的getData方法获得，实际上就是一个float或者double数组)，通过这个数组可以生成一个speakercluster，该对象中存放着说话者特征信息以及说话者说过的每一句话（后者还没在DOCKS实现，感觉没有必要），程序中一直维护着这个列表。在读入一段新的音频流时，可以在已经存在的说话者列表中查找是否该说话者已经存在。
## 源码目录
https://github.com/sulxxy/docks/blob/master/src/speakerid/DocksSpeakerIdentification.java

