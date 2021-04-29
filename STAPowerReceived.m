
% Function to calculate the power received at each STA by the AP

function P_rx = STAPowerReceived(P_tx, distance)

k = 5.25; % attenuation of each wall
W = 0.1467; % average number of traversed walls per meter
lambda = 2.06; % attenuation factor
L_o = 54.1200; % path loss intercept

% pathloss model TMB in dBm
PL = L_o + 10 * lambda * log10(distance) + k * W * distance; 
P_rx = P_tx - PL; % received power = transmitter power - pathloss

end

