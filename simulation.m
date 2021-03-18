% Et paso aquest parell de funcions. Es una manera senzilla de calcular el 
% throughput d'una estació. Seguint el que et deia ahir, et queda crear la 
% xarxa, per cada estació calcular la distància entre l'AP i ella mateixa, 
% calcular la potència rebuda, escollir el MCS a fer servir, i finalment 
% treure el throughput que pot assolir cada estació. 

% tic; % timer
clear all; clc; hold on;
i = 1; % iterator
b = 10; h = 10; % base & height
AP = [b/2 h/2]; % central AP
nSTAs = 10; % number of stations
P_tx = 21; % transmitted power by AP in dBm

draw = 1; % 1 - to plot the room, 0 - to not plot.

lambda = 2.06;  % attenuation factor
L_o = 54.1200;  % path loss intercept
k = 5.25;       % attenuation of each wall
W = 0.1467;     % average number of traversed walls per meter

coordinates = zeros(nSTAs,2);  % initialize matrix coordinates 
distance = zeros(nSTAs,1);     % initialize array distance
P_rx = zeros(nSTAs,1);         % initialize array received power

while i <= nSTAs
    
    % random position generation of STAs
    j = 1;
    xSTA = rand*b; % x random position
    coordinates(i,j) = xSTA; 
    j = 2;
    while j == 2
        ySTA = rand*h; % y random position 
        coordinates(i,j) = ySTA;
        break;
    end
    if (draw == 1); plot(xSTA, ySTA, "*b", 'MarkerSize', 3); end % plots the STA
    distance(i) = DistanceToAP(AP,coordinates(i,1),coordinates(i,2));
    P_rx(i) = STAPowerReceived(P_tx, distance(i), lambda, L_o, k, W); % received power
    SingleSTA_throughput(P_rx(i));
    i = i+1;
end

distance = sort(distance,'ascend');
P_rx = sort(P_rx,'descend');

if (draw == 1); draw_scenario(draw, b, h, P_rx, distance); end

% toc; % timer