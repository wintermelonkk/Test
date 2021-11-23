load("lab1data.txt");
%% 数据预处理，排序及变量预设
temp = sqrt(lab1data(:,1).^2+lab1data(:,2).^2); %按距离原点排序找到sync
[temp,IX] = sort(temp);
for i = 1:50
    x(i) = lab1data(IX(i),1);
    y(i) = lab1data(IX(i),2);
end
dis = sqrt((lab1data(:,1)-x(1)).^2+(lab1data(:,2)-y(1)).^2); %按距离sync排序
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
%% 初始化节点间距离、跳数矩阵
for i=1:NodeAmount
    for j=1:NodeAmount
       Dall(i,j)=((x(i)-x(j))^2+(y(i)-y(j))^2)^0.5;%所有节点间相互距离
        if (Dall(i,j)<=R)&&(Dall(i,j)>0)
           h(i,j)=1;%初始跳数矩阵
        elseif i==j
           h(i,j)=0;
        else h(i,j)=inf;
        end
    end
end
a = h;
%% 最短路经算法计算节点间跳数，计算平均跳数
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
average_hops = sum_hops/50;
fprintf('%d',average_hops);
%% 距离锚点最远点的路径图
DG = sparse(a);
[dist,path,pred] = graphshortestpath(DG,1,50);
figure()
scatter(x,y);
hold on
scatter(x(path),y(path));
hold on
plot (x(path),y(path));
