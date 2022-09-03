% 目标函数文件

% value 是一个值，即我们优化的目标
% x 是决策变量数组，在本题中一共由五个变量构成
function value = tar_fun(x)
    value = exp(sin(x(1) ^ 3 + cos(x(2)))) - log(exp(x(3)) + sin(x(4) * cos(x(5)))/log(3));
end