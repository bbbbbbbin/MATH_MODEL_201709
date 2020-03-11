clc;
clear;

load('matlab.mat')
load('p.mat')
load('theta.mat')
load('X.mat')

ac = mean(p == 1);
cal10 = 0;
dal10 = 0;
for j = 1:10;
    c = 0;
    d = 0;
    for i = 1:500;
        a = mean(compl == 1);
        theta1 = theta + [rand * 0.7092;0;0;0];
        p1 = predict(theta1, X);
        b1 = mean(p1 == 1);
        if b1 >= a
            c = c + 1;
        else
            d = d + 1;
        end
    end
    cal = c/500;
    dal = d/500;
    cal10 = cal10 + cal;
    dal10 = dal10 + dal;
end
calc = cal10 / 10;
dalc = dal10 / 10;

%============计算完成度============%

% a = mean(compl == 1);
% 
% ac = mean(p == 1);
% 
% ran = randn(3,1);
% ran = ran ./ sum(abs(ran));
% ran = [ran ;0]
% 
% theta1  = theta - ran;
% p1 = predict(theta1, X);
% b1 = mean(p1 == 1);

% for i = 1:100
%     ran = randn(3,1);
%     ran = ran ./ sum(abs(ran));
%     ran = [ran ;1];
%     ran = ran .* theta;
%     
%     theta1  = theta - ran;
%     p1 = predict(theta1, X);
%     b1 = mean(p1 == 1);
%     
%     for j = 1:3
%         arr(i,j) = theta(j) - theta1(j);
%     end
%     arr(i,4) = b1;
% end
% 
% [b,bint,r,rint,statsl] = regress( arr(:,4), arr(:,1:3))
% rcoplot(r,rint);
