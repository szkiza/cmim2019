% Zalán Hodruszki --- 06/03/2019
% Ex. 4.10

omega = 2;          % natural frequency of the oscillating system
P = 2*pi/omega;     % periodic time
dt = P/2000;         % time step
T = 3*P;            % duartion of the simulation
N_t = floor(T/dt);  % number of time step

t = linspace(0, N_t*dt, N_t+1); % definition of the time vector
u = zeros(N_t+1, 1);            % initialize position vector
v = zeros(N_t+1, 1);            % initialize velocity vector

% Initial condition
X_0 = 2;    % initial position
u(1) = X_0;
v(1) = 0;   % initial velocity

% Euler-Cromer method
for n = 1:N_t
    v(n+1) = v(n) - dt*omega^2*u(n);
    u(n+1) = u(n) + dt*v(n+1);
end

% plot(t, u, 'b-', t, X_0*cos(omega*t), 'r--');
% legend('numerical', 'exact', 'Location','northwest');
% xlabel('t');

osc_energy(u,v,t,omega); % calling the energy calculator
