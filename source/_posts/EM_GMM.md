title: EM Algorithm and Gaussian Mixture Model
date: 2017-11-23 11:43:l1
tag: [Machine Learning]
category: Machine_Learning_EN
mathjax: true
---

# Introduction to EM
Previously I talked about [Naive Bayes Classifier](todo). In that case, all variables are observable. However, sometimes there could be some latent variables in some models. EM(Expection-Maximization) algorithm could resolve those models containing latent variables.
<!-- more -->

# Gaussian Mixture Models
Before talking general case of EM algorithm, we introduce the Gaussian Mixture Models(GMM) and calculate its parameters using EM.
## What is GMM?
GMM is a composition of several components with Gaussian distribution and different components. It could be written like,
$$p(x) := \sum_{k=1}^K \pi_k\mathcal{N}(x|\mu_k, \, \Sigma_k) \tag{1}\label{eq:GMM}$$

Simply speaking, we can explain $\pi_k$ as the weights of each Gaussian.

However, in order to understand what the latent variable is and how it works, first we explain the formulation of the equation $\ref{eq:GMM}$ from the point of latent variables.

Imaging we have a K-dimensional binary vector $\mathcal{z}$ in which the $z^{th}$ element $\mathcal{z_k}$ equal to $\mathcal{1}$ and others are $\mathcal{0}$. Now we need to define $p(x, z)$:
$$p(x, z) := p(x|z)p(z)\tag{2}\label{eq:2}$$

in equation $\ref{eq:2}$, we need to consider $p(z)$ and $p(x|z)$. 
1. $p(z)$

   $p(z)$ is the marginal distribution of $p(x, z)$ over $\mathcal{z}$, assuming it equals to the mixing coefficients $\pi_k$, so we have:
   $$p(z_k = 1) := \pi_k\tag{3}\label{eq:3}$$

   since in vector $\mathcal{z}$, all values except \\(\mathcal{z_k}\\) are $\mathcal{0}$, so equation $\ref{eq:3}$ can be written like:

   $$p(z) := \prod_{k=1}^K \pi_k^{z_k}\tag{4}\label{eq:4}$$

2. $p(x|z)$

   Also, assuming that the conditional distribution of $\mathcal{x}$ given a particular value for $\mathcal{z}$ is a Gaussian,
   $$p(x|z_k=1) := \mathcal{N}(x|\mu_k, \, \Sigma_k)\tag{5}\label{eq:5}$$

   Similarly, equation $\ref{eq:5}$ can be written like:
   $$p(x|z) := \prod_{k=1}^K \mathcal{N}(x|\mu_k, \, \Sigma_k)^{z_k}\tag{6}\label{eq:6}$$

Now we can calculate the marginal distribution of $p(x, z)$ over $\mathcal{x}$:
$$p(x) := \sum_{z} p(z)p(x|z)\tag{7}\label{eq:7}$$

put equation $\ref{eq:4}$ and $\ref{eq:6}$ into equation $\ref{eq:7}$,
$$p(x) := \sum_{k=1}^K \pi_k \mathcal{N}(x|\mu_k, \, \Sigma_k)\tag{8}\label{eq:8}$$

Equation $\ref{eq:8}$ is exactly same with equation $\ref{eq:GMM}$, so now we succefully explained the GMM from the point of latent variables.

Also, we need to calculate the conditional probability of $\mathcal{z}$ given $\mathcal{x}$, let us call it $\gamma(z_k)$,
$$\gamma(z_k) := p(z_k=1|x) := \frac {p(z_k=1)\cdot p(x|z_k=1)}{p(x)}\tag{9}\label{eq:9}$$

put equation $\ref{eq:3}$, $\ref{eq:5}$ and $\ref{eq:8}$ into equation $\ref{eq:9}$,
$$\gamma(z^k) := \frac {\pi^k\mathcal{N}(\mu^k,\,\Sigma^k)}{\sum_{j=1}^K\mathcal{N}(x|\mu_j, \, \Sigma_j)}\tag{10}\label{eq:10}$$

*notice that in equation $\ref{eq:10}$, all superscripts like $z^k$, $\pi^k$, $\mu^k$, $\Sigma^k$ are subscripts actually. There's some rendering problem if I use subscripts here.*

To prepare for the explaination using EM algorithm next, one important thing has to be emphasized:
1. in equation $\ref{eq:8}$, $\pi_k$ should be seen as the **prior** of $z_k=1$(this is what equation $\ref{eq:3}$ is saying);
2. in equation $\ref{eq:10}$, $\gamma(z_k)$ should be seen as **posterior** once we obeserved $\mathcal{x}$(this is what equation $\ref{eq:9}$ saying).


## EM algorithm on GMM

# EM algorithm in general

# Summary

# Reference
1. Bishop: Pattern Recognition and Machine Learning, Springer-Verlag, 2006
2. 李航：统计学习方法，清华大学出版社，2012

# related Articles
0. Bayesian Theory
1. K-means
