


function [DL_TxToSTA, UL_TxToSTA] = STATransmissionTime(BW, nSTAs, NSS, P_rx, Length, distance)

[best_BW, MCS, MCSbasic] = optimization(BW, P_rx);

[DL_TxToSTA, UL_TxToSTA] = wifiTransmissionTimeBasic(nSTAs, Length, best_BW, MCS, MCSbasic, NSS, distance);

end