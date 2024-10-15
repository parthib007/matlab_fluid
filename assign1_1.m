% Given parameters
L = 4; % Length of the porous system in meters
R = 0.25 / 2; % Radius of the capillary in meters
Q = 1e-6; % Flow rate in m^3/s
D = 1e-6; % Diffusion coefficient in m^2/s
porosity = 0.2; % Porosity of the porous medium

% Calculate average velocity u = Q / (pi * R^2)
u = Q / (pi * R^2);

% Calculate dispersion coefficient (D_ct)
D_ct = D + (R^2 * u^2) / (48 * D);

% Define function for concentration at outlet
concentration_outlet = @(t, L, u, D_ct) 0.5 * (1 - erf((L - u * t) / sqrt(4 * D_ct * t)));

% Define cumulative flow array
pore_volume = L * pi * R^2; % Pore volume in m^3
residence_time = pore_volume / 3600 / Q; % Residence time in seconds

% Time range in hours
time_array = linspace(0.01, 2 * residence_time, 1000);

% Convert time to cumulative flow in m^3
cumulative_flow_array = Q * time_array * 3600;

% Calculate concentration at outlet for each cumulative flow
concentration_array = arrayfun(@(t) concentration_outlet(t, L, u, D_ct), time_array * 3600);


% Plot concentration at outlet as a function of cumulative flow
figure;
plot(cumulative_flow_array, concentration_array);
xlabel('Cumulative Flow (m^3)');
ylabel('Concentration at Outlet');
title('Concentration at Outlet vs Cumulative Flow');
grid on;

% Add vertical line at pore volume
hold on;
ax = gca;
ax.XLim = [0 max(cumulative_flow_array)];
ax.YLim = [0 1];
ax.ColorOrderIndex = 1; % Reset color order to the beginning
plot([pore_volume, pore_volume], [0, 1], '--', 'Color', 'r', 'DisplayName', 'Pore Volume');
legend('show');
hold off;
