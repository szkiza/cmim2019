% Zalán Hodruszki --- 27/03/2019
% Investigating the Slider-Crank mechanism

a = 0.1;                       % length of the 'active' rod
b = 0.2;                       % length of the 'passive' rod
omega = 1;                     % angular velocity of the 'active' rod
    
t = 0:0.001:20;                % simulation time and time step
phi = pi/6 + omega*t;          % angle function of the 'active' rod
        
d = zeros(1,length(t));        % allocation for position values of the sliding body
theta = zeros(1,length(t));    % allocation for angle values of the 'passive' rod
Dd = zeros(1,length(t));       % allocation for velocity values of the sliding body
Dtheta = zeros(1,length(t));   % allocation for angular velocity values of the 'passive' rod
DDd = zeros(1,length(t));      % allocation for acceleration values of the sliding body
DDtheta = zeros(1,length(t));  % allocation for angular acceleration values of the 'passive' rod


for i = 1:length(t)            % time-loop
    
    % Vector function of the problem:
    F = @(theta,d)[ a*cos(pi/6 + omega*t(i))+b*cos(theta)-d;
                    a*sin(pi/6 + omega*t(i))-b*sin(theta)];
    
    % Jacobian matrix
    J = @(theta,d)[ -b*sin(theta) -1;
                    -b*cos(theta)  0];
    
    % Finding Theta and d for every time step 
    [x, iteration_counter] = NR_method(@(x) F(x(1),x(2)), @(x) J(x(1),x(2)), [a + b; pi/6], 1e-10);
    theta(i) = x(1,1);
    d(i) = x(2,1);
    
    % Velocity function remainder
    ft = [-a*omega*sin(pi/6 + omega*t(i));
             a*omega*cos(pi/6 + omega*t(i))];
    
    % Finding 1st derivative of Theta and d for every time step 
    dx = J(theta(i),d(i))\-ft;
    Dtheta(i) = dx(1,1);
    Dd(i) = dx(2,1);
    
    % Acceleration function remainder
    G = [-a*omega^2*cos(pi/6 + omega*t(i))-b*Dtheta(i)^2*cos(theta(i));
         -a*omega^2*sin(pi/6 + omega*t(i))+b*Dtheta(i)^2*sin(theta(i))];
    
    % Finding 2nd derivative of Theta and d for every time step
    ddx = J(theta(i),d(i))\-G;
    DDtheta(i) = ddx(1,1);
    DDd(i) = ddx(2,1);
 
end

% General setting parameters for plotting
x0=100;
y0=100;
width=600;
height=250;
lineWidth = 2;

% Plot Theta and d vs. time
figure
yyaxis left
plot(t,d,'LineWidth',lineWidth);
xlabel('t [s]');
ylabel('Position of the sliding body [m]');

yyaxis right
plot(t,theta,'LineWidth',lineWidth);
ylabel('Angel of the rod [rad]');
grid on
set(gcf,'position',[x0,y0,width,height])

% Plot the 1st derivative of Theta and d vs. time
figure
yyaxis left
plot(t,Dd,'LineWidth',lineWidth);
xlabel('t [s]');
ylabel('Velocity of the sliding body [m/s]');

yyaxis right
plot(t,Dtheta,'LineWidth',lineWidth);
ylabel('Angular velocity of the rod [rad/s]');
grid on
set(gcf,'position',[x0,y0,width,height])

% Plot the 2nd derivative of Theta and d vs. time
figure
yyaxis left
plot(t,DDd,'LineWidth',lineWidth);
xlabel('t [s]');
ylabel('Acceleration of the sliding body [m/s^2]');

yyaxis right
plot(t,DDtheta,'LineWidth',lineWidth);
ylabel('Angular acceleration of the rod [rad/s^2]');
grid on
set(gcf,'position',[x0,y0,width,height])
 