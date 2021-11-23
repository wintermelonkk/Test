
data = load('lab1data.txt');
x_axis = data(:,1);  %extract the first column for x axis
y_axis = data(:,2);  %extract the second column for x axis
node = [];
for n=10:1:250  %the coverage value of nodes starts at 10,end at 250
isolated_number = 0;
    for i = 1:1:length(x_axis)
        neighbor_number = 0;
        for j = 1:1:length(x_axis)
            if (x_axis(j)-x_axis(i))^2 + (y_axis(j)-y_axis(i))^2 <= n^2
                neighbor_number = neighbor_number + 1;
            end
        end
        if neighbor_number == 1  %this value is definately bigger than 0 (counting itself)
            isolated_number= isolated_number+1; 
        end
    end
    node=[node,isolated_number];
end
diatance_value = 10:1:250;
plot(diatance_value,node,'-b');
xlabel('covarege diatance value of nodes');
ylabel('number of isolated nodes');