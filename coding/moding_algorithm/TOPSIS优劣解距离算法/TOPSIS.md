#! https://zhuanlan.zhihu.com/p/545071388
# 优劣解距离算法（TOPSIS）

## （一）GUIDANCE

### 1.1 适用范围

全称 “Technique for Order Preference by Similarity to Ideal Solution”，即“逼近理想解排序法”

该算法主要用于解决评价类问题，用于确定各个方案层的最终得分

优点在于能充分利用原始数据的信息， 其结果能精确地反映各评价方案之间的差距。

TOPSIS 和 AHP 的主要差异在于相关功能和适用问题范围的差异
- TOPSIS 更加适用于解决原始数据相当充分几乎可以进行定量分析的情景
- AHP 算法更加适用于已知条件较为模糊和复杂，难于完全定量分析的情景

> 事实上，优劣解距离算法和层次分析法可以结合

### 1.2 主要原理

TOPSIS 的核心原理主要是“指标正向化”方法与“标准化消除量纲影响”方法两个方法的合理性，事实上，这两个方法也是 TOPSIS 和 AHP 的主要区别

幸运的是，这两个方法的合理性并不需要我们长篇大论地证明，只需要我们使用合理的语言在使用时稍加阐述即可，严格的证明已经由运筹学家解决

## （二）模型步骤

### 2.1 将明确获取的指标整合成表格

我们依然采用层次分析法的例子，不同的是，这次，我们的所有要素都有非常准确的数据来源（假设这些数据都已经被我们获取）

- “健康指数”数据由相关专业研究人员评定
- “价格”数据是以人民币为单位的绝对数值
- “距离”数据经过精确测量得到
- “咸淡程度”数据由食物含盐量精确测定
- “等待时间”数据由RUC小喇叭上学生反馈的平均等待时间确定

将这些信息整理成表格如下：

| 餐厅名称 | 餐厅得分(待求值) | 价格 | 健康指数 | 距离 | 咸淡程度 | 等待时间 |
| -------- | ---------------- | ---- | -------- | ---- | -------- | -------- |
| 东区二楼 |                  | 16   | 90       | 1.31 | 53       | 5.21     |
| 西区一楼 |                  | 10   | 83       | 0.45 | 66       | 3.45     |
| 中区二楼 |                  | 13   | 83       | 1.34 | 34       | 4.03     |

### 2.2 对表格中的数据进行正向化处理

我们发现表格中的数据并不完全是同一类型的数据

事实上，TOPSIS 中用到的数据可以被我们分为四种：
- 极大型指标：指标越大越好
- 极小型指标：指标越小越好
- 中间型指标：指标越接近某个值越好
- 区间型指标：指标处在某个区间内最好，区间外的越靠近这个区间越好

> 比如上面的例子，健康指数是极大型指标，价格、距离和等待时间是极小型指标，而咸淡程度则是区间型数据

下面，我们给出统一指标类型的方法——将所有指标都转成极大型指标，即正向化处理

1. 对于极小型指标

找出这组数据的最大值 $x_{max}$ ，每个数据 $x_i$ 对应的正向化以后的指标就是 $x_{max} - x_i$

2. 对于中间型指标

列出这组数据和中间型指标的差值，这个差值就是一组极小型指标，采用 1 中的处理方法进行类似的处理，最后做一步**区间赋分处理**

假设正向化处理的函数为 `positiveChange`，则处理的公式为：

$$
    d_{max} = max\{|x_i - x_{best}|\},\forall i = 1,2,\dots ,n    
$$

$$
     positiveChange(x) =  \frac{d_{max} - |x-x_{best}|}{d_{max}}      
$$

3. 对于区间型指标

如果数据处于区间内，则直接赋予最大值，即 1

如果数据位于区间外，则计算数据和区间边界的距离

设区间为 $[a,b]$ ，我们将计算过程分成下面的几步：

- 求出所有数据和区间边界的最大距离 $d_{max}$

$$d_{max} = max(a - min\{x_i\},max\{x_i\}-b),\forall i = 1,2,\dots,n $$

- 求出每点和区间边界的距离 `d(x)`，代入公式计，假设正向化处理的函数为 `positiveChange`

$$
    d(x) = 
    \begin{cases}
    a - x,\quad x < a\\
    x - b, \quad x > b
    \end{cases}
$$

$$
    positiveChange(x) = 
    \begin{cases}
    1,\quad x \in [a, b]\\
    \frac{d_{max} - d(x)}{d_{max}}, \quad x \notin [a,b]
    \end{cases}
$$

### 2.3 对表格中的数据进行标准化处理

在进行正向化处理之后，我们得到了增长意义统一（类型）的一组数据

然而，在统一意义之后，还应该进行统一的是单位：对于单位我们采用标准化处理的统一方法

标准化方法是，假设方案 $1,2,3,\dots,n$ 的在同一个因素评价得分分别是 $a_1,a_2,\dots,a_n$

那么进行标准化以后他们的得分变为 $b_1,b_2,\dots,b_n$ ，应该满足：

$$b_i = \frac{a_i}{\sqrt{\sum_{k=1}^na_k^2}}$$

首先我们将表格数据罗列成正向化矩阵，其中同一列表示同一因素评价下各方案的得分，同一行表示同一方案下不同因素的得分情况，假设一共有 $m$ 个因素和 $n$ 个方案，则

假设原矩阵（正向化后）为：

$$  
\begin{pmatrix}
    x_{11}&x_{12}&\cdots&x_{1m}\\
    x_{21}&x_{22}&\cdots&x_{2m}\\
    \vdots&\vdots&\ddots&\vdots\\
    x_{n1}&x_{n2}&\cdots&x_{nm}
\end{pmatrix}
$$

将这个矩阵进行标准化后为：

$$  
\begin{pmatrix}
    z_{11}&z_{12}&\cdots&z_{1m}\\
    z_{21}&z_{22}&\cdots&z_{2m}\\
    \vdots&\vdots&\ddots&\vdots\\
    z_{n1}&z_{n2}&\cdots&z_{nm}
\end{pmatrix}
$$

同理应该满足$z_{ij} = \frac{x_{ij}}{\sqrt{\sum_{i=1}^nx_{ij}^2}} , \forall j = 1,2,\dots,m$

### 2.4 对不同指标赋予一定的权重（可选）

我们还可以使用层次分析法对不同权重的重要程度作出分析，具体参见 `AHP.md` ， 假设已经通过分析得到这些要素的权重分别为 $w_1,w_2,\dots,w_m$

### 2.5 根据指标权重和表格数据给出最终得分

经过上述过程，我们现在已经得到了标准化后的矩阵了，即

$$  
\begin{pmatrix}
    z_{11}&z_{12}&\cdots&z_{1m}\\
    z_{21}&z_{22}&\cdots&z_{2m}\\
    \vdots&\vdots&\ddots&\vdots\\
    z_{n1}&z_{n2}&\cdots&z_{nm}
\end{pmatrix}
$$

现在我们还要经过一步处理得到最终的得分，在列出公式之前还是应该提醒一下：

同一列表示同一因素评价下各方案的得分，同一行表示同一方案下不同因素的得分情况，假设一共有 $m$ 个因素和 $n$ 个方案

我们整合出一个最大值向量：它包含了 $m$ 个分量，表示这 $m$ 个因素的最大指标，即：

$$
    Z^{max} = (\underbrace{max\{z_{11},z_{21},\cdots,z_{n1}\},max\{z_{12},z_{22},\cdots,z_{n2}\},\cdots,max\{z_{1m},z_{2m},\cdots,z_{nm}\}}_{共 m 个分量})
$$

同理，我们也可以定义最小值向量

$$
    Z^{min} = (\underbrace{min\{z_{11},z_{21},\cdots,z_{n1}\},min\{z_{12},z_{22},\cdots,z_{n2}\},\cdots,min\{z_{1m},z_{2m},\cdots,z_{nm}\}}_{共 m 个分量})
$$

我们知道任意一行向量表示一个方案的所有因素的得分

第 $i$ 个方案对应的行向量（各因素得分）为 $z_{i1},z_{i2},\cdots,z_{im}$，我们可以定义这个方案和最大值向量的距离

$$
    D^{from-max}_i = \sqrt{\sum^{m}_{j=1}(Z^{max}_j-z_{ij})^m} \quad,\quad \forall i = 1,2,\cdots,n 
$$

同理我们也可以定义这个方案对应的行向量（各因素得分）和最小值向量的距离

$$
    D^{from-min}_i = \sqrt{\sum^{m}_{j=1}(Z^{min}_j-z_{ij})^m} \quad,\quad \forall i = 1,2,\cdots,n 
$$

> 值得注意的是，我们上面两个公式的计算是默认每个因素之间重要程度的比值为 $w_1:w_2:\cdots:w_n = 1:1:\cdots :1$ 的，如果我们根据一些方法（如 AHP 、熵权法 etc.）得到了不同因素的权重，那么上面两个公式应该改成：
>
> $$ D^{from-max}_i = \sqrt{\sum^{m}_{j=1}w_j(Z^{max}_j-z_{ij})^m} \quad,\quad \forall i = 1,2,\cdots,n $$
> $$ D^{from-min}_i = \sqrt{\sum^{m}_{j=1}w_j(Z^{min}_j-z_{ij})^m} \quad,\quad \forall i = 1,2,\cdots,n $$

这样，我们可以计算出这个方案的得分，设第 $i$ 行对应的方案的得分为 $s_i$，应该有

$$
    s_i = \frac{D^{from-min}_i}{D^{from-min}_i+D^{from-max}_i}
$$

可以用下面的图表示

<center><img src = /images/1.png width = 55%></center>

使用和层次分析法一样的归一化方法，即可得到最终得分，进而得到最终排名

### 2.6 步骤总结

1. 将明确获取的指标整合成表格（行是方案，列是因素）
2. 对表格中的数据进行正向化处理
3. 对表格中的数据进行标准化处理（统一单位）
4. 对不同指标赋予一定的权重（可选）
5. 根据指标权重和表格数据给出最终得分

## （三）代码实现

- 主代码部分

```m
clc, clear;

%% 第一步：读取矩阵的内容
data = readmatrix('TOPSIS.xls');
[n,m] = size(data);
disp(['您一共输入了 ', num2str(n), ' 个待评价对象, ', '一共有 ', num2str(m),' 个评价因素']);
needToPositiveChange = input(['这 ',num2str(m),' 个因素是否需要先经过正向化处理，需要请输入1，不需要请输入0：']);

%% 第二步：对需要进行正向化的列进行正向化
if needToPositiveChange == 1   % 表示需要正向化
    pos = input(['请以数组的形式输入需要正向化处理的因素所在的列，例如第1，2，3列需要处理，就输入[1,2,3]：']);
    PositiveChangeType = input('请以数组形式依次输入需要处理的这些列的指标类型（1：极小型；2：中间型；3：极大型）：');
    for i = 1:size(pos,2)
        % PositiveChange 是我们自定义的一个函数
        % 第一个参数接受一个数组，代表一个因素下的所有方案的评分
        % 第二个参数接受一个数，代表一个因素的指标类型
        % 第三个参数接受一个数，代表这个因素在原始矩阵中的列数
        data(:,pos(i)) = PositiveChange(data(:,pos(i)), PositiveChangeType(i), pos(i));  % 将原始矩阵的相列进行正向化
    end
    disp('正向化后的矩阵为：');
    disp(data);
end

%% 第三步：将正向化后的矩阵标准化
% repmat 函数用于将数组等价拷贝 n 次构成矩阵
standard_data = data./repmat(sum(data .* data).^0.5 , n, 1);
disp('标准化后的矩阵为：');
disp(standard_data);

%% 第四步：分别计算出和最大向量与最小向量之间的距离，得出评分

% 下面一行代码求出各方案和最大值向量之间的距离
d_from_max = sum([(standard_data - repmat(max(standard_data), n, 1)) .^ 2], 2) .^ 0.5;
% 下面一行代码求出各方案和最小值向量之间的距离
d_from_min = sum([(standard_data - repmat(min(standard_data), n, 1)) .^ 2], 2) .^ 0.5;
% 计算出得分
scores = d_from_min ./ (d_from_min + d_from_max);
% 进行归一化
standard_scores = scores / sum(scores);
% 降序排序，得到索引
[sorted_standard_scores, scores_index] = sort(standard_scores, 'descend');

disp('最后的得分如下：');
disp(standard_scores); % 显示得分
disp('排名索引如下：');
disp(scores_index);
```

- 正向化转换函数  `PositiveChange` 函数代码

```m
function [changed_data] = PositiveChange(data, type, pos)
    if type == 1
       disp('您输入的第 ', num2str(pos), ' 列是极小型');
       changed_data = max(data) - data;
       disp('----------------------------------------------------------');
    elseif type == 2
       disp('您输入的第 ', num2str(pos), ' 列是中间型');
       best = input('请输入它的最优值：');
       maxD_from_best = max(abs(data - best));
       changed_data = 1 - abs(data - best)/maxD_from_best;
       disp('----------------------------------------------------------');
    elseif type == 3
       disp('您输入的第 ', num2str(pos), ' 列是区间型');
       low = input('请输出区间的下界');
       high = input('请输出区间的上界');
       maxD_from_inter = max([low - min(data), max(data) - high]);
       datasize = size(data, 1);
       changed_data = zeros(datasize, 1);
       for i = 1:datasize
           if data(i) < low
               changed_data(i) = 1 - (low - data(i))/maxD_from_inter;
           elseif data(i) > high
               changed_data(i) = 1 - (data(i) - high)/maxD_from_inter;
           else
               changed_data(i) = 1;
           end
       end
       disp('----------------------------------------------------------');
    else
       disp('请确保输入数据的是 1，2，3 中的其中一个');
    end
end
```