
% minimum receiver input sensitivity for 320 MHz

function [MCS, prob_err] = mcsFor320(P_rx)

prob_err = 0.05;
if P_rx > -70 && P_rx <= -67
    MCS = 0;
elseif P_rx > -67 && P_rx <= -65
    MCS = 1;
elseif P_rx > -65 && P_rx <= -62
    MCS = 2;
elseif P_rx > -62 && P_rx <= -58
    MCS = 3;
elseif P_rx > -58 && P_rx <= -54
    MCS = 4;
elseif P_rx > -54 && P_rx <= -53
    MCS = 5;
elseif P_rx > -53 && P_rx <= -52
    MCS = 6;
elseif P_rx > -52 && P_rx <= -47
    MCS = 7;
elseif P_rx > -47 && P_rx <= -45
    MCS = 8;
elseif P_rx > -45 && P_rx <= -42
    MCS = 9;
elseif P_rx > -42 && P_rx <= -40 % 1024-QAM
    MCS = 10;
elseif P_rx > -40 && P_rx <= -37 % 1024-QAM
    MCS = 11;
elseif P_rx > -37 && P_rx <= -34 % 4096-QAM
    MCS = 12;
elseif P_rx > -34 % 4096-QAM
    MCS = 13;
elseif P_rx <= -70
    %disp('Error: No communication!');
    MCS = 0;
    prob_err = 1;
end

end