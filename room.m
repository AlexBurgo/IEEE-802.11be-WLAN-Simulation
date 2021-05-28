


function [distance, P_rx, coordinates] = room(nSTAs, b, h, AP)

i = 1;  % iterator
P_rx = zeros(nSTAs,1);         % initialize array received power
distance = zeros(nSTAs,1);     % initialize array distance
coordinates = zeros(nSTAs,2);  % initialize matrix coordinates

%fixedposX = [0.46 0.31 0.74 0.85];
%fixedposY = [0.57 0.19 0.56 0.5];

%fixedposX = [0.46 0.44 0.69 0.65];
%fixedposY = [0.57 0.34 0.63 0.5];

fixedposX = [0.46 0.44 0.74 0.85];
fixedposY = [0.57 0.34 0.81 0.5];

% ANTERIOR VERSION DE POSICIONES
%fixedposX = [0.46 0.31 0.74 0.85];
%fixedposY = [0.57 0.19 0.81 0.50];

% PUNTOS LEJOS
%fixedposX = [0.86 0.14 0.84 0.05];
%fixedposY = [0.77 0.24 0.11 0.95];

% PUNTOS CERCA
%fixedposY = [0.55 0.48 0.55 0.48];
%fixedposX = [0.55 0.48 0.55 0.48];

% TODAS LAS STAS EN MISMO PUNTO 
%fixedposX = [0.52 0.52 0.52 0.52];
%fixedposY = [0.52 0.52 0.52 0.52];

P_tx = 21;      % transmitted power by AP in dBm

while i <= nSTAs

    % random position generation of STAs
    j = 1;
    %xSTA = rand * b; % x random position
    xSTA = fixedposX(i) .* b; % x random position
    coordinates(i, j) = xSTA;
    j = 2;

    while j == 2
        %ySTA = rand * h; % y random position
        ySTA = fixedposY(i) .* h; % y random position
        coordinates(i, j) = ySTA;
        break;
    end

    distance(i) = distanceToAP(AP, coordinates(i, 1), coordinates(i, 2));
    P_rx(i) = STAPowerReceived(P_tx, distance(i)); % received power
    
    i = i + 1;
end

end
