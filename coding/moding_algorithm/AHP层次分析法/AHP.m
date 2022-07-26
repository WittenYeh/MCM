clc, clear  % 清空当前的命令行窗口
inFile = fopen('ahpInput.txt','rt'); % 以只读方式打开文件

if (inFile == -1) % 如果文件无法打开则输出报错信息
    disp("无法打开文件！");
else
    disp('成功打开文件！');
end

fgetl(inFile); % 读取文字行

rowCnt = fscanf(inFile,'%d %d\n',[1,2]);

fgetl(inFile); % 读取分割行
fgetl(inFile); % 读取文字行

factor = rand(rowCnt(1,1),rowCnt(1,1));  % 定义准则层

for i = 1:rowCnt(1,1)
    for j = 1:rowCnt(1,1)
        factor(i,j) = fscanf(inFile ,'%f', [1,1]); % 读取准则层矩阵
        if (j == rowCnt(1,1))
            fscanf(inFile,'\n');
        end
    end
end

fgetl(inFile); % 读取分割行
fgetl(inFile); % 读取文字行

RI = [0,0,0.58,0.9,1.12,1.24,1.32,1.41,1.45,1.49,1.52,1.54,1.56,1.58,1.59]; % 定义随机平均一致性指标

[eigenvectors , eigenvalues] = eig(factor);  % 求出判断矩阵的所有特征值构成对角阵eigenvalues，以及所有特征向量构成矩阵eigenvectors
max_eigenvalue = max(diag(eigenvalues)); % 求出最大的特征向量
whichColumn = find(diag(eigenvalues) == max_eigenvalue); % 找出最大的特征值对应的特征向量在哪一列
weightVector = eigenvectors(:,whichColumn)/sum(eigenvectors(:,whichColumn)); % 将找到的特征向量进行归一化处理
disp("准则矩阵的权重向量是");
disp(weightVector');

CR0 = (max_eigenvalue - rowCnt(1,1))/(rowCnt(1,1) - 1)/RI(rowCnt(1,1));

if CR0 < 0.1
    disp(['准则层判断矩阵的 CR 值为', CR0, ',一致性达到标准' newline]);
else
    disp(['准则层判断矩阵的 CR 值为', CR0, ',一致性未达标准' newline]);
end

weightVector_plan = zeros(rowCnt(1,2),rowCnt(1,1));

for i = 1:rowCnt(1,1)
    
    plan = zeros(rowCnt(1,2),rowCnt(1,2));    % 定义方案层矩阵

    for j = 1:rowCnt(1,2)
        for k = 1:rowCnt(1,2)
            plan(j,k) = fscanf(inFile ,'%f',[1,1]);  % 逐行输入得到各各要素下的方案层矩阵
            if (k == rowCnt(1,1))
                fscanf(inFile,'\n');
            end
        end
    end

    [eigenvectors_plan , eigenvalues_plan] = eig(plan);  % 求出判断矩阵的所有特征值构成对角阵eigenvalues，以及所有特征向量构成矩阵eigenvectors
    max_eigenvalue_plan = max(diag(eigenvalues_plan)); % 求出最大的特征向量
    whichColumn2 = find(diag(eigenvalues_plan) == max_eigenvalue_plan); % 找出最大的特征值对应的特征向量在哪一列
    weightVector_plan(:,i) = eigenvectors_plan(:,whichColumn2)/sum(eigenvectors_plan(:,whichColumn2)); % 将找到的特征向量进行归一化处理
    disp(['因素', num2str(i) ,'对应的各方案判断矩阵的权重向量是']);
    disp(weightVector_plan(:,i)');
    
    CR1 = (max_eigenvalue_plan - rowCnt(1,2))/(rowCnt(1,2) - 1)/RI(rowCnt(1,2));

    if CR1 < 0.1
        disp(['因素', num2str(i), '各方案判断矩阵的 CR 值为', num2str(CR1), ',一致性达到标准' newline]);
    else
        disp(['因素', num2str(i), '各方案判断矩阵的 CR 值为', num2str(CR1), ',一致性未达标准' newline]);
    end
end

scores = zeros(rowCnt(1,2));

for i= 1:rowCnt(1,2)
    scores(i) = sum(weightVector_plan(i,:)'.*weightVector);
    disp(['方案', num2str(i) ,'的得分为' , num2str(scores(i))]);
end

fclose(inFile);
    
    

