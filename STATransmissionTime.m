


function [DL_TxToSTA, UL_TxToSTA] = STATransmissionTime(nSTAs, NSS, BW, P_rx, Length, distance)

MCS = modulationSelection(BW,P_rx); % modulation and coding scheme
MCSbasic = MCS;

[DL_TxToSTA, UL_TxToSTA] = wifiTransmissionTimeBasic(nSTAs, Length, BW, MCS, MCSbasic, NSS, distance);

end