%% 埃尔米特(Hermite)插值
% 设 n 个节点的数据以数组 x（已知样本点点的横坐标），y （已知样本点的函数值），y1（导数值）输入
% m 个插值点以数组 x 输入
% 输出数组 y 为 m个插值
function y = HI(x0,y0,y1,x);
n=length(x0);m=length(x);
for k=1:m
    yy=0.0;
    for i=1:n
        h=1.0;
        a=0.0;
        for j=1:n
            if j~=i
                h=h*((x(k)-x0(j))/(x0(i)-x0(j)))^2;
                a=1/(x0(i)-x0(j))+a;
            end
        end
        yy=yy+h*((x0(i)-x(k))*(2*a*y0(i)-y1(i))+y0(i));
    end
    y(k)=yy;
end