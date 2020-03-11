clear;
clc;

load('que3_3.mat')
load('X.mat')
price = new3(:,3) ./ mean(new3(:,3));

%========================= Âß¼­»Ø¹éÄ£ÐÍ ==========================%

x1 = [ X(:,1:4) X(:,3).^2 X(:,4).^2 ];
x2 = [ X(:,1) X(:,3:4) X(:,3).^2 X(:,4).^2 X(:,7)];

price1 = x1 * b;
price2 = x2 * b3;

price1 = price1 ./ mean(price1);
price2 = price2 ./ mean(price2);

%theta = [-0.651583183233028;0.279740380360770;-1.03548847295984;1.97811587546365];
theta = [-0.7092;0.5171;-1.0125;1.8593];
X1 = [ X(:,2:3) X(:,6) price1];
X2 = [ X(:,2:3) X(:,6) price2];

p1 = predict(theta, X1);
p2 = predict(theta, X2);

a1 = mean(p1 == 1);
a2 = mean(p2 == 1);