title: Debian中文输入法问题
date: 2014-07-08 10:03:45
tags: [Debian]
---

安装ibus以后，发现无法打开preferences设置，在终端里运行ibus-setup，提示:

	`Gtk-WARNING (recursed) **: Locale not supported by C library.Using the fallback 'C' locale.
百度后发现是locale问题，于是运行locale，提示

    locale: Cannot set LC_CTYPE to default locale: No such file or directory
    locale: Cannot set LC_MESSAGES to default locale: No such file or directory
    locale: Cannot set LC_ALL to default locale: No such file or directory。
有以下方案：

a. 运行locale-gen，再运行locale。（未成功）

b. 安装了glibc（参考文章：http://blog.csdn.net/johnnywww/article/details/7623703，注意：configure到make install 全部需root执行）。（未成功）

c. 管理员运行sudo dpkg-reconfigure locales，在弹出的界面中选择所有en_us开头和zh_CN开头，默认调为zh_CN.GBK，此方法成功。

另附：

/etc/environment:

    PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/bin/X11:/usr/games"
    LANG=en_US.UTF-8
    LANGUAGE="en_US:en_GB:en"
    LC_CTYPE="zh_CN.UTF-8"
    LC_ALL=
    GST_ID3_TAG_ENCODING=GBK
    SUPPORTED="zh_CN.UTF- 8:zh_CN.GBK:zh_CN:zh:en_US.UTF-8:en_US:en"
至此，ibus-setup成功运行。

d.

	1. 在 /etc/environment 里加入一行 LC_ALL="en_US.UTF-8"
	2. sudo locale-gen en_US.UTF-8
	3. sudo reboot(成功）



