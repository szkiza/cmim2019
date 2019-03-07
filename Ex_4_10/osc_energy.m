% Zalán Hodruszki --- 06/03/2019
% Ex. 4.10

function osc_energy(u, v, t, omega)

% u : positon vector of the oscillating mass-spring system
% v : velocity vector of the oscillating mass-spring system
% t : time data
% omega: angular natural frequency of the system
    
    E_pot = 0.5*omega^2*u.^2; % potential energy
    E_kin = 0.5*v.^2; % kinetic energy
    
    plot(t,E_pot+E_kin,'b-'); % plotting the whole energy of the system
    title('Energy of an oscillating system');
    xlabel('t');
    ylabel('E');
    
end