


function MCS = modulationSelection(BW, P_rx, NSS)

P_rx =  P_rx - 10*log10(NSS); % We reduce 3dB every time we double the channel

switch BW
    case 20
        MCS = mcsFor20(P_rx);
    case 40
        MCS = mcsFor40(P_rx);
    case 80
        MCS = mcsFor80(P_rx);
    case 160
        MCS = mcsFor160(P_rx);
    case 320
        MCS = mcsFor320(P_rx); % 11be
end

end
