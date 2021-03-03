% Function to calculate the power received at each STA by the AP

% P_tx:   Transmitted power by the AP
% lambda: attenuation factor
% L_o:    path loss intercept
% k:      attenuation of each wall
% W:      average number of traversed walls per meter

function P_rx = STAPowerReceived(P_tx, distance)

lambda = 2.06;  % attenuation factor
L_o = 54.1200   % path loss intercept
k = 5.25;       % attenuation of each wall
W = 0.1467      % average number of traversed walls per meter

PL = L_o + 10 * lambda * log10(distance) + k * W * distance; % pathloss model TMB

P_rx = P_tx - PL; % received power = transmitter power - pathloss

end

