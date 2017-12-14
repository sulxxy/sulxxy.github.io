title: Perceptron and MLP
date: 2017-12-10 16:05:26
tag: [Machine Learning, Neural Network]
category: Neural Network
mathjax: true
---

# Perceptron
Assume that only the means(or centroids) $\mu_1$ and $\mu_2$ of the 2 distributions are known. To predict the class of a new point, we could compare the distances to those 2 class means. That is,

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

To sum up, perceptron algorithm tries to find a hyperplane which could divide the data points exactly to 2 parts. However, this is a pretty ideal situation. In most case, the data are not separable. The simplest case is exclusive or($x\_1 \oplus x\_2$). Perceptron learning algorithm could not solve this problem. Concreately, the $w$ could not converge forever. There would be 

To do this, **Multiple Layer Perceptron(MLP)** is introduced.

# Multiple Layer Perceptron
Compared to perceptron, MLP has some hidden layers. In single layer perceptron, in every iteration, we train w, and then check feasibility and optimize w. After several iterations, we could got a nice $w$. In MLP, the basic idea is almost the same but with more complex details(this kind of methodology is called **Expection Maximum**. I wrote a blog about this before, see [here](http://liuzhiwei.me/EM_GMM/) for more information). We call this algorithm **Error BackPropagation**.

## Error BackPropagation 
To explain and demostrate the procedure of error back propagation algorithm easily, I would like to use the example from the book *Pattern Recognition and Machine Learning [1]*. 
  Below is the network architecture: 
  we have a dataset $D = \\{(x\_1, y\_1), (x\_2, y\_2), ..., (x\_m, y\_m)\\}, \, x\_i \in \Bbb{R}^D, \, y\_i \in \Bbb{R}^K$, which means input has $D$ features and output is a $K$ dimensional vector. Also, we have $M$ hidden units as we could see from the diagram. 
![Network Architecture](http://7xssst.com1.z0.glb.clouddn.com/nn_example.jpg)

First, let us think about the needed parameters and their sizes respectively. Obviously we need weight $w$ and bias $b$. From the architecture, we know that each node in a layer has connections with all of the nodes of its (right-side, since what we are talking about is **Forward Feed Network**) adjacent layer(that is way MLP is also called **Fully Connected Network(FCN)**).
  Considering the weights and bias between input layer and hidden layer, we use the notation $w\_{MD}^{(1)}$ for the weights between them. The superscript $(1)$ is the index and the subscript $MD$ .

## Problem

# Summary

# Further More
1. [Expection Maximum and Gaussian Mixture Model](http://liuzhiwei.me/EM_GMM/)
2. [Convolutional Neural Network]()
3. [Recurrent Neural Network]()
4. [Radical Basis Function]()

# Reference
1. Bishop: Pattern Recognition and Machine Learning, Springer-Verlag, 2006
