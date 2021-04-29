


function [distance, P_rx, coordinates] = room(nSTAs, b, h, AP)

i = 1; % iterator
P_rx = zeros(nSTAs, 1); % initialize array received power
distance = zeros(nSTAs, 1); % initialize array distance
coordinates = zeros(nSTAs, 2); % initialize matrix coordinates
fixedposX = [0.21 0.43 0.75 0.85];
fixedposY = [0.5 0.09 0.61 0.5];

P_tx = 21; % transmitted power by AP in dBm

while i <= nSTAs
    
    % random position generation of STAs
    j = 1;
    % xSTA = rand * b; % x random position
    xSTA = fixedposX(i) .* b; % x random position
    coordinates(i, j) = xSTA;
    j = 2;
    
    while j == 2
        % ySTA = rand * h; % y random position
        ySTA = fixedposY(i) .* h; % y random position
        coordinates(i, j) = ySTA;
        break;
    end
    
    distance(i) = distanceToAP(AP, coordinates(i, 1), coordinates(i, 2));
    P_rx(i) = STAPowerReceived(P_tx, distance(i)); % received power
    
    i = i + 1;
end

end
