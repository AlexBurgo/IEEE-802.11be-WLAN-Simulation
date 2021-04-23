
% minimum receiver input sensitivity for 80 MHz

function MCS = mcsFor80(P_rx)

    if P_rx > -76 && P_rx <= -73 
        MCS = 0;
    elseif P_rx > -73 && P_rx <= -71
        MCS = 1;
    elseif P_rx > -71 && P_rx <= -68
        MCS = 2;
    elseif P_rx > -68 && P_rx <= -64
        MCS = 3;
    elseif P_rx > -64 && P_rx <= -60
        MCS = 4;
    elseif P_rx > -60 && P_rx <= -59
        MCS = 5;
    elseif P_rx > -59 && P_rx <= -58
        MCS = 6;
    elseif P_rx > -58 && P_rx <= -53
        MCS = 7;
    elseif P_rx > -53 && P_rx <= -51
        MCS = 8;
    elseif P_rx > -51 && P_rx <= -48
        MCS = 9;
    elseif P_rx > -48 && P_rx <= -46 
        MCS = 10;
    elseif P_rx > -46 && P_rx <= -43 
        MCS = 11;
    elseif P_rx > -43 && P_rx <= -40 
        MCS = 12;
    elseif P_rx > -40 
        MCS = 13;
    elseif P_rx <= -76
        MCS = 0;
    end

end