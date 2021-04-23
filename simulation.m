


clear; clc;

b = 15; h = 15;   % base & height dimensions in 'meters'
AP = [b/2 h/2];   % central access point
nSTAs = 4;        % number of stations
MaxCycles = 1e6;  % # round robin cycles
NSS = 4;          % SU spatial streams.
length = 12e3;    % data packet size (bits)
SuccTx = zeros(1, nSTAs);

optimization_flag = 1;  % 1 - to activate MCS & BW optimization algorithm 0 - otherwise
draw = 0;               % 1 - to plot the room 0 - otherwise.

if draw == 1
    hold on;
end

[distance, P_rx] = room(nSTAs, b, h, AP, draw); 

P_rx = sort(P_rx, 'descend');
distance = sort(distance, 'ascend');
drawScenario(draw, b, h, P_rx, distance);

% round-robin
[SuccTx, DL_time, UL_time, frames] = roundRobin(MaxCycles, nSTAs, ... 
NSS, P_rx, length, distance, SuccTx, optimization_flag);

% throughput calculus
throughput(nSTAs, SuccTx, length, MaxCycles, DL_time, UL_time, frames)