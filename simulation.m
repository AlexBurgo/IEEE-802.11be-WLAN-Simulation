


% tic; % timer
clear; clc; hold on;
i = 1; % iterator
b = 15; h = 15; % base & height
AP = [b/2 h/2]; % central AP
nSTAs = 4; % number of stations
P_tx = 21; % transmitted power by AP in dBm

draw = 1; % 1 - to plot the room, 0 - to not plot.

k = 5.25;       % attenuation of each wall
W = 0.1467;     % average number of traversed walls per meter
lambda = 2.06;  % attenuation factor
L_o = 54.1200;  % path loss intercept

NSS = 4; % SU spatial streams.
BW = 20; % bandwidth (MHz)

P_rx = zeros(nSTAs,1);         % initialize array received power
distance = zeros(nSTAs,1);     % initialize array distance
coordinates = zeros(nSTAs,2);  % initialize matrix coordinates 

while i <= nSTAs

    % random position generation of STAs
    j = 1;
    xSTA = rand * b; % x random position
    coordinates(i, j) = xSTA;
    j = 2;

    while j == 2
        ySTA = rand * h; % y random position
        coordinates(i, j) = ySTA;
        break;
    end

    if (draw == 1); plot(xSTA, ySTA, "*b", 'MarkerSize', 3); end % plots the STA

    distance(i) = distanceToAP(AP, coordinates(i, 1), coordinates(i, 2));
    P_rx(i) = STAPowerReceived(P_tx, distance(i), lambda, L_o, k, W); % received power

    %fprintf("--------------- STA number %d ---------------\n\n", i);
    %singleSTA_throughput(P_rx(i));

    i = i + 1;
end

distance = sort(distance,'ascend');
P_rx = sort(P_rx,'descend');
drawScenario(draw, b, h, P_rx, distance); 


DL_time = 0;
UL_time = 0;
MaxCycles = 1;
prob_err = 0.25;
DL_TxSTA = zeros(1, nSTAs);
UL_TxSTA = zeros(1, nSTAs);
SuccTx = zeros(1, nSTAs);
throughput = zeros(1, nSTAs);
length = 12e3; % data packet size (bits)

for i = 1:MaxCycles % TxtoSTA_1 ... TxtoSTA_N-1 TxtoSTA_N || TxtoSTA_1 ... TxtoSTA_N-1 TxtoSTA_N

    for j = 1:nSTAs
        % Ts = TxToSTA(j); % transmition time of each station
        [DL_TxSTA(j), UL_TxSTA(j)] = STATransmissionTime(nSTAs, NSS, BW, P_rx(j), length, distance(j));

        if (rand() < prob_err)
            SuccTx(j) = SuccTx(j) + 1; % successful transmissions/cycle in each STA
            % fprintf("The STA number %d had %d error(s)\n", j, SuccTx(j));
        end

        % time -> total time to transmit the packet to all STAs
        DL_time = DL_time + DL_TxSTA(j); % DL time addition
        UL_time = UL_time + UL_TxSTA(j); % UL time addition

    end

end

% Throughput = TxSTA_i * L / suma (TxSTA_j, per tot j)
% Downlink
fprintf("---------------- DOWNLINK TRANSMISSION -------------- \n");
for i = 1:nSTAs
    throughput(i) = length * DL_TxSTA(i) / DL_time;
    throughput(i) = throughput(i) / 1E6; % scale bps to Mbps
    fprintf("--- STA number %d --- \n", i);
    fprintf("Throughput = %.6f Mbps \n\n", throughput(i));

end

% Uplink
fprintf("---------------- UPLINK TRANSMISSION ---------------- \n");
for i = 1:nSTAs
    throughput(i) = length * UL_TxSTA(i) / UL_time;
    throughput(i) = throughput(i) / 1E6; % scale bps to Mbps
    fprintf("--- STA number %d --- \n", i);
    fprintf("Throughput = %.6f Mbps \n\n", throughput(i));

end

% toc; % timer
