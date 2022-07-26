function y_output = NI(x, y, x_input)
x_size = length(x);
x_input_size = length(x_input);
dqTable = zeros(x_size,x_size);

%% 对差商表第一列赋值
for k = 1 : x_size      
    dqTable(k) = y(k);
end

%% 求差商表
for i = 2 : x_size       % 差商表从0阶开始,矩阵从1维开始存储
    for k = i : x_size
        dqTable(k, i) = (dqTable(k, i-1) - dqTable(k-1, i-1)) / (x(k) - x(k + 1 - i));  
    end
end
disp('差商表如下：');
disp(dqTable);

y_output = zeros(x_input_size);  

%% 求插值多项式
for i = 1 : x_input_size
    for k = 2 : x_size
        t = 1;
        for j = 1 : k-1
            t = t * (x_input(i) - x(j));
            % disp(t)
        end
        y_output(i) = dqTable(k,k) * t + y_output(i);
    end
    y_output(i) = dqTable(1,1) + y_output(i);
end
% disp(y_output)
end