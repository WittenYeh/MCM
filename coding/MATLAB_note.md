# MATLAB 命令行使用

## MATLAB 命令行使用

命令行窗口：使用提示符 `>>` 表示

## 变量创建
- 创建变量：`>> a = 1` / `c = a + b` /  `d = cos(a)`
  - 变量不需要声明，第一次出现的变量都会自动分析类型进行创建
  - 如果不希望再在终端显示创建的结果，可以使用 `a = 1;` (加上分号)
- 直接调用算式输出结果：`>> a * b` 或 `>> sin(a)`，在这种情况下会自动创建一个叫做`ans`的变量

## 矩阵和数组

- 数组创建：

  - MATLAB 中，数组被认为是一个行向量
    
    ```>> a = [1 2 3 4]```
    
    $$
        \begin{pmatrix}
        1&2&3&4
        \end{pmatrix}
    $$

- 矩阵创建：
  
  - 使用逐个指定元素的方法
  
    ```>> a = [1 3 5; 2 4 6; 7 8 10]```
    
    $$
        \begin{pmatrix}
        1&3&5\\
        2&4&6\\
        7&8&10
        \end{pmatrix}
    $$

  - 使用批量指定元素方法：函数`ones`、`zeros`、`rand`，第一个参数是行数，第二个参数是列数
  
    ```>> ones(3，4)```
    
    ![](images/ones1.png)

    ```>> rand(3,4)```

    ![](images/rand1.png)
    
## MATLAB 运算符号

> 参考自：https://www.yiibai.com/matlab/matlab_operators.html

![](images/op1.png)


    