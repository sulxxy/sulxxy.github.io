title: BB-Black利用Debian主机进行上网
date: 2015-03-22 09:50:54
categories: Technique
tags: [Embedded Systems]
---

首先，需要做的是让板子能和主机通讯，不赘述。通过ssh命令进入板子以后，发现是ping不到外网的，这时便需要iptable命令，进行包转发，从而通过主机网卡进行与外网互联（个人理解）。具体配置过程如下：
在宿主机（笔者Debian）上，sudo iptables -A POSTROUTING -t nat -j MASQUERADE，同时，查看宿主机的DNS，cat /etc/resolv.conf，记下；在开发板上，/usr/sbin/route add default gw 192.168.7.1
echo "nameserver 宿主机的DNS" >> /etc/resolv.conf。
这样，再在开发板上ping外网就能ping通了。
参考链接：[ Beaglebone Black 利用Ubuntu上网 ](http://bbs.21ic.com/icview-636292-1-1.html)，感谢原作者。

注：笔者并没有注释掉/etc/sysctl.conf中的net.ipv4.ip_forward=1，同时并没有在板子上将最后两条语句写入～/.profile，直接敲命令执行的，依旧配置成功。
