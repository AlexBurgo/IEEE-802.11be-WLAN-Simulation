% Respecte als resultats. De moment, et proposo començar amb 'generar'
% escenaris en Matlab. Quelcom tan senzill com definir un àrea rectangular
% de x*y metres, posar un AP al mig i N estacions repartides aleatòriament
% a l'àrea. Un cop tinguis l'escenari, calcula les distàncies entre l'AP
% i cada estació, i calcula la potència rebuda a cada una d'elles.
% Per això pots fer servir un model de propagació com el TMB
% https://arxiv.org/abs/1812.00667

% Et paso aquest parell de funcions. Es una manera senzilla de calcular el 
% throughput d'una estació. Seguint el que et deia ahir, et queda crear la 
% xarxa, per cada estació calcular la distància entre l'AP i ella mateixa, 
% calcular la potència rebuda, escollir el MCS a fer servir, i finalment 
% treure el throughput que pot assolir cada estació. Si proves diferents 
% valors de BW, has de tenir en compte que la potència tx és reparteix en 
% el total d'amplada de banda, que és equivalent a dir que la potència per 
% subcarrier es redueix a la meitat, i que per tant, augmentar el BW pot 
% suposar una reducció del MCS a fer servir.

tic; % timer
clear all; clc; hold on;
i = 1; % iterator
b = 10; h = 10; % base & height
AP = [b/2 h/2]; % central AP
nSTAs = 20; % number of stations
P_tx = 21 % transmitted power by AP in (dBm)
draw_scenario = 1; % 1 - to plot the room, 0 - to not plot.
coordinates = zeros(nSTAs,2);
distance = zeros(nSTAs,1);

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
    if (draw_scenario == 1); plot(xSTA, ySTA, "*b", 'MarkerSize', 3); end % plots the STA
    distance(i) = DistanceToAP(AP,coordinates(i,1),coordinates(i,2));
    i = i+1;
end

P_rx = STAPowerReceived(P_tx, distance(iterator));

if (draw_scenario == 1) 
    pgon = polyshape([0 0 b h],[h 0 0 b]); % creates the simulation area
    pg = plot(pgon); % plots the simulation area
    pg.FaceAlpha = 0; % transparency ON of the area
    hold on;
    plot(b/2, h/2, "*r", 'MarkerSize', 3); % plots the central AP
end
%title('Scenario'); xlabel('x metres'); ylabel('y metres');
toc; % timer