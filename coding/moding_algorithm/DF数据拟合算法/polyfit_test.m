x_sample = [1 2 3 4 5 6 7 8 9];

y_sample = [9 7 6 3 -1 2 5 7 20];

plot(x_sample, y_sample, 'bo');

hold on;

coeff = polyfit(x_sample, y_sample, 3);   %三阶多项式拟合

x_input = 0:.2:10;  

y_output = polyval(coeff, x_input);  %求对应y值

plot(x_input, y_output, 'r-');
