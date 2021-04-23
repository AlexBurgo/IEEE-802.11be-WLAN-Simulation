
% minimum receiver input sensitivity for 40 MHz

function MCS = mcsFor40(P_rx)

    if P_rx > -79 && P_rx <= -76 
        MCS = 0;
    elseif P_rx > -76 && P_rx <= -74
        MCS = 1;
    elseif P_rx > -74 && P_rx <= -71
        MCS = 2;
    elseif P_rx > -71 && P_rx <= -67
        MCS = 3;
    elseif P_rx > -67 && P_rx <= -63
        MCS = 4;
    elseif P_rx > -63 && P_rx <= -62
        MCS = 5;
    elseif P_rx > -62 && P_rx <= -61
        MCS = 6;
    elseif P_rx > -61 && P_rx <= -56
        MCS = 7;
    elseif P_rx > -56 && P_rx <= -54
        MCS = 8;
    elseif P_rx > -54 && P_rx <= -51 
        MCS = 9;
    elseif P_rx > -51 && P_rx <= -49 
        MCS = 10;
    elseif P_rx > -49 && P_rx <= -46 
        MCS = 11;
    elseif P_rx > -46 && P_rx <= -43 
        MCS = 12;
    elseif P_rx > -43 
        MCS = 13;
    elseif P_rx <= -79
        MCS = 0;
    end

end