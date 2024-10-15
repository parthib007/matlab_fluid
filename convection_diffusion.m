clear
close all
clc

%% Defining mesh
n_points = 101;
dom_size = 1;
h = dom_size/(n_points-1);
x = 0:h:dom_size;
phi(1) = 10;
phi(n_points) = 20;
phi_new(1) =10;
phi_new(n_points) = 20;
rho = 1;
u =1;
gamma =1;
p = rho*u*dom_size/gamma;

%% exact solution
phi_exact = phi(1) + (phi(n_points) - phi(1)).*(exp(p.*x/dom_size)-1)./(exp(p)-1);
figure(1);
plot(x,phi_exact,'ro')

%% differencing scheme
error = 1;
iterations =0;
while error>1e-7
    for i = 2:n_points-1
        a_E = gamma/h - rho*u/2;
        a_W = gamma/h + rho*u/2;
        a_P = rho*u/2 - rho*u/2 + gamma/h - gamma/h;
        phi_new(i) = (a_E*phi(i+1) + a_W*phi(i-1))/a_P;
    end
    iterations = iterations + 1;
    error =0;
    for i =2:n_points-1
        error =error + abs(phi(i) - phi_new(i));
    end
    phi = phi_new;
end
figure(1)
hold on
plot(x,phi,'b','LineWidth',1)
xlabel('x')
ylabel('Phi')
legend('Exact solution', 'Differential Scheme')