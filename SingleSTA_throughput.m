% Si proves diferents valors de BW, has de tenir en compte que la potència
% tx és reparteix en el total d'amplada de banda, que és equivalent a dir 
% que la potència per subcarrier es redueix a la meitat, i que per tant, 
% augmentar el BW pot suposar una reducció del MCS a fer servir.

function SingleSTA_throughput()

% An AP tx to a STA using MCS = 8
% since there are no other STAs, MCSbasic = MCS

L=12000;    % packet size (bits)
NSS=2;      % SU spatial streams.
MCS=9;      % data rate
MCSbasic=9; % basic data rate (set to the minimum rate of the BSS)
BW=320;     % Bandwidth

[T_20]=WiFiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS);
S_20 = L/T_20;

BW=80;
[T_80]=WiFiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS);
S_80 = L/T_80;

% scale bps to Mbps
S_20 = S_20/1E6;
S_80 = S_80/1E6;

fprintf("Throughput at: 20 MHz, T = %.4f Mbps \n", S_20);
fprintf("Throughput at: 40 MHz, T = %.4f Mbps \n", S_80);

end