% Si proves diferents valors de BW, has de tenir en compte que la potència
% tx és reparteix en el total d'amplada de banda, que és equivalent a dir
% que la potència per subcarrier es redueix a la meitat, i que per tant,
% augmentar el BW pot suposar una reducció del MCS a fer servir.

% Ara, el proper pas és trobar el MCS que farà servir cada estació a partir
% de la potència rebuda que has calculat. No recordo si el codi que et vaig
% passar, ja ho tenia inclòs, però si no, és implementar la següent taula:
% https://es.mathworks.com/help/wlan/ug/802-11ac-receiver-minimum-input-sensitivity-test.html
% I a partir d'aquí, calcular el temps de transmissió. Fixa't que a més
% amplada de banda, la sensibilitat s'incrementa, que bàsicament vol dir
% que si augmentem l'amplada de banda que utilitzem, pot ser necessari fer
% servir un MCS inferior, i no acabar guanyant res.

function SingleSTA_throughput(P_rx)

% An AP tx to a STA using MCS = 8
% since there are no other STAs, MCSbasic = MCS

L=12e3;     % packet size (bits)
NSS=2;      % SU spatial streams.
%MCS=9;      % data rate
%MCSbasic=9; % basic data rate (set to the minimum rate of the BSS)

BW=20;  % Bandwidth
MCS = modulationSelection(BW,P_rx); % modulation coding scheme
MCSbasic = MCS;
[T_20]=wifiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS,P_rx);
S_20 = L/T_20; 
S_20 = S_20/1E6; % scale bps to Mbps

fprintf("For B = %dMHz the MCS = %d\n", BW, MCS);
fprintf("Throughput and Transmission Time with: %dMHz " + newline + ... 
"T = %.4f Mbps, TxTime = %f secs\n\n", BW, S_20, T_20);

BW=80;  % Bandwidth
MCS = modulationSelection(BW,P_rx); % modulation coding scheme
MCSbasic = MCS;
[T_80]=wifiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS,P_rx);
S_80 = L/T_80;
S_80 = S_80/1E6; % scale bps to Mbps

fprintf("For B = %dMHz the MCS = %d\n", BW, MCS);
fprintf("Throughput and Transmission Time with: %dMHz " + newline + ... 
"T = %.4f Mbps, TxTime = %f secs\n\n", BW, S_80, T_80);

end