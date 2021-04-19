


function [DL_TxToSTA, UL_TxToSTA] = STATransmissionTime(nSTAs, NSS, P_rx, Length, distance, optimization_flag)

    if optimization_flag == 1
        BW = [20, 40, 80, 160, 320];
        [best_BW, MCS, MCSbasic] = optimization(BW, P_rx);
    else
        best_BW = 320; % change to obtain different results
        MCS = modulationSelection(best_BW, P_rx);
        MCSbasic = MCS;
    end

    [DL_TxToSTA, UL_TxToSTA] = wifiTransmissionTimeBasic(nSTAs, Length, best_BW, MCS, MCSbasic, NSS, distance);

end
