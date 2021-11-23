
clc
clear all

load("lab1data.txt");


x=lab1data(:,1);
y=lab1data(:,2);
distance=sqrt(power(x,2)+power(y,2)); % txt ���� ÿһ�ж���һ���ڵ��x��y  �������ÿ���ڵ��ԭ��ľ���

L = length(x); %number of all nodes
node_exclude = zeros(L,1);
sync_index=find(distance==min(distance)); % sync 
node_exclude(sync_index) = 1;

cover_dist = 225;
node_current = [sync_index];%nodes at same level

time_unit=0;

for i = 1:L
    for j = 1:L
        if i == j
             Gloabaldist(i,j) = 100000;%������� �ѶԽ�����ĺܴ�
        else
             Gloabaldist(i,j) = sqrt((x(i) - x(j))^2 + (y(i) - y(j))^2);
        end
    end
end

while ~all(node_exclude == 1)
    
    node_next_level_tmp = [];
    next_level_index = find( Gloabaldist(node_current,:)<cover_dist);     
    node_next_level_tmp = [node_next_level_tmp next_level_index];
    next_node_index=node_next_level_tmp(uint16(rand * (length(node_next_level_tmp) - 1) + 1))%�ڸ������������ȡһ��Ԫ��
    node_exclude(next_node_index) = 1;
    node_current=[next_node_index];
    if length(next_level_index)>0
        time_unit=time_unit+1
    end
     
end