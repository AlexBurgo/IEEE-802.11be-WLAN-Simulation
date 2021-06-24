


function [distance, P_rx, coordinates] = room(nSTAs, b, h, AP, fixedposY)

i = 1; % iterator
P_rx = zeros(nSTAs, 1); % initialize received power array
distance = zeros(nSTAs, 1); % initialize distance array
coordinates = zeros(nSTAs, 2); % initialize coordinates matrix
fixedposX = 0.5;

% STAs POSITIONS FOR SPATIAL STREAMS & BW CASE
% fixedposX = [0.46 0.44 0.66 0.65];
% fixedposY = [0.57 0.34 0.66 0.5];

% ONE STATION NEXT TO THE AP
%fixedposX = 0.50;
%fixedposY = 0.508;

% OPTIMIZATION AND NOT (1)
% fixedposX = [0.46 0.5 0.60 0.35];
% fixedposY = [0.47 0.7 0.40 0.34];

% OPTIMIZATION AND NOT (2) FAR AWAY
% fixedposX = [0.29 0.5 0.64 0.45];
% fixedposY = [0.47 0.7 0.37 0.30];

% OPTIMIZATION AND NOT (3) CLOSE TO AP
% fixedposX = [0.47 0.46 0.53 0.51];
% fixedposY = [0.54 0.47 0.5 0.48];

% OPTIMIZATION AND NOT (4) RANDOM
% fixedposX = [0.47 0.66 0.97 0.31];
% fixedposY = [0.54 0.53 0.96 0.61];

% OPTIMIZATION AND NOT (5) RANDOM
% fixedposX = [0.27 0.76 0.97 0.31];
% fixedposY = [0.34 0.23 0.86 0.11];

% FRAME AGG VS NO A-MPDU
% fixedposX = [0.40 0.52 0.53 0.66];
% fixedposY = [0.60 0.33 0.47 0.35];

% 11AX vs 11BE
% seed = 1;
% rng(seed);
% fixedposX = rand([1, nSTAs]);
% fixedposY = rand([1, nSTAs]);

P_tx = 21; % transmitted power by AP in dBm

while i <= nSTAs
    
    % random position generation of STAs
    j = 1;
    %xSTA = rand * b; % x random position
    xSTA = fixedposX(i) .* b; % x position
    coordinates(i, j) = xSTA;
    j = 2;
    
    while j == 2
        %ySTA = rand * h; % y random position
        ySTA = fixedposY(i) .* h; % y position
        coordinates(i, j) = ySTA;
        break;
    end
    
    distance(i) = distanceToAP(AP, coordinates(i, 1), coordinates(i, 2));
    P_rx(i) = STAPowerReceived(P_tx, distance(i)); % received power
    
    i = i + 1;
end

end
