clear;
clc;

load('que3_2.mat')
load('matlab2.mat')
load('que_po.mat')


% %======================计算任务点与各个会员之间的距离====================%
% for i = 1:size(new3,1)
%     for j = 1:size(jing2,1)
%         dis(i,j) = distance(new3(i,2),new3(i,1),wei2(j),jing2(j));
%     end
% end
% 
% dis = dis .* ( 6371 * 2 * 3.1415926) ./ 360 ;
% 
% %===================计算任务点6公里以内会员的各个因素==================%
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
%     if c == 0
%         continue;
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

cal(:,5) = new3(:,4) ./ mean(new3(:,4));

set(0,'defaultfigurecolor','w')

%========================各因素拟合======================%
for i = 1:5
    figure(i);
    a = polyfit(cal(:,i),new3(:,3),1);
    y = polyval(a,cal(:,i));
    scatter(cal(:,i),new3(:,3));
    hold on;
    scatter(cal(:,i),y);
    set(gca,'FontSize',16);
end

%=========================总体拟合======================%
[b,bint,r,rint,statsl] = regress( new3(:,3), [ones(166,1) cal(:,2)...
    cal(:,3) cal(:,2).^2 cal(:,3).^2 (new3(:,5)./mean(new3(:,5)))]);
rcoplot(r,rint);
X = [ones(166,1) cal(:,:) (new3(:,5)./mean(new3(:,5)))];