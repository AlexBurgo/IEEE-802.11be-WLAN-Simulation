% Function to calculate the transmisison time in 11ax
% SU

% L: packet size (bits)
% BS: channel width
% MCS: data rate
% MCSbasic: basic data rate (set to the minimum rate of the BSS)
% NSS: SU spatial streams.
% NS: Data Subcarriers

function [T] = wifiTransmissionTimeBasic(L, BW, MCS, MCSbasic, NSS, distance)

dprop = distance/3E8; % Propagation delay

switch BW
    case 20
        Ns = 234; % 242-Tone RU 
        
    case 40
        Ns = 468; % 484-Tone RU
        
    case 80
        Ns = 980; % 996-Tone RU
        
    case 160
        Ns= 2*980; % 2x996 Tone RU
        
    case 320
        Ns = 4*980; % 11be (at 6 GHz)
        
    otherwise
        Ns = -1;
end

BOslots = 7.5; % BE AC
T_phy = 20E-6;
L_sf = 16;
L_tail = 6;
L_header = 272;
Lrts = 160;
Lcts = 112;
Lack = 112;

SIFS = 10E-6; % Short Inter-Frame Space
DIFS = 31E-6; % Distributed Inter-Frame Space
B_slot = 9E-6;

DBPS = 0;

switch MCS
    case 0 
        DBPS = 1/2*1; % BPSK
    case 1
        DBPS = 1/2*2; % QPSK
    case 2
        DBPS = 3/4*2; % QPSK
    case 3
        DBPS = 2/3*4; % 16-QAM
    case 4
        DBPS = 3/4*4; % 16-QAM
    case 5
        DBPS = 2/3*6; % 64-QAM
    case 6
        DBPS = 3/4*6; % 64-QAM
    case 7
        DBPS = 5/6*6; % 64-QAM
    case 8
        DBPS = 3/4*8; % 256-QAM
    case 9
        DBPS = 5/6*8; % 256-QAM
    case 10
        DBPS = 3/4*10; % 1024-QAM
    case 11
        DBPS = 5/6*10; % 1024-QAM
    case 12
        DBPS = 3/4*12; % 4096-QAM
    case 13
        DBPS = 5/6*12; % 4096-QAM
    otherwise
        DBPS = 0;
end

switch MCSbasic
    case 0 
        DBPSbasic = 1/2*1; % BPSK
    case 1
        DBPSbasic = 1/2*2; % QPSK
    case 2
        DBPSbasic = 3/4*2; % QPSK
    case 3
        DBPSbasic = 2/3*4; % 16-QAM
    case 4
        DBPSbasic = 3/4*4; % 16-QAM
    case 5
        DBPSbasic = 2/3*6; % 64-QAM
    case 6
        DBPSbasic = 3/4*6; % 64-QAM
    case 7
        DBPSbasic = 5/6*6; % 64-QAM
    case 8
        DBPSbasic = 3/4*8; % 256-QAM
    case 9
        DBPSbasic = 5/6*8; % 256-QAM
    case 10
        DBPSbasic = 3/4*10; % 1024-QAM
    case 11
        DBPSbasic = 5/6*10; % 1024-QAM
    case 12
        DBPSbasic = 3/4*12; % 4096-QAM
    case 13
        DBPSbasic = 5/6*12; % 4096-QAM
    otherwise
        DBPSbasic = 0;
end

DBPS = DBPS * Ns * NSS;
DBPSbasic = DBPSbasic * Ns;

T_ofdm = 16E-6;

T_bo = BOslots * B_slot; % backoff slot 
T_rts = T_phy + ceil(Lrts / DBPSbasic) * T_ofdm; % request-to-send 
T_cts = T_phy + ceil(Lcts / DBPSbasic) * T_ofdm; % clear-to-send
T_data = T_phy + ceil((L_sf + L_header + L + L_tail) / DBPS) * T_ofdm; % data frame
T_ack = T_phy + ceil(Lack / DBPSbasic) * T_ofdm; % acknowledgement

T = T_bo + T_rts + dprop + SIFS + T_cts + dprop + SIFS + ... 
    T_data + dprop + SIFS + T_ack + dprop + DIFS; % total time

end
