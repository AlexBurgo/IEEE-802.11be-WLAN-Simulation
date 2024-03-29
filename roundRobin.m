


function [SuccTx, DL_time, UL_time, frames, Ts] = roundRobin(MaxCycles, nSTAs, SS, P_rx, length, distance, SuccTx, opti, BW)

DL_TxSTA = zeros(1, nSTAs);
UL_TxSTA = zeros(1, nSTAs);
frames = zeros(1, nSTAs);
DL_time = 0; UL_time = 0; Ts = 0;

for i = 1:MaxCycles % TxtoSTA_1 ... TxtoSTA_N-1 TxtoSTA_N || TxtoSTA_1 ... TxtoSTA_N-1 TxtoSTA_N
    
    for j = 1:nSTAs
        
        [DL_TxSTA(j), UL_TxSTA(j), Nframes, prob_err] = wifiTransmissionTimeBasic(nSTAs, SS, P_rx(j), ...
            length, distance(j), opti, BW);
        if i < 2
            frames(j) = Nframes; 
        end

        if (rand > prob_err)
            SuccTx(j) = SuccTx(j) + 1; % successful transmissions/cycle in each STA
        end
        
        DL_time = DL_time + DL_TxSTA(j); % DL time addition
        UL_time = UL_time + UL_TxSTA(j); % UL time addition
        Ts = Ts + (DL_TxSTA(j) + UL_TxSTA(j)); % Total time per STA addition
    end
    
end

end
