clc;
clear;

load('que3.mat')
load('GDP.mat')

% %======================计算任务点之间的距离====================%
% for i = 1:size(jing,1)
%     for j = 1:size(jing,1)
%         dis(i,j) = distance(wei(i),jing(i),wei(j),jing(j));
%     end
% end
% dis = dis .* ( 6371 * 2 * 3.1415926) ./ 360 ;

for i = 1:300
    ra = randi([1,835],1,1);
    if com(ra) ~= 0
        n = 1;
        jingn = jing(ra);
        wein = wei(ra);
        pricen = price(ra);
        GDPn = GDP(ra);
        for j = 1:835
            if (price(ra) - 5 < price(j) < price(ra) + 5) && ( dis( ra,j ) < 5 )
                n = n + 1;
                com(j) = 0;
%                 jingm(i) = jing(i);
%                 weim(i) = wei(i);
%                 price(i) = price(i);
                jingn = jingn + jing(i);
                wein = wein + wei(i);
                pricen = pricen + price(i);
                GDPn = GDPn + GDP(i);
                if n > 35
                    break;
                end
            end
        end
        if pricen ~= 0
            new(i,1) = jingn / n ;
            new(i,2) = wein / n ;
            new(i,3) = pricen / n;
            new(i,4) = GDPn / n;
            new(i,5) = n;
%             new(i,1) = median(jingm);
%             new(i,2) = median(weim);
%             new(i,3) = median(price);
        end
    end
end
new(all(new == 0,2),:) = [];
scatter(wei,jing,25,'y');
hold on;


for i = 1 : 835
    if com(i) == 1;
        new2(i,:) = [jing(i) wei(i) price(i) GDP(i) 1];
    end
end
new2(all(new2 == 0,2),:) = [];

scatter(new2(:,2),new2(:,1),100,new2(:,3));
hold on;
scatter(new(:,2),new(:,1),100,new(:,3));
new3 = [new;new2];
