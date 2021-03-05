% Function to calculate the transmisison time in 11ax
% SU

% L: packet size (bits)
% BS: channel width
% MCS: data rate
% MCSbasic: basic data rate (set to the minimum rate of the BSS)
% NSS: SU spatial streams.

function [T] = WiFiTransmissionTimeBasic(L,BW,MCS,MCSbasic,NSS)

dprop = 20/3E8; % Propagation delay

switch BW
    case 20
        Ns = 234;
        
    case 40
        Ns = 468;
        
    case 80
        Ns = 980;
        
    case 160
        Ns= 2*980;
        
    case 320
        Ns = 4*980; % 11be (at 6 GHz)
        
    otherwise
        Ns = -1;
end


BOslots = 7.5; % BE AC
T_phy=20E-6;
L_sf = 16;
L_tail = 6;
L_header = 272;
Lrts=160;
Lcts=112;
Lack=112;

SIFS = 10E-6;
DIFS = 31E-6;
B_slot = 9E-6;

DBPS = 0;

switch MCS
    case 0 
        DBPS = 1/2*1;
    case 1
        DBPS = 1/2*2;
    case 2
        DBPS = 3/4*2;
    case 3
        DBPS = 2/3*4;
    case 4
        DBPS = 3/4*4;
    case 5
        DBPS = 2/3*6;
    case 6
        DBPS = 3/4*6;
    case 7
        DBPS = 5/6*6;
    case 8
        DBPS = 3/4*8;
    case 9
        DBPS = 5/6*8;
    case 10
        DBPS = 3/4*10;
    case 11
        DBPS = 5/6*10;
    otherwise
        DBPS = 0;
end

switch MCSbasic
    case 0 
        DBPSbasic = 1/2*1;
    case 1
        DBPSbasic = 1/2*2;
    case 2
        DBPSbasic = 3/4*2;
    case 3
        DBPSbasic = 2/3*4;
    case 4
        DBPSbasic = 3/4*4;
    case 5
        DBPSbasic = 2/3*6;
    case 6
        DBPSbasic = 3/4*6;
    case 7
        DBPSbasic = 5/6*6;
    case 8
        DBPSbasic = 3/4*8;
    case 9
        DBPSbasic = 5/6*8;
    case 10
        DBPSbasic = 3/4*10;
    case 11
        DBPSbasic = 5/6*10;
    otherwise
        DBPSbasic = 0;
end

DBPS = DBPS*Ns*NSS;
DBPSbasic = DBPSbasic*Ns;

T_ofdm = 16E-6;

T_bo = BOslots*B_slot;
T_rts = T_phy+ceil(Lrts/DBPSbasic)*T_ofdm;
T_cts = T_phy+ceil(Lcts/DBPSbasic)*T_ofdm;
T_data = T_phy+ceil((L_sf + L_header+L + L_tail)/DBPS)*T_ofdm;
T_ack = T_phy+ceil(Lack/DBPSbasic)*T_ofdm;

T = T_bo + T_rts + dprop + SIFS + T_cts + dprop  + SIFS + ... 
    T_data + dprop + SIFS + T_ack + dprop + DIFS;

end
