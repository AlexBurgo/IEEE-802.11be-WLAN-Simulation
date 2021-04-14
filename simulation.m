


clear; clc;

b = 15; h = 15; % base & height dimensions in 'm'
AP = [b/2 h/2]; % central access point
nSTAs = 4;      % number of stations

draw = 1;       % 1 - to plot the room, 0 - to not plot.
if draw == 1
    hold on;
end

[distance, P_rx] = room(nSTAs, b, h, AP, draw);

P_rx = sort(P_rx, 'descend');
distance = sort(distance, 'ascend');
drawScenario(draw, b, h, P_rx, distance);

BW = [20, 40, 80, 160, 320];
NSS = 2; % SU spatial streams.
MaxCycles = 1e5;
SuccTx = zeros(1, nSTAs);
length = 12e3; % data packet size (bits)

% round-robin
[SuccTx, DL_time, UL_time] = roundRobin(MaxCycles, BW, nSTAs, ... 
NSS, P_rx, length, distance, SuccTx);

% throughput operation
throughput(nSTAs, SuccTx, length, MaxCycles, DL_time, UL_time)

% Doncs ara, et toca pensar que vols 'estudiar' del 11be. Una opció 'fàcil' és:
% nous MCSs + Canals de 320 MHz: veure quin és l'impacte d'incrementar més l'amplada 
% de banda del canal. Per estacions 'properes' pot ser bo, però per distants, potser no.

% I la pregunta de recerca seria: donat un escenari, assumint que l'AP coneix la 
% SNR de totes les STAs, pots trobar un algoritme que assigni la millor amplada 
% de canal a cada STA de manera que el throughput agregat de la xarxa és maximitzi? 

% Mira si 11be introdueix algun nou MCS, i extrapola quina pinta pot tenir la 
% taula per els MCS amb 320 MHz (fixa't que hi ha 3 dB de diferència quan augmentes el BW).