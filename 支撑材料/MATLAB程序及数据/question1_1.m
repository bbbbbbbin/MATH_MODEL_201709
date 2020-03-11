clc;
clear;
load('matlab3.mat');
load('GDP.mat');

%======================����������������Ա֮��ľ���====================%
% for i = 1:size(jing,1)
%     for j = 1:size(jing2,1)
%         dis(i,j) = distance(wei(i),jing(i),wei2(j),jing2(j));
%     end
% end
% 
% dis = dis .* ( 6371 * 2 * 3.1415926) ./ 360 ;

%===================���������6�������ڻ�Ա�ĸ�������==================%
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

%=========================�����ݱ�׼��==========================%
cal(isnan(cal)) = 0;
for i = 1:4
    cal(:,i) = cal(:,i) ./ mean(cal(:,i));
end
cal(:,5) = GDP ./ mean(GDP);

set(0,'defaultfigurecolor','w')

%================�����Ƿ������۸񼰸����صĹ�ϵ===================%
% for i = 1:4
%     figure(i);
%     for j = 1:835
%         if compl(j) == 1
%             scatter(price(j),cal(j,i),'b');
%             hold on;
%         elseif compl(j) ==0
%             scatter(price(j),cal(j,i),'r');
%             hold on;
%         end
%     end
%     set(gca,'FontSize',16);
% end

%========================���������======================%
for i = 1:5
    figure(i);
    a = polyfit(cal(:,i),price,1);
    y = polyval(a,cal(:,i));
    scatter(cal(:,i),price);
    hold on;
    scatter(cal(:,i),y);
    set(gca,'FontSize',16);
end

%=========================�������======================%
[b,bint,r,rint,statsl] = regress( price, [ones(835,1) cal(:,1) cal(:,2)...
    cal(:,3) cal(:,2).^2 cal(:,3).^2 ])
rcoplot(r,rint);

