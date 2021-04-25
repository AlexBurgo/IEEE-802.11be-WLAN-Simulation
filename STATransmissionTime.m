


function [DL_TxToSTA, UL_TxToSTA] = STATransmissionTime(nSTAs, NSS, P_rx, Length, distance, opti)

[DL_TxToSTA, UL_TxToSTA] = wifiTransmissionTimeBasic(nSTAs, NSS, P_rx, Length, distance, opti);

end
