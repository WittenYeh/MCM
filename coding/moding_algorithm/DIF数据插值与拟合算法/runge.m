for i = 3 : 2 : 11  
     x = linspace(-1,1,i);  
     y = 1./(1 + 25 * x .^ 2);  
     p = polyfit(x, y, i - 1);  
     xx = -1 : 0.01 : 1;  
     yy = polyval(p, xx);  
    plot(xx, yy, 'b');  
hold on;  
grid on;  
end  
plot(x, 1 ./(1 + 25 * x .^ 2), 'r'); 