clc;
clear;

load('matlab2.mat')

for j = 3:5
    all2(:,j-2) = all(:,j) ./ mean(all(:,j));
end


set(0,'defaultfigurecolor','w')
for i = 1:2
    figure(i);
    a = polyfit(all2(:,i),all(:,3),1);
    y = polyval(a,all2(:,i));
    scatter(all2(:,i),all(:,3),'y');
    hold on;
    scatter(all2(:,i),y,'k');
    set(gca,'FontSize',16);
end