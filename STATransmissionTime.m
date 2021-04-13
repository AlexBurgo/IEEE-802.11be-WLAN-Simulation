


function [DL_TxToSTA, UL_TxToSTA] = STATransmissionTime(BW, nSTAs, NSS, P_rx, Length, distance)

%check the best MCS for all possible bandwidth to optimize throughput
nBW = size(BW, 2);
possible_MCS = zeros(1, nBW);
best_BW = 0;

for i = 1:nBW
    possible_MCS(i) = modulationSelection(BW(i),P_rx);
end

indx = find(max(possible_MCS));

while possible_MCS(indx) == possible_MCS(indx + 1)
    
    indx = indx + 1;
    if indx == nBW
        break;
    end 
end

MCS = possible_MCS(indx);
MCSbasic = MCS;
best_BW = BW(indx);

[DL_TxToSTA, UL_TxToSTA] = wifiTransmissionTimeBasic(nSTAs, Length, best_BW, MCS, MCSbasic, NSS, distance);

end