% Given parameters
C0 = 1.0;
D = 1e-6;  % m^2/s
x = 4.0;   % m

% Function to solve for time
equation = @(t) 0.5 * erfc(x / (2 * sqrt(D * t))) - 0.05;

% Initial guess for fsolve
initial_guess = 1.0;

% Solve for time
time_required = fsolve(equation, initial_guess);

% Convert time to hours
time_required_hours = time_required / 3600.0;

fprintf('Time required for 95%% of the inlet concentration: %.2f hours\n', time_required_hours);
