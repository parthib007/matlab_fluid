%%
clear
close all
clc

%% mesh defining
n_points = 51;
dom_size = 1;
h = dom_size/(n_points -1);

y(n_points,n_points) = 0;
y(1,:)=1;

y_new(n_points,n_points) = 0;
y_new(1,:) = 1;

error_mag = 1;
max_error = 1e-6;
iterations = 0;

%% Calculations
while error_mag>max_error
    for i=2:(n_points -1)
        for j=2:(n_points -1)
            y_new(i,j) = 0.25.*y(i+1,j)+y_new(i-1,j)+y_new(i,j+1)+y(i,j-1);
            iterations = iterations + 1;
        end
    end
    error_mag = 0;
    for i=2:(n_points -1)
        for j=2:(n_points-1)
            error_mag = error_mag + abs(y(i,j) - y_new(i,j));
        end
    end
    y=y_new;
end

%% plotting
x_dom = (1:n_points)-1.*h;
y_dom = 1-(1:n_points)-1.*h;
[X,Y]= meshgrid(x_dom,y_dom);
contourf(X,Y,y,12);