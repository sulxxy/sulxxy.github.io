title: Linear Classification
date: 2017-12-10 16:05:26
tag: [Machine Learning]
category: Machine_Learning
mathjax: true
---

# Perceptron
Assume that only the means(or cnetroids) $\mu_1$ and $\mu_2$ of the 2 distributions are known. To predict the class of a new point, we could compare the distances to those 2 class means. That is,

$$||x - w_1|| < ||x - w_2||\tag{1}\label{eq:1}$$
$$\iff 0 < w^{T}\cdot{x} - \beta\tag{2}\label{eq:2}$$

in formula $\ref{eq:2}$,

$$w=\mu_1 - \mu_2\tag{3}\label{eq:3}$$
<!-- more -->

Bias could be included to weight vector by:
$$
\tilde{x} \leftarrow \left[ 
\begin{matrix}
1\\\
x
\end{matrix}
\right],\ \ \ 
\tilde{w} \leftarrow \left[
\begin{matrix}
-\beta\\\
w
\end{matrix}
\right]
\tag{4}\label{4}
$$

Then, the error function could be defined as:
$$\epsilon(\tilde{w}) = - \sum\_{m\in\mathcal{M}} \tilde{w}^T \tilde{x}\_m y\_m\tag{5}\label{eq:5}$$

Based on those, we could have the general framework for **Perceptron Algorithm**:
> **Computes**: Normal vector $w$ of decision hyperplane for binary classification
> **Input**: Data $\\{(x\_1, y\_1), (x\_2, y\_2), ..., (x\_N, y\_N)\\}$, $x\_i \in \Bbb{R}^D$, $y\_i \in \\{-1, +1\\}$, learning rate $\eta$, iterations $N\_{it}$.
> **Procedure**: 
> $\qquad \qquad$ w = 1 / D
> $\qquad \qquad$ for i=1 to $N\_{it}$ do:
> $\qquad \qquad \qquad$ Pick a random data point $x\_i$
> $\qquad \qquad \qquad$ if $w^Tx\_iy\_i < 0$ then:
> $\qquad \qquad \qquad \qquad$ $w = w + \eta x\_i y\_i$
> $\qquad \qquad \qquad$ end if
> $\qquad \qquad$ end for
> **Output**: $w$

To sum up, perceptron algorithm tries to find a hyperplane which could divide the data points exactly to 2 parts. However, this is a really ideal situation. In most case, it is impossible to find a hyperplane for the perfect division. The simplest case is exclusive or($x\_1 \oplus x\_2$). Percetron Could not solve this problem. Using **Multiple Layer Perceptron(MLP)** could solve this problem.


# Model
**Linear Discriminant Analysis(LDA)** is also called **Fisher's Linear Discriminant Analysis**.  

# Alogrithm

# Example
## Problem Description
## Solution
1. General idea

2. Sample code

# Summary

See [GMM and EM]() for more.


# Reference
