function y_output = PLI(x,y,x_input)
% Piecewise_Linear_Interpolate
% 该函数实现分段线性插值
% (x,y)为已知的数据点，这两个参数应该是长度一致的数组
% x_input为待插值的横坐标
% y_output为插值后的到的结果
 
sizex = length(x);
size_x_input = length(x_input);
y_output = zeros(size_x_input);

for j = 1 : size_x_input
    for i = 1 : sizex - 1
        if (x_input(j) > x(i) && x_input(j) <= x(i+1))
            y_output(j) = ((x_input(j) - x(i + 1)) / (x(i) - x(i+1))) * y(i) + (((x_input(j) - x(i))/(x(i + 1) - x(i))) * y(i + 1));
        end
    end
end