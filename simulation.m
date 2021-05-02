


clear; clc;

b = 35; h = 35;   % base & height dimensions in 'meters'
AP = [b/2 h/2];   % central access point
nSTAs = 4;        % number of stations
MaxCycles = 1e6;  % # round robin cycles
NSS = 2;          % SU spatial streams.
length = 12e3;    % data packet size (bits)
SuccTx = zeros(1, nSTAs);

opti = 1;  % 1 - to activate MCS & BW optimization algorithm 0 - otherwise1
draw = 1;  % 1 - to plot figures 0 - otherwise.

[distance, P_rx, coordinates] = room(nSTAs, b, h, AP);

P_rx = sort(P_rx, 'descend');
distance = sort(distance, 'ascend');
drawScenario(draw, b, h, P_rx, distance, coordinates);

% round-robin
[SuccTx, DL_time, UL_time, frames, Ts] = roundRobin(MaxCycles, nSTAs, ...
    NSS, P_rx, length, distance, SuccTx, opti);

% throughput calculus
throughput(nSTAs, SuccTx, length, DL_time, UL_time, frames, Ts, draw)