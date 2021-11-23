plot(data(:,1), data(:,2), 'o');
hold on;
distance=[];
min_dis = 100000;
for i = 1 : length(data(:,1))
    distance(i) = data(i,1)^2 + data(i,2)^2;
    if min_dis >= distance(i)
        min_dis = distance(i);
        sync = i
    end
end    
plot(data(sync,1), data(sync,2), 'x')
grid on;
xlabel('distance in meter');
ylabel('distance in meter');