


function [DBPS, DBPSbasic, perr] = optimization(P_rx, NSS)

possible_BW = [20, 40, 80, 160, 320];
Nsubc = [234, 468, 980, 1960, 3920]; % num. subcarriers
n = size(possible_BW, 2);
rate = zeros(1, n);
possible_MCS = zeros(1, n); % initialize possible_MCS array
possible_dBPS = zeros(1, n);
prob_err = zeros(1, n);

% get all possible MCS
for i = 1:n
    [possible_MCS(i), prob_err(i)] = modulationSelection(possible_BW(i), P_rx, NSS);
end

for i = 1:n
    
    switch possible_MCS(i)
        case 0
            rate(i) = 1/2 * 1; % BPSK
        case 1
            rate(i) = 1/2 * 2; % QPSK
        case 2
            rate(i) = 3/4 * 2; % QPSK
        case 3
            rate(i) = 2/3 * 4; % 16-QAM
        case 4
            rate(i) = 3/4 * 4; % 16-QAM
        case 5
            rate(i) = 2/3 * 6; % 64-QAM
        case 6
            rate(i) = 3/4 * 6; % 64-QAM
        case 7
            rate(i) = 5/6 * 6; % 64-QAM
        case 8
            rate(i) = 3/4 * 8; % 256-QAM
        case 9
            rate(i) = 5/6 * 8; % 256-QAM
        case 10
            rate(i) = 3/4 * 10; % 1024-QAM
        case 11
            rate(i) = 5/6 * 10; % 1024-QAM
        case 12
            rate(i) = 3/4 * 12; % 4096-QAM
        case 13
            rate(i) = 5/6 * 12; % 4096-QAM
        otherwise
            rate(i) = 0;
    end
    
end

for i = 1:n
    possible_dBPS(i) = rate(i) * Nsubc(i) * NSS;
end

indx = 5;
perr = prob_err(indx);

while perr == 1
    possible_dBPS(indx) = [];
    indx = indx - 1;
    perr = prob_err(indx);
end

aux = max(possible_dBPS);
indx = find(possible_dBPS == aux);
if size(indx,2) > 1
    indx = indx(end);
end

Ns = Nsubc(indx);
DBPS = rate(indx);
DBPSbasic = rate(indx);
DBPS = DBPS * Ns * NSS;
DBPSbasic = DBPSbasic * Ns;
end
