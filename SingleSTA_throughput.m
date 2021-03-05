
function SingleSTA_throughput()

% An AP tx to a STA using MCS = 8
% since there are no other STAs, MCSbasic = MCS

L=12000;
NSS=2; 
MCS=9;
MCSbasic=9;

BW=320; % bandwidth
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

%disp('Throughput: 20 MHz | 40 MHz');
%disp([S_20 S_80]);

end