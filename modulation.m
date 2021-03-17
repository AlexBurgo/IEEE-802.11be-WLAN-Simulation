

function MCS = modulation(BW,P_rx)

switch BW
    case 20
        MCS = MCS_for_20(P_rx)
    case 40
        MCS = MCS_for_40(P_rx)
    case 80
        MCS = MCS_for_80(P_rx)
    case 160
        MCS = MCS_for_160(P_rx)
    end

end