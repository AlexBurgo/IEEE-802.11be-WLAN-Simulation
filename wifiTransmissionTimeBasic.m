% Function to calculate the transmisison time in 11ax
% SU

% L: packet size (bits)
% BS: channel width
% MCS: data rate
% MCSbasic: basic data rate (set to the minimum rate of the BSS)
% NSS: SU spatial streams.
% NS: Data Subcarriers

function [SU_DL_Time, SU_UL_Time, prob_err] = wifiTransmissionTimeBasic(nSTAs, NSS, P_rx, L_data, distance, opti)

dprop = distance/3E8; % Propagation delay

if opti == 1
    [DBPS, DBPSbasic, prob_err] = optimization(P_rx, NSS);
else
    BW = 320; % change to obtain different results
    switch BW % selects the number of subcarriers
        case 20
            Ns = 234; % 242-Tone RU
        case 40
            Ns = 468; % 484-Tone RU
        case 80
            Ns = 980; % 996-Tone RU
        case 160
            Ns = 2 * 980; % 2x996 Tone RU
        case 320
            Ns = 4 * 980; % 11be (at 6 GHz)
        otherwise
            Ns = -1;
    end
    [MCS, prob_err] = modulationSelection(BW, P_rx, NSS);
    MCSbasic = MCS;
    switch MCS
        case 0
            DBPS = 1/2 * 1; % BPSK
        case 1
            DBPS = 1/2 * 2; % QPSK
        case 2
            DBPS = 3/4 * 2; % QPSK
        case 3
            DBPS = 2/3 * 4; % 16-QAM
        case 4
            DBPS = 3/4 * 4; % 16-QAM
        case 5
            DBPS = 2/3 * 6; % 64-QAM
        case 6
            DBPS = 3/4 * 6; % 64-QAM
        case 7
            DBPS = 5/6 * 6; % 64-QAM
        case 8
            DBPS = 3/4 * 8; % 256-QAM
        case 9
            DBPS = 5/6 * 8; % 256-QAM
        case 10
            DBPS = 3/4 * 10; % 1024-QAM
        case 11
            DBPS = 5/6 * 10; % 1024-QAM
        case 12
            DBPS = 3/4 * 12; % 4096-QAM
        case 13
            DBPS = 5/6 * 12; % 4096-QAM
        otherwise
            DBPS = 0;
    end
    switch MCSbasic
        case 0
            DBPSbasic = 1/2 * 1; % BPSK
        case 1
            DBPSbasic = 1/2 * 2; % QPSK
        case 2
            DBPSbasic = 3/4 * 2; % QPSK
        case 3
            DBPSbasic = 2/3 * 4; % 16-QAM
        case 4
            DBPSbasic = 3/4 * 4; % 16-QAM
        case 5
            DBPSbasic = 2/3 * 6; % 64-QAM
        case 6
            DBPSbasic = 3/4 * 6; % 64-QAM
        case 7
            DBPSbasic = 5/6 * 6; % 64-QAM
        case 8
            DBPSbasic = 3/4 * 8; % 256-QAM
        case 9
            DBPSbasic = 5/6 * 8; % 256-QAM
        case 10
            DBPSbasic = 3/4 * 10; % 1024-QAM
        case 11
            DBPSbasic = 5/6 * 10; % 1024-QAM
        case 12
            DBPSbasic = 3/4 * 12; % 4096-QAM
        case 13
            DBPSbasic = 5/6 * 12; % 4096-QAM
        otherwise
            DBPSbasic = 0;
    end
    DBPS = DBPS * Ns * NSS;
    DBPSbasic = DBPSbasic * Ns;
end

BOslots = 7.5; % BE AC
T_phy = 20E-6; % legacy preamble

% Frame lengths (bits)
L_sf = 16;      % service field     
L_tail = 6;     % tail bits    
L_header = 272; % mac header
Lrts = 160;     % request to send
Lcts = 112;     % clear to send
Lack = 112;     % acknowledgement
Ltrigger = 224 + 48 * nSTAs; % Basic trigger

SIFS = 10E-6; % Short Inter-Frame Space
DIFS = 31E-6; % Distributed Inter-Frame Space
B_slot = 9E-6;

T_ofdm = 16E-6; 

% duration of control frames
T_bo = BOslots * B_slot; % backoff slot 
T_rts = T_phy + ceil(Lrts / DBPSbasic) * T_ofdm; % request-to-send
T_cts = T_phy + ceil(Lcts / DBPSbasic) * T_ofdm; % clear-to-send
T_ack = T_phy + ceil(Lack / DBPSbasic) * T_ofdm; % acknowledgement
T_trigger = T_phy + ceil((L_sf + Ltrigger + L_tail) / DBPSbasic) * T_ofdm; 

% duration of the data frame
T_data_SU = T_phy + ceil((L_sf + L_header + L_data + L_tail) / DBPS) * T_ofdm; 

% Single User Downlink Transmission (SU DL)
SU_DL_Time = T_bo + T_rts + dprop + SIFS + T_cts + dprop + SIFS + ...
    T_data_SU + dprop + SIFS + T_ack + dprop + DIFS; % total time SU DL

% Single User Uplink Transmission (SU UL)   
SU_UL_Time = T_bo + T_rts + dprop + SIFS + T_cts + dprop + SIFS + T_trigger + ... 
    dprop + SIFS + T_data_SU + dprop + SIFS + T_ack + dprop + DIFS; % total time SU UL

end
