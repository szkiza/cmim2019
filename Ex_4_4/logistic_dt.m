% Zalán Hodruszki --- 06/03/2019
% Ex. 4.4

N_0 = 100;  % the size of population at t = 0
dt = 10;    % initial time step
T = 60;     % duration of the simulation
r = 0.1;
M = 500;    % carrying capacity of the model
f = @(t,N) r*(1-N/M)*N; % population model
[t_curr,N_curr] = ode_FE(f, [dt T], N_0); % approximate the solution by Forward Euler scheme
k = -1; % initial condition (for halving the time step size)

oneMore = 'y'; % initialize user input

while(strcmp(oneMore,'y')) % does the user want better approximation?
    
    t_prev = t_curr; % storing previous time data
    N_prev = N_curr; % storing previous solution data
    
    dt_k = dt*2^k; % halving the initial time step
    k = k-1; % new power
    
    [t_curr,N_curr] = ode_FE(f, [dt_k T], N_0); % solving the problem with the smaller time step
    
    plot(t_prev,N_prev,'r--','LineWidth',2); % plotting the previous result
    hold on
    plot(t_curr,N_curr,'b-'); % plotting the new result, with finer mesh
    hold off
    
    title('Logistic model');
    xlabel('t');
    ylabel('N');
    
    fprintf('The current time step is: %g\n',dt_k); % display current time step
    
    % Getting user input: 
    oneMore = input('Do you want a better approximation?\n (Hit "y" and enter if yes, press anything else if not!)\n','s'); % input request and store
    fprintf('\n');
end