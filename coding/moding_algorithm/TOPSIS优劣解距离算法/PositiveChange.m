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