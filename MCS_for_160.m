

function MCS = MCS_for_160(P_rx)

    if P_rx < -73 
        MCS = 0;
    elseif P_rx > -73 && P_rx < -70
        MCS = 1;
    elseif P_rx > -70 && P_rx < -68
        MCS = 2;
    elseif P_rx > -68 && P_rx < -65
        MCS = 3;
    elseif P_rx > -65 && P_rx < -70
        MCS = 4;
    elseif P_rx > -70 && P_rx < -66
        MCS = 5;
    elseif P_rx > -66 && P_rx < -65
        MCS = 6;
    elseif P_rx > -65 && P_rx < -64
        MCS = 7;
    elseif P_rx > -64 && P_rx < -59
        MCS = 8;
    elseif P_rx > -59 && P_rx < -57
        MCS = 9;
    end

end