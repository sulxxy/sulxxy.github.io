title: Difference Between Gradient Descent and Stochastic Gradient Descent
tag: [Machine Learning, Optimization Theory]
category: Machine_Learning
mathjax: true
---

# Introduction
This post mainly discusses the difference between gradient gescent (a.k.a. vanilla gradient descent or batch gradient descent) and stochastic gradient descent (a.k.a. online gradient descent). We firstly show and compare the 2 alogorithms' implementations, which is quite simple. After that, we will analyse these 2 algorithms from the convergence rate perspective. At the end, the summaries are given.
<!-- more -->

# Algorithm Implementation
In this part, we mainly concentrate on the implementation of both algorithms to get an intuive difference between them. Assumes we have loss function $L(\mathbf{w}; \mathbf{x})$, in which $\mathbf{w}$ is the parameters to train and $\mathbf{x}$ is the input data.
For gradient descent (GD),
```python
def gradient_descent(loss, w, T, X, eta):
    :param loss: the loss function
    :param w: trainable parameters
    :param T: iterations to train
    :param X: data points
    :param eta: the learning rate
    for t in range(T):
        gradient_sum = []
        for x in X:
            cur_gradient = loss.subgradient(w, x)
            gradient_sum = element_wise_add(gradient_sum, cur_gradient)
        gradient = gradient_sum/X.size()
        w = w - eta * gradient
    return w
```
Note that in order to show the main difference with later SGD algorithm, above code snippet is not optimized (i.e. vectorized).

For stochastic gradient descent (SGD), 
```python
def stochastic_gradient_descent(loss, w, T, X, eta):
    :param loss: the loss function
    :param w: trainable parameters
    :param T: iterations to train
    :param X: data points
    :param eta: the learning rate
    for t in range(T):
        x = rand_choose(X)
        cur_gradient = loss.subgradient(w, x)
        w = w - eta * gradient
    return w
```
As we could see from above 2 pseudo code snippets, the key difference is the SGD randomly chooses a data point to optimize, while the GD optimize on the whole dataset. As a result, the time complexity of GD and SGD are $\mathcal{O}(TN)$
(without considering vectorization) and $\mathcal{O}(T)$, respectively. Both implementations are simple and easily understood. 

# Analysis
This part analyses the convergence rate of the 2 algorithms mathematically. Since nonconvex optimization problems are extremely complex (NP-hard), we only discuss convex optimization here, which assumes the loss functions are convex.
The simplest case is that loss function $f(\mathbf{x})$ is $\gamma$-well-conditioned (which means the function is both $\alpha$-strongly convex and $\beta$-smooth).

## Gradient Descent
Set $h_t = f(\mathbf{x}_t) - f(\mathbf{x}^{\*})$, where $\mathbf{x}^\*$ is the (unknown) optimal point. we will show that for unconstrained minimization: 

$$h_{t+1} \leq h_{1}e^{-\gamma t}$$

in which $\eta_t = \frac{1}{\beta}$.

According to strongly convexity, for any $\mathbf{x}, \mathbf{y} \in \mathcal{K}$:
$$
\begin{align}
f(\mathbf{y}) & \geq f(\mathbf{x}) + \nabla f(\mathbf{x})^\top (\mathbf{y}-\mathbf{x}) + \frac{\alpha}{2} \Vert\mathbf{x} - \mathbf{y}\Vert^2 \\\
& \geq \min_{\mathbf{z}}\Bigl\\{f(\mathbf{x}) + \nabla f(\mathbf{x})^\top (\mathbf{z}-\mathbf{x}) + \frac{\alpha}{2} \Vert\mathbf{x} - \mathbf{z}\Vert^2\Bigr\\} \\\
& = f(\mathbf{x}) - \frac{1}{2\alpha}\Vert\nabla f(\mathbf{x})\Vert^2
\end{align}
$$

In particular, take $\mathbf{x} = \mathbf{x}\_t$ and $\mathbf{y} = \mathbf{x}^\*$,

$$
\nabla f(\mathbf{x}\_t) \geq 2\alpha(f(\mathbf{x}\_t) - f(\mathbf{x}^\*)) = 2\alpha h_t
$$

Meanwhile, according to the $\beta$-smoothness,

$$
\begin{align}
h\_{t+1} - h\_t & = f(\mathbf{x}\_{t+1}) - f(\mathbf{x}\_t) \\\
& \leq \nabla f(\mathbf{x}\_t)^\top (\mathbf{x}\_{t+1} - \mathbf{x}\_{t}) + \frac{\beta}{2}\Vert \mathbf{x}\_{t+1} - \mathbf{x}\_t\Vert^2 \\\
& = -\eta\_t \Vert \nabla f(\mathbf{x}\_t) \Vert^2 + \frac{\beta}{2} \eta\_t^2 \Vert \nabla f(\mathbf{x}\_t) \Vert^2 \\\
& = - \frac{1}{2\beta}\Vert \nabla f(\mathbf{x}\_t) \Vert^2 \\\
& \leq -\frac{\alpha}{\beta}h\_t
\end{align}
$$

Thus,

$$h\_{t+1} \leq h\_{t}(1-\frac{\alpha}{\beta} \leq \cdots \leq h\_{1}(1-\gamma)^t \leq h\_{1}e^{-\gamma t} \tag{2} \label{eq:2}$$

In order to make it comparable with later SGD analysis, we compute the *regret* $R\_T = \sum\_{t=1}^T f(\mathbf{x}\_t) - \min_{x^\* \in \mathcal{K}}\sum\_{t=1}^T f(\mathbf{x}^\*) = \sum\_{t=1}^T h\_t$, according to $\ref{eq:2}$, 

$$R\_T \leq \frac{h\_1}{e^\gamma - 1} (e^{-\gamma T} - 1) = \mathcal{O}(e^{-\gamma T})$$


## Stochastic Gradient Descent
SGD is an online optimizer, we use *regret* as measurement. Different with former mentioned formula, SGD's regret is written as:

$$R\_T = \sum\_{t=1}^T f\_t(\mathbf{x}\_t) - \min\_{\mathbf{x}^\* \in \mathcal{K}} \sum\_{t=1}^T f_t(\mathbf{x}^\*)$$

in which the fuction $f\_t({\mathbf{x}})$ is different at each iteration since $\mathbf{x}$ are randomly chosed in each iteration in this algorithm. We can prove that 

$$
R\_T \leq \frac{3}{2}GD\sqrt{T}
$$
where $G$ is the lipschitz constant and $D$ is the diameter of decision set.

The 2 algorithms reprensents 2 different optimization schemes: offline optimization (GD) and online optimization (SGD).


# Summary

# Reference
[1] E. Hazan, “Introduction to Online Convex Optimization,” Found. Trends® Optim., vol. 2, no. 3–4, pp. 157–325, 2016.