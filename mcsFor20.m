

function MCS = mcsFor20(P_rx)

    if P_rx > -82 && P_rx < -79
        MCS = 0;
    elseif P_rx > -79 && P_rx < -77
        MCS = 1;
    elseif P_rx > -77 && P_rx < -74
        MCS = 2;
    elseif P_rx > -74 && P_rx < -70
        MCS = 3;
    elseif P_rx > -70 && P_rx < -66
        MCS = 4;
    elseif P_rx > -66 && P_rx < -65
        MCS = 5;
    elseif P_rx > -65 && P_rx < -64
        MCS = 6;
    elseif P_rx > -64 && P_rx < -59
        MCS = 7;
    elseif P_rx > -59 && P_rx < -57
        MCS = 8;
    elseif P_rx > -59 
        MCS = 9;
    end

end