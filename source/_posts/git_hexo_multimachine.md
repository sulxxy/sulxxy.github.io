title: Post HEXO Blogs on Several Computers
date: 2016-04-29 21:56:32
categories: Technique
tags: [Git, Hexo]
---

# Description
The blogs on my github pages are all written and deployed by HEXO. Now, I need to write blogs on two computers. Since the HEXO have not background, all of pages are generated from local files. That means, in order to write and post blogs from several computers, we need to synchronize our local files. So, I create a new branch which is called **source** on the github pages repository yourusername.github.io.git. 
<!-- more -->

# Configuration
The main steps:
1. Delete **.git** in the hexo project folder.
2. Initialize the local repository:
    {% codeblock %}
    $ git init
    $ git checkout -b source     //create local branch "source"
    $ git add .
    $ git commit -m "first commit"
    $ git remote add origin git@github.com:your-username/your-username.github.io.git
    $ git push origin source
    {% endcodeblock %}
3. On another computer, we need to do:
    {% codeblock %}
    $ git init 
    $ git remote origin git@github.com:your-username/your-username.github.io.git
    $ git fetch
    $ git checkout -b source origin/source
    {% endcodeblock %}
Note: We have to create a new **local** branch *source*. Other wise, the branch what we are using will be the remote branch and our local branch are empty. If we do not create our local branch, we will have problems when we execute:
    {% codeblock %}
    $ git push origin source //here, the *source* actually means the local branch instead of remote branch
    {% endcodeblock %}
The error is
    > error: pathspec 'origin/source' did not match any file(s) known to git.

    This is because there is no local branch and there is no file to push. 

# Posting Blogs
1. Every time before we write blogs, we need to run:
    {% codeblock %}
    $ git checkout source
    $ git pull origin source
    {% endcodeblock %}
2. After we finished posting blogs, we need to run:
    {% codeblock %}
    $ git add .
    $ git commit -m "message"
    $ git push origin source
    {% endcodeblock %}
