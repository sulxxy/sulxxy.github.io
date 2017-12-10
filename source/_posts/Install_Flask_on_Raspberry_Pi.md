title: Fix Type Error when installing flask onto Raspbian
date: 2016-08-16 22:38:34

tags: [Raspberry Pi, Embedded Systems]
---

When installing flask onto Raspbian, there's an exception like this:
{% codeblock %}
$ pip install flask
Exception:
Traceback (most recent call last):
File "/usr/lib/python2.7/dist-packages/pip/basecommand.py", line 122, in main
atus = self.run(options, args)
File "/usr/lib/python2.7/dist-packages/pip/commands/install.py", line 290, in run
requirement_set.prepare_files(finder, force_root_egg_info=self.bundle, bundle=self.bundle)
File "/usr/lib/python2.7/dist-packages/pip/req.py", line 1097, in prepare_files
req_to_install, self.upgrade)
File "/usr/lib/python2.7/dist-packages/pip/index.py", line 194, in find_requirement
page = self._get_page(main_index_url, req)
File "/usr/lib/python2.7/dist-packages/pip/index.py", line 568, in _get_page
session=self.session,
File "/usr/lib/python2.7/dist-packages/pip/index.py", line 694, in get_page
req, link, "connection error: %s" % exc, url,
TypeError: __str__ returned non-string (type Error)

Storing debug log for failure in /home/pi/.pip/pip.log
{% endcodeblock %}
<!-- more -->

To deal with this problem, we need to correct the system time of the Raspbian. Normally, raspberry pi uses <b>NTP</b>(Network Time Protocol) service to get time. If the time is not correct, the following command can help us:
{% codeblock %}
$ sudo ntpd -s -d
{% endcodeblock %}
If this does not work, we can force to set time through:
{% codeblock %}
$ sudo date --s="2016-08-16 22:46:09"
{% endcodeblock %}

In the end, we can add some available ntp servers(inside China) like this:
{% codeblock %}
$ sudo vi /etc/ntp.conf
{% endcodeblock %}
And find the line:
{% codeblock %}
# You do need to talk to an NTP server or two(or three).
# server ntp.your-provider.example
{% endcodeblock %}

Add the following list uder this line:
{% codeblock %}
server ntp.fudan.edu.cn iburst perfer
server time.asia.apple.com iburst
server asia.pool.ntp.org iburst
server ntp.nict.jp iburst
server time.nist.gov iburst
{% endcodeblock %}

Now, we can use pip command to install flask successfully:-)

