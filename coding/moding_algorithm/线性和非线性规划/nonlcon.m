function [c, ceq] = nonlcon(x)
    c = x(2) ^ 2 - x(3) ^ 3 + x(4) ^ 2 - 2;        % 不等式条件
    ceq = exp(sin(x(1))) + 2 * exp(cos(2 * x(5))); % 等式条件
end