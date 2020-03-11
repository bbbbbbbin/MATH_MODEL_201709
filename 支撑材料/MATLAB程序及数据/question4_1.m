clear;
clc;

load('matlab3.mat')
load('matlab2.mat')

%======================计算任务点与各个会员之间的距离====================%
for i = 1:size(jing3,1)
    for j = 1:size(jing2,1)
        dis(i,j) = distance(wei3(i),jing3(i),wei2(j),jing2(j));
    end
end

dis = dis .* ( 6371 * 2 * 3.1415926) ./ 360 ;

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

set(0,'defaultfigurecolor','w')