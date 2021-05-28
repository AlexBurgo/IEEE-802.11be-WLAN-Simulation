


function [MCS, prob_err] = modulationSelection(BW, P_rx, SS)

P_rx =  P_rx - 10*log10(SS); % We reduce 3dB every time we double the channel

switch BW
    case 20
        [MCS, prob_err] = mcsFor20(P_rx);
    case 40
        [MCS, prob_err] = mcsFor40(P_rx);
    case 80
        [MCS, prob_err] = mcsFor80(P_rx);
    case 160
        [MCS, prob_err] = mcsFor160(P_rx);
    case 320
        [MCS, prob_err] = mcsFor320(P_rx); % 11be
end

end
