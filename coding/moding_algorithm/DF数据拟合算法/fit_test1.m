function [fitresult, gof] = fit_test1(x_sample, y_sample)
%  FIT_TEST(X_SAMPLE,Y_SAMPLE)
%  创建一个拟合。
%
%  要进行 '傅里叶拟合1' 拟合的数据:
%      X 输入: x_sample
%      Y 输出: y_sample
%  输出:
%      fitresult: 表示拟合的拟合对象。
%      gof: 带有拟合优度信息的结构体。
%

%% 拟合: '傅里叶拟合1'。
[xData, yData] = prepareCurveData( x_sample, y_sample );

% 设置 fittype 和选项。
ft = fittype( 'fourier3' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 0 0 0 0 0.392699081698724];

% 对数据进行模型拟合。
[fitresult, gof] = fit( xData, yData, ft, opts );

% 为绘图创建一个图窗。
figure( 'Name', '傅里叶拟合1' );

% 绘制数据拟合图。
subplot( 2, 1, 1 );
h = plot( fitresult, xData, yData );
legend( h, 'y_sample vs. x_sample', '傅里叶拟合1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'x_sample', 'Interpreter', 'none' );
ylabel( 'y_sample', 'Interpreter', 'none' );
grid on

% 绘制残差图。
subplot( 2, 1, 2 );
h = plot( fitresult, xData, yData, 'residuals' );
legend( h, '傅里叶拟合1 - 残差', 'Zero Line', 'Location', 'NorthEast', 'Interpreter', 'none' );
% 为坐标区加标签
xlabel( 'x_sample', 'Interpreter', 'none' );
ylabel( 'y_sample', 'Interpreter', 'none' );
grid on


