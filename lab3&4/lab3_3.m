%neighbor>1
clc
clear all


load("lab1data.txt");

x=lab1data(:,1);
y=lab1data(:,2);
distance=sqrt(power(x,2)+power(y,2));

L = length(x); %number of all nodes
node_exclude = zeros(L,1);
sync_index=find(distance==min(distance)); % sync 
node_exclude(sync_index) = 1;

neighbor=6;

cover_dist = 225;
current_node_index = [sync_index];%nodes at same level

time_unit=0;
nn_tmp=[];

for i = 1:L
    for j = 1:L
        if i == j
             Gloabaldist(i,j) = 100000;%距离矩阵
        else
             Gloabaldist(i,j) = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        end
    end
end

while ~all(node_exclude == 1)
    next_node_index = [];
    
    for m=1:length(current_node_index)
    
%         for n = 1:neighbor
        possible_next_node_tmp = [];       %某点所有可能的下层元素
        next_node_index_tmp=[];         %选取出的下一次迭代元素
        next_level_index = find( Gloabaldist(current_node_index(m),:)<cover_dist);     
        possible_next_node_tmp = [possible_next_node_tmp next_level_index];
        
        if neighbor>length(possible_next_node_tmp)  %防止neighbor数大于distance范围内的元素个数
            nn=length(possible_next_node_tmp);
        else
            nn=neighbor;
        end
        nn_tmp=[nn_tmp nn];
        sum_forward=sum(nn_tmp);
        next_node_index_tmp=possible_next_node_tmp(randperm(length(possible_next_node_tmp),nn));%在该序列里随机抽取nn个元素

        for i = 1:length(next_node_index_tmp)   %排除标记点
            node_exclude(next_node_index_tmp(i)) = 1;
        end
        
        next_node_index = [next_node_index next_node_index_tmp];
        
    end
    
    if length(next_node_index)>0
        time_unit=time_unit+1
    end
 
    current_node_index=next_node_index;
end
    

    
   
