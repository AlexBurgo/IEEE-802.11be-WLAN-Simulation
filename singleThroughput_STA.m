


function singleThroughput_STA(P_rx)

L = 12e3;     % packet size (bits)
NSS = 2;      % SU spatial streams.
% MCS is the data rate
% MCSbasic is the basic data rate (set to the minimum rate of the BSS)

BW = 20;  % Bandwidth, 3dbm -> 2.0 mW
MCS = modulationSelection(BW,P_rx); % modulation coding scheme
MCSbasic = MCS;
[T_20] = wifiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS);
S_20 = L/T_20; 
S_20 = S_20/1E6; % scale bps to Mbps

fprintf("For B = %dMHz the MCS = %d\n", BW, MCS);
fprintf("Throughput and Transmission Time with: %dMHz " + newline + ... 
"T = %.4f Mbps, TxTime = %f secs\n\n", BW, S_20, T_20);

BW = 80;  % Bandwidth, 3dbm -> 2.0 mW
MCS = modulationSelection(BW,P_rx); % modulation coding scheme
MCSbasic = MCS;
[T_80] = wifiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS);
S_80 = L/T_80;
S_80 = S_80/1E6; % scale bps to Mbps

fprintf("For B = %dMHz the MCS = %d\n", BW, MCS);
fprintf("Throughput and Transmission Time with: %dMHz " + newline + ... 
"T = %.4f Mbps, TxTime = %f secs\n\n", BW, S_80, T_80);

end    