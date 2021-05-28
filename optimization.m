


function [DBPS, DBPSbasic, prob_err] = optimization(P_rx)

SS = [2, 4, 8, 16]; % possible spatial streams
possible_BW = [20, 40, 80, 160, 320]; % possible channel width
Nsubc = [234, 468, 980, 1960, 3920]; % num. subcarriers
nss = size(SS, 2);
mDBPS = zeros(1, nss);
DBPSbasic = zeros(1, nss);
n = size(possible_BW, 2);

for j = 1:nss

    rate = zeros(1, n); % initialize possible rates
    perr = zeros(1, n); % initialize possible error prob
    possible_MCS = zeros(1, n); % initialize possible_MCS array
    possible_dBPS = zeros(1, n); % initialize possible_dbps

    % get all possible MCS
    for i = 1:n
    [possible_MCS(i), perr(i)] = modulationSelection(possible_BW(i), P_rx, SS(j));
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
                rate(i) = 1/2 * 4; % 16-QAM
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
        possible_dBPS(i) = rate(i) * Nsubc(i) * SS(j);
    end

    indx = 5;
    err(j) = perr(indx);

    while err(j) == 1 && indx > 1
        if perr(1) == 1
            break;
        end
        possible_dBPS(indx) = [];
        indx = indx - 1;
        err(j) = perr(indx);
    end

    aux = max(possible_dBPS);
    indx = find(possible_dBPS == aux);
    if size(indx, 2) > 1
        indx = indx(end);
    end

    Ns = Nsubc(indx);
    DBPS = rate(indx);
    DBPSb = rate(indx);
    mDBPS(j) = DBPS * Ns * SS(j);
    DBPSbasic(j) = DBPSb * Ns;

end

indx = 4;

while err(indx) == 1 && indx > 1
    if err(1) == 1
        break;
    end
    mDBPS(indx) = [];
    indx = indx - 1;
end

DBPS = max(mDBPS);
indx = find(mDBPS == DBPS);
if size(indx, 2) > 1
    indx = indx(end);
end
DBPS = mDBPS(indx);
DBPSbasic = DBPSbasic(indx);
prob_err = err(indx);

end
