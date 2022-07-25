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
