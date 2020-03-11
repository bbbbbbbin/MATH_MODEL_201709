clear;
clc;

load('que4_1.mat')
load('theta1.2.mat')

x1 = [ones(2067,1) cal(:,1) cal(:,2) cal(:,3) cal(:,2).^2 cal(:,3).^2];
price = x1 * b ;

price = price ./ mean(price);

theta = [-0.7092;0.5171;-1.0125;1.8593];
X1 = [cal(:,1) cal(:,2) ones(2067,1) price];
p1 = predict(theta, X1);
a1 = mean(p1 == 1);