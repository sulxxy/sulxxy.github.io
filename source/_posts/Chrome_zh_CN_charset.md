title: Debian7.5折腾笔记——Chrome中文乱码问题
date: 2014-07-08 08:34:49

tags: [Chrome, Linux, Debian]
---

> 迁移自我的CSDN 博客：[Debian7.5折腾笔记——Chrome中文乱码问题](http://blog.csdn.net/sulxxy/article/details/37573067)

由于中文恐惧症，习惯将系统设置成英文，但导致chrome无法正常显示中文字体，解决方案如下：
打开`/etc/fonts/conf.d/49-sansserif.conf`这个文件
然后修改倒数第四行的字体为ubuntu。
<!-- more -->
另附链接：[ debian7解决chrome中文乱码](http://blog.csdn.net/neosmith/article/details/17212049)
