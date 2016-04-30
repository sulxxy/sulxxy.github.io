title: /usr/bin/find Argument list too long
date: 2016-04-30 09:42:21
tags: [Find, Shell, Linux]
---

When I excute the following command in shell:
> $ find xxxx/xxxx/*.wav

There will be an error like this:
> /usr/bin/find Argument list too long

What we need to do is to change the command:
> $ find xxxx/xxxx/ -name '*.wav'

