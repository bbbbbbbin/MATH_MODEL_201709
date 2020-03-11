clc;
clear;

load('matlab.mat');

cal = unique(price)
for i = 1:23
    c = 0;
    for j = 1:835
        if cal(i) == price(j)
            c = c + 1;
        end
    end
    num(i) = c;
end

num = num';
subplot(cal,num);