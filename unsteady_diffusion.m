%%
clear
close all
clc

%% Mesh defining
n_points = 51;
dom_size = 1;
h = dom_size/(n_points-1);
dt = 1e-4;
alpha = dt/(h*h);

%% Initialisation
y(n_points,n_points) = 0;
y(1,:) = 1;

y_new(n_points,n_points) = 0;
y_new(1,:) = 1;

error_mag = 1;
max_error = 1e-6;
iterations = 0;

error_tracking = 0

%% Calculation
while error_mag > max_error
    for i = 2: (n_points - 1)
        for j = 2:(n_points -1)
            y_new(i,j) = y(i,j) + alpha.*y(i+1,j) + y(i-1,j) + y(i,j+1) + y(i,j-1) - (4*y(i,j));
        end
    end
    iterations = iterations + 1;
    error_mag = 0;
    for i =2:(n_points-1)
        for j = 2:(n_points -1)
            error_mag = error_mag + abs(y_new(i,j)-y(i,j));
            error_tracking(iterations) = error_mag;
        end
    end
    if rem(iterations,100) == 0
        iterations
        error_mag
    end
    y = y_new;
end

%% plotting
x_dom = ((1:n_points)-1).*h;
y_dom = 1-((1:n_points)-1).*h;
[X,Y] = meshgrid(x_dom,y_dom);
contourf(X,Y,y,12)
colorbar

%% figure
figure;
time = dt.*(1:iterations);
plot(time,error_tracking);

%% subplot
figure;
subplot(2,1,1)
plot(time,error_tracking)
subplot(2,1,2)
contourf(X,Y,y,12)
colorbar