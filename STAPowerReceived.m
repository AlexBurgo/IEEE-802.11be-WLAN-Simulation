% Function to calculate the power received at each STA by the AP

function P_rx = STAPowerReceived(P_tx, distance, lambda, L_o, k, W);

% pathloss model TMB in dBm
PL = L_o + 10 * lambda * log10(distance) + k * W * distance; 
fprintf('The pathloss value at a distance of (%f) is: -%.4f dBm \n', distance, PL)

P_rx = P_tx - PL; % received power = transmitter power - pathloss

end

