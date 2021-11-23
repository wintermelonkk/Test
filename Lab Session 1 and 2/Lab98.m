close all
clc

%% Task 1
load lab1data.txt
figure
hold on
plot(lab1data(:,1),lab1data(:,2),'o')
distance = sqrt(lab1data(:,1).^2+lab1data(:,2).^2);
[m,i] = min(distance);
sync = i;
plot(lab1data(i,1),lab1data(i,2),'or');

%% Task 2
i = 1;
dist(i) = 10;
res(i) = CalCoverage(lab1data, dist(i));
while res(i)
   i = i+1;
   dist(i) = dist(i-1)+5;
   res(i) = CalCoverage(lab1data, dist(i));
end
figure
plot(dist, res,'-');

%% Task 3
frequency = [430e6 900e6 2.4e9];
bandwidth = 500e3;
d = 100;
xcat = categorical({'430MHz', '900MHz', '2.4GHz'});
xcat = reordercats(xcat,{'430MHz', '900MHz', '2.4GHz'});     %B = reordercats(A,neworder) 按 neworder 指定的顺序放置这些类别
Pt = [CalPt(430e6, d) CalPt(900e6, d) CalPt(2.4e9, d)];
figure
bar(xcat, Pt);
ylabel('Pt/dBW')

%% Task 4
mindist = dist(length(dist));
map = lab1data;
queue = zeros(1,50);
hop = 100*ones(1,50);  %% init it as a large number which can never be legal

% initialize
queue(1) = sync;
hop(sync) = 0;
start = 1; % number of points in queue
iend = 1;
while iend<50
    for j=1:1:50 % transerve
        if(hop(j)==100)  % find a node not in queue
            if(CalDistance(map(queue(start),:),map(j,:))<mindist) % if the node in range
                iend = iend+1;
                queue(iend) = j; %% enqueue
                hop(queue(iend)) = hop(queue(start))+1; %% cal hop
            end
        end
    end
    start = start + 1;
end

ave = mean(hop);
display(ave);

%% Calculate Coverage
function [num] = CalCoverage(data, dist)
    l = length(data);
    num = 0;
    for i = 1:l
        stat = 0;
        for j = 1:l
            if (i~=j) && (data(i,1)-data(j,1))^2+(data(i,2)-data(j,2))^2<dist^2
                stat = 1;
                break;
            end
        end
        if stat == 0
            num = num+1;
        end
    end
end


%% Calculate Pt   
function [Pt] = CalPt(frequency, d)
    lamda = 3e9/frequency;
    Pt = 1e-3 / 1 / 1 * (4 * pi * d / lamda) ^ 2;
    Pt = 10*log(Pt);
end

%% Shanon's cap
function [c] = Capacity()

end

%% cal distance
function [d] = CalDistance(x, y)
    d = sqrt((x(1)-y(1))^2+(x(2)-y(2))^2);
end
