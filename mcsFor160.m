


function MCS = mcsFor160(P_rx)

    if P_rx > -73 && P_rx < -70 
        MCS = 0;
    elseif P_rx > -70 && P_rx < -68
        MCS = 1;
    elseif P_rx > -68 && P_rx < -65
        MCS = 2;
    elseif P_rx > -65 && P_rx < -61
        MCS = 3;
    elseif P_rx > -61 && P_rx < -57
        MCS = 4;
    elseif P_rx > -57 && P_rx < -56
        MCS = 5;
    elseif P_rx > -56 && P_rx < -55
        MCS = 6;
    elseif P_rx > -55 && P_rx < -50
        MCS = 7;
    elseif P_rx > -50 && P_rx < -48
        MCS = 8;
    elseif P_rx > -48
        MCS = 9;
    end

end