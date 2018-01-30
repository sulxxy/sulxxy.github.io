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
Now, as we could see, ($\ref{eq:10}$) is still a quadratic programming problem, but it is easier then ($\ref{eq:6}$) since only 1 variable left. This can be solved using **Sequential Minimal Optimization (SMO)** algorithm. Since it will take a long page to introduce this algorithm, I put it in another post: [Sequential Minimal Optimization Algorithm](http://liuzhiwei.me/SMO).
Now assuming we have already got the optimized $\mathbf{a}$ through SMO algorithm, saying $\mathbf{a}^\*$. In order to classify new data points, we evaluate the sign of $\mathcal{y}(\mathbf{x})$ defined by ($\ref{eq:1}$). Considered ($\ref{eq:8}$), we have:
$$ \mathcal{y}(\mathbf{x}) = \sum\_{n=1}^N \, a\_n^\*y\_n\mathbf{x}\_n^\top\mathbf{x} + b \label{eq:13} \tag{13} $$
We shall notice that $a\_n^\*$ is the Lagrangian multiplier in ($\ref{eq:7}$), and each $a\_n^\*$ corresponds to one data point $(\mathbf{x}\_n, y\_n)$. 
We also need to know that a constrained optimization of this form satisfies the KKT conditions, in which the following properties hold:
$$ a\_n^\* \geq 0 \label{eq:14} \tag{14} $$
$$ t\_n\mathcal{y}(\mathbf{x}\_n) -1 \geq 0 \label{eq:15} \tag{15} $$
$$ a\_n^\* \bigl\\{t\_n\mathcal{y}(\mathbf{x}\_n) - 1\bigr\\} = 0 \label{eq:16} \tag{16} $$
That is to say, for each data point $(\mathbf{x}\_n, \mathcal{y}\_n)$, either $a\_n^\* = 0$ or $ t\_n\mathcal{y}(\mathbf{x}\_n) - 1 = 0 $ satisfied. Any points for which $a\_n^\* = 0$ will not appear in the sum in ($\ref{eq:13}$) and hence play no role in making prediction. On the other hand, the rest points will affect the prediction. Those points are called *support vectors*. And because $ t\_n\mathcal{y}(\mathbf{x}\_n) - 1 = 0 $ satisfied, they lie on the maximum margin hyperplanes in feature space. 
Also noting that $ t\_n\mathcal{y}(\mathbf{x}\_n) - 1 = 0 $ and ($\ref{eq:13}$), we have:
$$ t\_n \Bigl( \sum\_{m \in S} \, a\_m t\_m \mathbf{x}\_m^\top\mathbf{x}\_n + b \Bigr) = 1 \label{eq:17} \tag{17} $$
in which $S$ is the set of indices of support vectors.
While we can choose a random $n$ to obtain $b$, a more stable way is first multiplying through by $t\_n$, making use of $t\_n^2 = 1 $, and then averaging these equations over all support vectors and solving for $b$ to give:
$$ b = \frac{1}{N\_S}\sum\_{n \in S} \, \Bigl(t\_n - \sum\_{m \in S} \, a\_m t\_m \mathbf{x}\_m^\top\mathbf{x}\_n \Bigr) \label{eq:18} \tag{18} $$
where $N\_S$ is the total number of support vectors.

## Kernel tricks
You may already notice that there are always the term $\mathbf{x}\_n^\top\mathbf{x}$ or $\mathbf{x}\_m^\top\mathbf{x}\_n$, such as in ($\ref{eq:10}, \ref{eq:13}, \ref{eq:17}, \ref{eq:18}$), we can replace them using kernel functions, let's say: $\mathcal{k}(\mathbf{x}\_n, \mathbf{x}\_m)$ or $\mathcal{k}(\mathbf{x}, \mathbf{x}\_n)$. Also we need to define a feature space transformation for the input data $\mathbf{x}$ in ($\ref{eq:1}$), denoting as $\phi(\mathbf{x})$. So ($\ref{eq:1}$) becomes:
$$ \mathcal{y}(\mathbf{x}) = \mathbf{w}^\top \phi(\mathcal{x}) + b \label{eq:19}\tag{19}$$
More details can be found in the post [Kernel Methods](http://liuzhiwei.me/Kernel_Methods). And in the later discussion, I will use ($\ref{eq:19}$) instead of ($\ref{eq:1}$) since kernel version is more general.

# Soft Margin
In the previous discussion, we assumed that the training points are linearly separable in the feature space $\phi(\mathbf{x})$. In practice, however, the class-conditional distributions may overlap. In this case, if we still try to find the exact separation, the result might lead to overfitting and poor generalization.
To avoid this, the support vector machines should allow some of training data points to be misclassified. To do this, we introduce *slack variables*, denoted as $\xi\_n \geq 0$ where $n = 1, \ldots, N$, one slack variable corresponds one training data point. These are defined by $\xi\_n = 0$ for data points that are on or inside the correct margin boundary and $\xi\_n = \vert t\_n - y(\mathbf{x}\_n)\vert$ for the other points. Thus for the data points lying on the decision boundary $\mathcal{y}(\mathbf{x}\_n) = 0 $ will have $\xi\_n = 1 $, and points with $\xi\_n \gt 1$ will be misclassified. Thus the classification constraints are:
$$ t\_n\mathcal{y}(\mathbf{x}\_n) \geq 1 - \xi\_n, \quad n=1, \ldots, N. \label{eq:20} \tag{20} $$
in which the slack variables are with contraints $\xi\_n \geq 0$. From ($\ref{eq:20}$) we know that:
* for the points with $\xi\_n = 0 $: they lie on the margin or on the correct side of margin
* for the points with $0 \lt \xi\_n \lt 1$: they lie inside the margin but on the right side of decision boundary
* for the points with $\xi\_n = 1$: they exactly lie on the decision boundary
* for the points with $\xi\_n \gt 1$: they are misclassified

So now we need to minimize:
$$ C\sum\_{n=1}^{N} \, \xi\_n + \frac{1}{2} {\Vert \mathbf{w} \Vert}^2 \label{eq:21}\tag{21} $$
subject to the constraints:
$$ t\_n\mathcal{y}(\mathbf{x}\_n) \geq 1 - \xi\_n, \quad n=1, \ldots, N. \label{eq:22} \tag{22} $$
$$ \xi\_n \geq 0 \label{eq:23} \tag{23} $$
in which $C \gt 0$ controls the trade-off between the slack variable penalty and the margin. Notice that if $C \to \infty$, we will be back to the earlier support vector machine for separable data since the points misclassified or inside margin will be given a large penalty coefficient.
So now we need to minimize ($\ref{eq:21}$) subject to constraints ($\ref{eq:22}, \ref{eq:23}$). Similarly, we also use Lagrange multipliers to solve this problem. The  corresponding Lagrangian is:
$$ \mathcal{L}(\mathbf{w}, b, \mathbf{\xi}, \mathbf{a}, \mathbf{\mu}) = \frac{1}{2}{\Vert \mathbf{w} \Vert}^2 + C \sum\_{n=1}^N\xi\_n - \sum\_{n=1}^{N}a\_n\bigl\\{t\_n\mathcal{y}(\mathbf{x}\_n) - 1 + \xi\_n\bigr\\} - \sum\_{n=1}^{N}\mu\_n\xi\_n \label{eq:24} \tag{24} $$
where $\\{a\_n \geq 0\\}$ and $\\{\mu\_n \geq 0\\}$ are the Lagrange mulitpliers and $\mathbf{w}, b, \\{\xi\_n\\}$ are the primal variables. The KKT conditions are:
$$ a\_n \geq 0 \label{eq:25} \tag{25} $$
$$ t\_n\mathcal{y}(\mathbf{x}\_n) - 1 + \xi\_n \geq 0 \label{eq:26} \tag{26} $$
$$ a\_n\bigl(t\_n\mathcal{y}(\mathbf{x}\_n) - 1 + \xi\_n\bigr) = 0 \label{eq:27} \tag{27} $$
$$ \mu\_n \geq 0 \label{eq:28} \tag{28} $$
$$ \xi\_n \geq 0 \label{eq:29} \tag{29} $$
$$ \mu\_n\xi\_n = 0 \label{eq:30} \tag{30} $$
where $n=1,\ldots,N$.

Now we need to set the partial derivatives w.r.t. the primal variables ($\mathbf{w}, b, \\{\xi\_n\\}$) in ($\ref{eq:24}$) to zeros. Then we got:
$$ \frac{\partial \mathcal{L}}{\partial \mathbf{w}} = 0 \Rightarrow \mathbf{w} = \sum\_{n=1}^{N}a\_nt\_n\phi(\mathbf{x}\_n) \label{eq:31} \tag{31} $$
$$ \frac{\partial \mathcal{L}}{\partial b} = 0 \Rightarrow \sum\_{n=1}^{N}a\_nt\_n = 0 \label{eq:32} \tag{32} $$
$$ \frac{\partial \mathcal{L}}{\partial \xi\_n} = 0 \Rightarrow a\_n = C - \mu\_n \label{eq:33} \tag{33} $$
Now we can eliminate $\mathbf{w}, b, \\{\xi\_n\\}$ using ($\ref{eq:31}, \ref{eq:32}, \ref{eq:33}$). Then we got the dual Lagraingian:
$$\tilde{\mathcal{L}}(\mathbf{a}) = \sum\_{n=1}^{N}a\_n - \frac{1}{2}\sum\_{n=1}^N\sum\_{m=1}^N a\_n a\_m t\_n t\_m \mathcal{k}(\mathbf{x}\_n, \mathbf{x}\_m) \label{eq:34} \tag{34}$$
You may find that ($\ref{eq:34}$) is exactly same with the separable one ($\ref{eq:10}$), the difference is the constraints. Based on ($\ref{eq:28}, \ref{eq:33}$), we know that:
$$ 0 \leq a\_n \leq C, n=1,\ldots, N \label{eq:35} \tag{35} $$
Now our mission is to maximize ($\ref{eq:34}$) with respect to $\\{a\_n\\}$ subject to constraints ($\ref{eq:32}, \ref{eq:35}$). Again, we got a quadratic programming problem, see [Sequential Minimal Optimization Algorithm](http://liuzhiwei.me/SMO) for more details.
We can do some explainations on this result:
* for those points with $a\_n = 0$: they do not contribute to the prediction (see ($\ref{eq:16}$ and its explaination there)), ignore them. 
* for those points with $a\_n \gt 0$: 
    according to ($\ref{eq:27}$), we know:
    $$ t\_n\mathcal{y}(\mathbf{x}\_n) = 1 - \xi\_n \label{eq:36} \tag{36} $$
    * if $a\_n \lt C$:
        ($\ref{eq:33}$) implies $\mu\_n \gt 0$, which means $\xi\_n = 0$ based on ($\ref{eq:30}$). So this points lie on the margins.
    * if $a\_n = C$:
        if $\xi\_n \leq 1$, the points are inside margin and correctly classified.  if $\xi\_n \gt 0$, the points are misclassified.

To determine the paramter $b$, the support vectors for which $0 \lt a\_n \lt C$ have $\xi\_n = 0$ so that $t\_n\mathcal{y}(\mathbf{x}\_n) = 1 $. As a result:
$$ t\_n\Bigl(\sum\_{m \in S} a\_m t\_m \mathcal{k}(\mathbf{x}\_n, \mathbf{x}\_m) + b\Bigr) = 1 \label{eq:37} \tag{37} $$
where $S$ is the set of indices of support vectors.
similarly, the stable solution is averaging instead of randomly choosing one:
$$ b = \frac{1}{N\_{\mathcal{M}}}\sum\_{n \in \mathcal{M}} \Bigl(t\_n - \sum\_{m \in S} a\_m t\_m \mathcal{k}(\mathbf{x}\_n, \mathbf{x}\_m)\Bigr) \label{eq:38} \tag{38} $$
where $\mathcal{M}$ is the set of indices of data points having $0 \lt a\_n \lt C$.


# todo
5. Multiclass SVC
3. SVR
5. $\nu$-SVR
6. convex quadratic programming example
7. explain why we create dual problem instead of directly solving primal problem.

# Summary

# Reference
1. Bishop: Pattern Recognition and Machine Learning, Springer-Verlag, 2006
2. 李航：统计学习方法，清华大学出版社，2012

# related Articles
0. Bayesian Theory
1. K-means
