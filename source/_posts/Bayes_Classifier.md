title: Bayes Classifier
date: 2017-11-22 22:35:01
tag: [Machine Learning]
category: Machine_Learning_EN
mathjax: true
---

# General Idea
Generally speaking, to solve a classification problem, what we need to do is to get the optimal estimation on the posterior:
$$h(x) := \mathop{\arg\,\max}\limits_{c_k}P(Y=c_k|X=x)\tag{1}\label{eq:1}$$
There are 2 general methods to do this. First one is directly modeling the posterior based on training data and to do prediction based on that. This is called **Discriminative Model**, e.g., BP, LDA, SVM, etc. Another type is **generative Models**, which calculates $P(Y=c_k|X=x)$ using:
$$P(Y=c_k|X=x) := \frac {P(x,c_k)}{P(x)}\tag{2}\label{eq:2}$$
Naive Bayes Classifier is the second one.
<!-- more -->

# Naive Bayes Classifier
From Bayes Decision Theory, we know that:
$$P(X=x, Y=c_k) := P(X=x|Y=c_k)\cdot P(Y=c_k)\tag{3}\label{eq:3}$$

put equation $\ref{eq:3}$  into equation $\ref{eq:2}$,
$$P(Y=c_k|X=x) := \frac {P(X=x|Y=c_k)\cdot P(Y=c_k)}{P(x)}\tag{4}\label{eq:4}$$

put equation $\ref{eq:4}$ into $\ref{eq:1}$, we could get:
$$h(x) := \mathop{\arg\,\max}\limits_{c_k}\frac {P(X=x|Y=c_k)\cdot P(Y=c_k)}{P(x)}\tag{5}\label{eq:5}$$

Considered the divisor $P(x)$ is always the same no matter which class we finally choose, equation $\ref{eq:5}$ can be simplified to:
$$h(x) := \mathop{\arg\,\max}\limits_{c_k} P(X=x|Y=c_k)\cdot P(Y=c_k)\tag{6}\label{eq:6}$$

equation $\ref{eq:6}$ is the final objective function.

So now we need to calculate $P(X=x|Y=c_k)$ and $P(Y=c_k)$. Let's check them one by one.
1. $P(X=x|Y=c_k)$

   This term is called **class-conditional probability** or **likelihood**. It is hard to calculate directly since it could have lots of combinations for features of $x$. For example, $x$ has $d$ features, and each feature is a binary value(0 or 1). Even though in this pretty simple situation, there are still $2^d$ different combinations. However, it is impossible that the trainning data contains all of those combinations. That means, lots of combinations which do not appear in training dataset will be considered impossible happened(since $P(X=x)=0$). Obviously this is not correct.

   To solve this problem, Naive Classifier assuming that:
   > the value of a particular feature is independent of the value of any other feature, given the class variable

   Based on this assumption,
   $$P(Y=c^k|X=x) := \prod_{i=1}^{d} P(x_i|c^k)\tag{7}\label{eq:7}$$

   In equation $\ref{eq:7}$,
   * $d$ is the number of features of input data.
   * Since it seems that there is a problem rendering subscript while using prod or sum text command, here $c^k$ has the same meaning with $c_k$ which appeared in previous equations.

2. $P(Y=c_k)$

   This term is called **Prior** and can be easily calculated using **Maximum Likelihood Estimation**,
   $$P(Y=c^k) :=\frac {\sum_{i=1}^N I(y_i={c^k})}{N}, k=1, 2, 3, ... , K \tag{8}\label{eq:8}$$
   
   In equation $\ref{eq:8}$,
   * $I$ is a Indicator function. 
   * $c^k$ is $k^{th}$ class (see explaination on equation $\ref{eq:7}$). 
   * $K$ is the number of classes.
   * $N$ is the number of samples.

Now put $\ref{eq:7}$ and $\ref{eq:8}$ into $\ref{eq:6}$, the updated objective function is,
$$h(x) := \mathop{\arg\,\max}\limits_{c_k} \prod P(x_i|c_k) \cdot P(Y=c_k), i = 1, 2, ..., d, k = 1,2,...,K \tag{9}\label{eq:9}$$

Equation $\ref{eq:9}$ is the Naive Bayes Classifier expression.

# Optimization
## Laplacian Correction
## Semi-Naive Bayes Classifier
# Summary
[todo]
