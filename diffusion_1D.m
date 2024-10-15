%%
clear
close all
clc

%% defining mesh
no_of_points = 5;
domain_length = 1;
h = domain_length/(no_of_points - 1);

%% boundary conditions
y(1) = 0;
y(no_of_points) = 1;

y_new(1) = 0;
y_new(no_of_points) = 1;

max_error = 1e-6;
iterations = 0;
error_mag = 1;

%% calculation
while error_mag > max_error
    for i = 2:(no_of_points -1)
        y_new(i) = 0.5.*y(i-1) + y(i+1);
        iterations = iterations + i;
    end
    error_mag = 0;
    for i = 2:(no_of_points -1)
        error_mag = error_mag + abs(y(i) - y_new(i));
    end
    y = y_new;
end

%% plotting
x_dom = ((1:no_of_points)-1).*h;
plot(x_dom,y);
