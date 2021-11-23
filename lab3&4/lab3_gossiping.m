clear all

M=load("lab1data.txt");
thr = 225;
tran = 3;
dist = zeros(50,50);  %两两之间的距离
for i = 1:50
    for j = 1:50
        dist(i,j) = ((M(i,1)-M(j,1))^2+(M(i,2)-M(j,2))^2)^(1/2);
    end
    dist(i,i) = 10000;
end

hops = zeros(1,6)
messages = zeros(1,6)
[hops(1),messages(1)] = gossiping(dist,tran,thr)
for i = 2:6
    [hops(i),messages(i)] = gossiping_n(dist,tran,thr,i)
end
subplot(1,2,1)
bar(hops)
xlabel('n')
ylabel('hops')
subplot(1,2,2)
bar(messages)
xlabel('n')
ylabel('messages')

function [hop,message] = gossiping(dist,tran,thr)
hop = 0;
message = 0
run = 1;
rec = zeros(1,50); %每一个收到的多少
rec(3) = 10000;
while run == 1
    hop = hop +1;
    next_hop =  find(dist(tran,:)<thr); %第三行所有列小于225 随便揪一个非零的
    next_hop = next_hop(randi(length(next_hop)));
    rec(next_hop) = 10000;
    message = message + 1;
    tran = next_hop;
    mindist = min(rec);
    if mindist > thr
        run = 0;
    end
end
end

function [hop,message] = gossiping_n(dist,tran,thr,n)
hop = 0;
message = 0
run = 1;
rec = zeros(1,50);
rec(3) = 10000;
while run == 1
    hop = hop +1;
    next_hop = []
    for i = tran
        mid = find(dist(i,:)<thr);
        mid = mid(randi(length(mid),1,n));
        next_hop = [next_hop mid];
    end
    rec(next_hop) = 10000;
    message = message + length (next_hop)
    tran = next_hop
    tran = unique(tran)
    mindist = min(rec);
    if mindist > thr
        run = 0;
    end
end
end