function outrank = pagerank(n, times, tran_mat)
    % n 是网页的个数
    % times 表示迭代次数，次数越大，精度越高
    % tran_mat 表示转移矩阵
    
    %% 设置阻尼
    d = 0.85;
    bias = ones(n, n);
    for i = 1 : n
        for j = 1 : n
            tran_mat = d * tran_mat + (1 - d) * bias / n;
        end
    end

    %% 矩阵乘法

    value = zeros(n, times);
   
    for i = 1 : n
        value(i,1) = 1 / n;
    end

    for i = 2 : times + 1
       value(:, i) = tran_mat * value(:, i - 1); 
    end
    
    %% 作图
    curtime = 0 : 1 : times;
    colorGap = fix(255/n);
    for i = 1 : n
        plot(curtime,value(i, :),'-','Color', [i*colorGap/255, 127/255, (255 - i*colorGap)/255]);
        hold on;
    end
    xlabel("迭代次数");
    ylabel("状态值");
    legend("page1","page2","page3","page4","page5");

    %% 归一化并返回最终结果
    outrank = zeros(n);
    for i = 1 : n
        outrank(i) = value(i, times + 1)/sum(value(:,times + 1));
    end
end




