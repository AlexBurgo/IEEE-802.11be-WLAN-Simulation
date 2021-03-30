


function [TxToSTA] = STATransmissionTime(NSS, BW, P_rx, Length, distance)

MCS = modulationSelection(BW,P_rx); % modulation coding scheme
MCSbasic = MCS;

[TxToSTA] = wifiTransmissionTimeBasic(Length, BW, MCS, MCSbasic, NSS, distance);

end