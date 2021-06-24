
% minimum receiver input sensitivity for 160 MHz

function [MCS, prob_err] = mcsFor160(P_rx)

prob_err = 0.05;
if P_rx > -73 && P_rx <= -70
    MCS = 0;
elseif P_rx > -70 && P_rx <= -68
    MCS = 1;
elseif P_rx > -68 && P_rx <= -65
    MCS = 2;
elseif P_rx > -65 && P_rx <= -61
    MCS = 3;
elseif P_rx > -61 && P_rx <= -57
    MCS = 4;
elseif P_rx > -57 && P_rx <= -56
    MCS = 5;
elseif P_rx > -56 && P_rx <= -55
    MCS = 6;
elseif P_rx > -55 && P_rx <= -50
    MCS = 7;
elseif P_rx > -50 && P_rx <= -48
    MCS = 8;
elseif P_rx > -48 && P_rx <= -45
    MCS = 9;
elseif P_rx > -45 && P_rx <= -43
    MCS = 10;
elseif P_rx > -43 && P_rx <= -40
    MCS = 11;
elseif P_rx > -40 && P_rx <= -37
    MCS = 12;
elseif P_rx > -37
    MCS = 13;
elseif P_rx <= -73
    %disp('Error: No communication!');
    MCS = 0;
    prob_err = 1;
end

end