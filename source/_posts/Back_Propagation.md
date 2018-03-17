title: Backpropagation Algorithm
tag: [Machine Learning, Neural Network]
category: Machine_Learning
mathjax: true
---

# Feed-forward Network
Considering a basic network architecture, first a linear combination of input data $x\_1, \ldots, x\_D$:
<!-- more -->
$$a\_j = \sum\_{i=1}^D\mathcal{w}\_{ji}^{(1)}x\_{i}+\mathcal{w}\_{j0}^{(1)} \label{eq:1} \tag{1}$$
where $j=1, \ldots, M$.
Then each of this is transformed using a nonlinear *activation function h()*,
$$ z\_j = h(a\_j)  \label{eq:2} \tag{2} $$
At the end, these values are linear combined again using *output unit activations*:
$$ a\_k = \sum\_{j=1}^{M}\mathcal{w}\_{kj}^{(2)} + \mathcal{w}\_{k0}^{(2)} \label{eq:3} \tag{3} $$
To merge all we got:
$$ y\_k(\mathbf{x}, \mathbf{w}) = \sigma\Biggl(\sum\_{j=1}^Mw\_{kj}^{(2)}h\biggl(\sum\_{i=1}^Dw\_{ji}^{(1)}x\_i + w\_{j0}^{(1)}\biggr) + w\_{k0}^{(2)}\Biggr) \label{eq:4} \tag{4} $$
if we absorb the biases, $(\ref{eq:4})$ could be simplified like:
$$ y\_k(\mathbf{x}, \mathbf{w}) = \sigma\Biggl(\sum\_{j=0}^Mw\_{kj}^{(2)}h\biggl(\sum\_{i=0}^Dw\_{ji}^{(1)}x\_i \biggr) \Biggr) \label{eq:5} \tag{5} $$

# Network Training
Now we have the network architecture. Next step is to define the error cost function. Simply speaking, it could be defined like:
$$ E(\mathbf{w}) = \frac{1}{2}\sum\_{n=1}^{N}{\Vert \mathbf{y}(\mathbf{x}\_n, \mathbf{w}) - t\_n\Vert}^{2} \label{eq:6} \tag{6} $$
In particular, this cost function could be interpreted from probabilistic perspective. [todo, explain this using probabilistic interpretation].

# Error Backpropagation


# todo
1. todo, explain ($\ref{eq:6}$) using probabilistic interpretation

