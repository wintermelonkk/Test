load("lab1data.txt");
%% Ԥ����data ���� 
temp = sqrt(lab1data(:,1).^2+lab1data(:,2).^2); %��ԭ��ľ��� ���� ��sync
[temp,IX] = sort(temp);
x(1) = lab1data(IX(1),1);
y(1) = lab1data(IX(1),2);

dis = sqrt((lab1data(:,1)-x(1)).^2+(lab1data(:,2)-y(1)).^2); %������sync����
[dis,ix] = sort(dis);
for i = 1:50
    x(i) = lab1data(ix(i),1);
    y(i) = lab1data(ix(i),2);
end

R = 225;
sum_hops = 0;
NodeAmount = length(x);
h=zeros(NodeAmount,NodeAmount);
a=zeros(NodeAmount,NodeAmount);
%% ��ʼ���ڵ��ľ��� ��������?
for i=1:NodeAmount
    for j=1:NodeAmount
       Dall(i,j)=((x(i)-x(j))^2+(y(i)-y(j))^2)^0.5; %���нڵ�֮����໥����
        if (Dall(i,j)<=R)&&(Dall(i,j)>0)
           h(i,j)=1;%��ʼ��������
        elseif i==j
           h(i,j)=0;
        else h(i,j)=inf;
        end
    end
end
a = h;
%% ���·���㷨����ڵ����� ����ƽ������?
for k=1:NodeAmount
    for i=1:NodeAmount
        for j=1:NodeAmount
           if h(i,k)+h(k,j)<h(i,j)%min(h(i,j),h(i,k)+h(k,j))
               h(i,j)=h(i,k)+h(k,j);
           end
        end
    end
end
for k=1:NodeAmount
    sum_hops = h(1,k)+sum_hops;
end
average_hops = sum_hops/49;
fprintf('average hops num is %d\n',average_hops);
 %% ����ê����Զ���·��ͼ
DG = sparse(a);
[dist,path,pred] = graphshortestpath(DG,1,50);
figure()
scatter(x,y);
hold on
scatter(x(path),y(path));
hold on
plot (x(path),y(path));
%% Lab3Task1
T = zeros(9,50);
layer = 0;
for j = 1:50 
    layer = h(1,j);
    T(layer+1,j)=1;
end
threshold_node = zeros(1,50);
threshold_node_sum = 0;
for i = 1:50
    for j =1:50
        if (a(i,j)~=1)
            a(i,j)=0; 
        end
    threshold_node(1,i)=threshold_node(1,i)+a(i,j);    
    end
    threshold_node_sum = threshold_node(1,i)+threshold_node_sum;
end
fprintf('%d nodes are on average within the coverage of each node for the threshold of 225m\n',threshold_node_sum/50);
sum_flooding = 0;

M = zeros(1,50); % M ��Ϣ������ M��1��j����j���ڵ��յ�������Ϣ
for i = 2:9
    for j =1:50
        for k = 1:50
            M(1,j)=M(1,j)+T(i,j)*T(i-1,k)*a(k,j); %���·�ʽ�����㱾��ĳ���ǰһ�������ĵ�ĸ���
        end
    end   
end

for j =1:50
    sum_flooding = M(1,j)+sum_flooding;
end

fprintf('each node received %d messages on average\n',sum_flooding/49);