
function SingleSTA_throughput()

% An AP tx to a STA using MCS = 8
% since there are no other STAs, MCSbasic = MCS

L=12000;
NSS=2;
MCS=9;
MCSbasic=9;


BW=20;
[T_20]=WiFiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS);
S_20 = L/T_20;

BW=80;
[T_80]=WiFiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS);
S_80 = L/T_80;

disp('Throughput: 20 MHz | 40 MHz');
disp([S_20 S_80]);



end