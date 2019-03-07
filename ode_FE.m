% Zalán Hodruszki --- 06/03/2019
% Ex. 4.4

function [t, u] = ode_FE(f, tspan, U_0)

% Inputs:
% f : derivative function
% tspan : time data
% U_0 : initial condition

% Outputs:
% t : time vector
% u : solution of the differential equation

    dt = tspan(1); T = tspan(2);
    N_t = floor(T/dt);                   % numer of time steps
    u = zeros(N_t+1, 1);                 % initializing the position vector
    t = linspace(0, N_t*dt, length(u))'; % time vector
    u(1) = U_0; 
    
    % Numerical integration
    for n = 1:N_t
        u(n+1) = u(n) + dt*f(t(n), u(n));
    end
end