function y_output = LI(x, y, x_input)
% Lagrange_Interpolate
% 样本点数据以数组 x , y 输入，插值点以数组 input_x 输入，输出数组output_y为插值。
size_x = length(x);
size_x_input = length(x_input);
y_output = zeros(size_x_input);

for i = 1 : size_x_input
    z = x_input(i);
    s = 0.0;
    for k = 1 : size_x
        p = 1.0;
        for j = 1 : size_x
            if j ~= k
            p = p * (z - x(j))/(x(k) - x(j));
            end
        end
        s = p*y(k) + s;
    end
    y_output(i) = s;
end