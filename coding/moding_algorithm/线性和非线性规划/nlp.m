A = [0 0 -1 0 0; 1 0 1 0 0; 0 -1 -1 -2 0]; % 线性不等式约束系数矩阵
b = [0 30 0];                              % 线性不等式约束常数矩阵
Aeq = [1 1 0 0 0];                         % 线性等式约束系数矩阵
beq = [0];                                 % 线性等式约束常数矩阵
x0 = [2 -2 3 1 1];                         % 初始条件                     
lb = [-50 -50 -50 -50 -50];                % 下界
ub = [50 50 50 50 50];                     % 下界
MaxValue = 10e9;

% 提高计算次数上限
options = optimoptions('fmincon','Display','iter','Algorithm','sqp', 'MaxFunctionEvaluations',MaxValue);

[tar_x, tar_val] = fmincon(@tar_fun, x0, A, b, Aeq, beq ,[], [], @nonlcon, options); % 调用 fmincon 函数