function [fitresult, gof] = fit_test2(x_sample, y_sample, z_sample)
%CREATEFIT(X_SAMPLE,Y_SAMPLE,Z_SAMPLE)
%  创建一个拟合。
%
%  要进行 '傅里叶拟合2' 拟合的数据:
%      X 输入: x_sample
%      Y 输入: y_sample
%      Z 输出: z_sample
%  输出:
%      fitresult: 表示拟合的拟合对象
%      gof: 带有拟合优度信息的结构体

%% 拟合: '傅里叶拟合2'。
[xData, yData, zData] = prepareSurfaceData( x_sample, y_sample, z_sample );

% 设置 fittype 和选项。
ft = 'linearinterp';

% 对数据进行模型拟合。
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% 为绘图创建一个图窗。
figure( 'Name', '傅里叶拟合2' );

% 绘制数据拟合图。
subplot( 2, 1, 1 );
h = plot( fitresult, [xData, yData], zData );
legend( h, '傅里叶拟合2', 'z_sample vs. x_sample, y_sample', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'x_sample', 'Interpreter', 'none' );
ylabel( 'y_sample', 'Interpreter', 'none' );
zlabel( 'z_sample', 'Interpreter', 'none' );
grid on

% 绘制残差图。
subplot( 2, 1, 2 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Residual' );
legend( h, '傅里叶拟合2 - 残差', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'x_sample', 'Interpreter', 'none' );
ylabel( 'y_sample', 'Interpreter', 'none' );
zlabel( 'z_sample', 'Interpreter', 'none' );
grid on


