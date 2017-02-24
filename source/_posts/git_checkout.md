title: git tool -- checkout
date: 2017-02-24 15:13:12
categories: Technique
tags: [Git]
---

## Intro 
**git checkout** has 3 functions: checkout branch, checkout commit, checkout file.
<!-- more -->

## checkout branch
This are used to switch to a certain branch, e.g.,
```sh
git checkout benchmarking
```
then you will work *benchmarking* branch. You can check the current branch you are working on using:
```sh
git branch
```
## checkout commit
This command is used for switching(go back) to a certain commit and all files under working directory will be update to that version. Before doing this, we need to get the exact serial numbers of commit so that we know which commit we need to go to. To do this, we uses:
```sh
git log
```
Or add a parameter:
```sh
git log --online
```
Then you will see like this:
```
f8cdfb6   Add a parameter to init_child()
ecc31f6   bug fixed for the memory allocation error
```
Now you can choose a commit throw the commit message and number, e.g.,
```sh
git checkout f8cdfb6
```
Then the working directory will be switched to commit f8cdfb6. At this time, if we type:
```sh
git branch
```
You will see:
```
*(HEAD detached at f8cdfb6)
 master
 benchmarking
 develop
```
This means, you are put in a detached HEAD state. As a result, the commit version you are switching to is read-only.

## checkout file
We use:
```sh
git checkout <commit> <file>
```
To check out a previous version of a file. This will turn the <file> in working directory into a copy of the one from the <commit> and put it in to a staging area.

Now run:
```sh
git status
```
You will see:
```
changes to be committed:
    Modified: <file>
```
which means the file has been *changed* to the version of <commit>. To go back, we can run:
```sh
git reset HEAD <file>
```
Then the <file> will go back to the version right before we run `git checkout <commit> <file>`.

