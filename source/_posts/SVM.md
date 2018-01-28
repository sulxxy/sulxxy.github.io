title: Support Vector Machine
date: 2018-01-23 21:13:11
tag: [Machine Learning]
category: Machine_Learning
mathjax: true
---


# Maximum Margin Classifier
Let us start from the simplest situation: 2-class classification problem using linear models with the form:
$$ \mathcal{y}(\mathbf{x}) = \mathbf{w}^\top \mathcal{x} + b \label{eq:1}\tag{1}$$
The training set data comprises $N$ input vectors $\mathbf{x\_1}$, ..., $\mathbf{x\_N}$, with corresponding labels $\mathcal{t}\_1$, ..., $\mathcal{t}\_N$, where $\mathcal{t\_n} \in \\{-1, 1\\}$.
<!-- more -->

We shall assume that the training set is linearly separable now, then there must exist at least one choice of the parameter $\mathbf{w}$ and $b$ such that the data points could be split into 2 parts. In support vector machines, the decision boundary is the one for which the margin is maximized. Margin is the smallest distance between the decision boundary and any of the samples. 

Now we know: the distance of a point $\mathbf{x}\_n$ to the decision surface is(*todo*: explaination here): 
$$ \frac{\mathcal{t}\_n\mathcal{y}(\mathbf{x}\_n)}{\Vert{\mathbf{w}}\Vert} = \frac{\mathcal{t}\_n(\mathbf{w}^\top \mathbf{x}\_n + b)}{\Vert \mathbf{w}\Vert} \label{eq: 2} \tag{2}$$

The margin is given by the perpendicular distance to the closest point $\mathbf{x}\_n$ from the data set and we wish to find a $\mathbf{w}$ and $b$ such that we got maximum distance. Thus the maximum margin solution is found by solving:
$$ \underset{\mathbf{w}, b}{\arg\max} \, \Bigl\\{\frac{1}{\Vert \mathbf{w}\Vert}\min\_{\mathcal{n}} \, \bigl[{\mathcal{t}\_n(\mathbf{w}^\top \mathbf{x}\_n + b)}\bigr]\Bigl\\} \label{eq: 3} \tag{3}$$

We could solve ($\ref{eq: 3}$) using Lagrange multipliers, but we need do some conversion before that. It is not hard to find that if we rescale $\mathbf{w} \to \mathcal{k}\mathbf{w}$ and $ b \to \mathcal{k}b$, the distance from any point $\mathbf{x}\_n$ to the decision surface, given by $\frac{\mathcal{t}\_n\mathcal{y}(\mathbf{x}\_n)}{\Vert \mathbf{w} \Vert} $ is unchanged. So we are free to set
$$ {\mathcal{t}\_n(\mathbf{w}^\top \mathbf{x}\_n + b)} = 1 \label{eq:4} \tag{4}$$
for the point that is closest to the surface. In this case, all the points will satisfy the constraint:
$$ {\mathcal{t}\_n(\mathbf{w}^\top \mathbf{x}\_n + b)} \geq 1, \quad n=1,2, \ldots, N. \label{eq:5} \tag{5}$$

So now the optimization probelm simply requires that we maximize ${\Vert \mathbf{w} \Vert}^{-1}$, which is equivalent to minimizing ${\Vert \mathbf{w} \Vert}^2$. So we have to solve the problem:
$$ \underset{\mathbf{w}, b}{\arg\min} \, \frac{1}{2}{\Vert \mathbf{w} \Vert}^2 \label{eq:6} \tag{6}$$
subject to the contraints given by ($\ref{eq:5}$). This is called **primal problem**, $\mathbf{w}, b$ are the primal variables.

As I said, we can use Lagrange multipliers to solve this problem. We indroduce Lagrange mulitpliers vector $\mathbf{a} = (a\_1, a\_2, \ldots, a\_N)^\top, a\_n \geq 0$, each $a\_n$ corresponding each of the constraints in $\ref{eq:5}$. Now we have the Lagrangian function:
$$ \mathcal{L}(\mathbf{w}, b, \mathbf{a}) = \frac{1}{2}{\Vert \mathbf{w} \Vert}^2 - \sum\_{n=1}^N \, a\_n \, \bigl\\{ {\mathcal{t}\_n(\mathbf{w}^\top \mathbf{x}\_n + b)} - 1\bigl\\} \label{eq:7}\tag{7}$$

This is called **dual problem**. To solve ($\ref{eq:7}$), we need to set the derivatives of $\mathcal{L}(\mathbf{w}, b, \mathbf{a})$ w.r.t. the primal variables $\mathbf{w}, b$ to zeros first. So we got:
$$ \mathbf{w} = \sum\_{n=1}^N \, a\_nt\_n\mathbf{x}\_n \label{eq:8}\tag{8}$$
$$ 0 = \sum\_{n=1}^N \, a\_nt\_n \label{eq:9}\tag{9} $$

put ($\ref{eq:8}, \ref{eq:9}$) into $\mathcal{L}(\mathbf{w}, b, \mathbf{a})$, we could eliminate $\mathbf{w}, b$, and now we need to maximize:
$$ \tilde{\mathcal{L}}(\mathbf{a}) = \sum\_{n=1}^N \, a\_n - \frac{1}{2} \sum\_{n,m=1}^N \, a\_na\_mt\_nt\_m\mathbf{x}\_n^\top\mathbf{x}\_m \label{eq:10}\tag{10}$$
w.r.t. $\mathbf{a}$, s.t. the constraints:
$$ a\_n \geq 0, \quad n = 1, \ldots, N. \label{eq:11} \tag{11} $$
$$ \sum\_{n=1}^N \, a\_nt\_n = 0 \label{eq:12} \tag{12} $$

## todo
1. how solve quadratic programming problem.
2. soft margin
4. Kernel tricks
5. Multiclass SVC
3. SVR
5. $\nu$-SVR

# Summary

# Reference
1. Bishop: Pattern Recognition and Machine Learning, Springer-Verlag, 2006
2. 李航：统计学习方法，清华大学出版社，2012

# related Articles
0. Bayesian Theory
1. K-means
