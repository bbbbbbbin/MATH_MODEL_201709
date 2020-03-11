clc;
clear;

load('qita.mat')

% for i = 1:size(jingq,1)
%     for j = 1:size(jing2,1)
%         dis(i,j) = distance(weiq(i),jingq(i),wei2(j),jing2(j));
%     end
% end
% 
% dis = dis .* ( 6371 * 2 * 3.1415926) ./ 360 ;
% 
% 
% for i = 1:size(dis,1)
%     c = 0;
%     cr = 0;
%     t = 0;
%     m = 0;
%     for j = 1:size(dis,2)
%         if dis(i,j) <= 6
%             c = c + 1;
%             cr = cr + credi(j);
%             t = t + time(j);
%             m = m + mission(j);
%         end
%     end
%     cal(i,1) = c;
%     cal(i,2) = cr/c;
%     cal(i,3) = t/c;
%     cal(i,4) = m/c;
% end

%=========================将数据标准化==========================%
cal(isnan(cal)) = 0;
for i = 1:4
    cal(:,i) = cal(:,i) ./ mean(cal(:,i));
end
GDPq = GDPq ./ mean(GDPq);
priceq = priceq ./ mean(priceq);

%========================= 逻辑回归模型 ==========================%
X = [cal(:,1) cal(:,2) priceq GDPq];
y = complq;

initial_theta = zeros(size(X, 2), 1);
lambda = 1;

options = optimset('GradObj', 'on', 'MaxIter', 100);
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

p = predict(theta, X);
acc = mean(double(p == y)) * 100;

figure(1);
scatter(weiq,jingq,20,y)
figure(2);
scatter(weiq,jingq,20,p)