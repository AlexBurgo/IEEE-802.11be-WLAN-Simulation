


function [DL_TxToSTA, UL_TxToSTA, Nframes] = STATransmissionTime(nSTAs, NSS, P_rx, Length, distance, optimization)

[DL_TxToSTA, UL_TxToSTA, Nframes] = wifiTransmissionTimeBasic(nSTAs, NSS, P_rx, Length, distance, optimization);

end