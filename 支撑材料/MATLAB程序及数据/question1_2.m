clc;
clear;

load('matlab3.mat');
load('GDP.mat');

%===================计算任务点6公里以内会员的各个因素==================%
for i = 1:size(dis,1)
    c = 0;
    cr = 0;
    t = 0;
    m = 0;
    for j = 1:size(dis,2)
        if dis(i,j) <= 6
            c = c + 1;
            cr = cr + credi(j);
            t = t + time(j);
            m = m + mission(j);
        end
    end
    cal(i,1) = c;
    cal(i,2) = cr/c;
    cal(i,3) = t/c;
    cal(i,4) = m/c;
end

%=========================将数据标准化==========================%
cal(isnan(cal)) = 0;
for i = 1:4
    cal(:,i) = cal(:,i) ./ mean(cal(:,i));
end
GDP = GDP ./ mean(GDP);
price = price ./ mean(price);

%========================= 逻辑回归模型 ==========================%
X = [cal(:,1) cal(:,2) cal(:,3) price];
y = compl;

initial_theta = zeros(size(X, 2), 1);
lambda = 1;

options = optimset('GradObj', 'on', 'MaxIter', 100);
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

p = predict(theta, X);
acc = mean(double(p == y)) * 100;

figure(1);
scatter(wei,jing,20,y)
set(gca,'FontSize',16);
figure(2);
scatter(wei,jing,20,p)
set(gca,'FontSize',16);