
% Function to calculate the transmisison time in 11ax SU

% L: packet size (bits)
% BS: channel width
% MCS: data rate
% MCSbasic: basic data rate (set to the minimum rate of the BSS)
% NSS: SU spatial streams.
% NS: Data Subcarriers

function [SU_DL_Time, SU_UL_Time, Nframes, prob_err] = wifiTransmissionTimeBasic(nSTAs, SS, P_rx, L_data, distance, opti)

dprop = distance/3E8; % Propagation delay
Nframes = 64; % number of aggregated frames in A-MPDU

if opti == 1
    [DBPS, DBPSbasic, prob_err] = optimization(P_rx);
else
    BW = 320; % bandwidth: change to obtain different results
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
    [MCS, prob_err] = modulationSelection(BW, P_rx, SS);
    MCSbasic = MCS;
    switch MCS
        case 0
            DBPS = 1/2 * 1; % BPSK
        case 1
            DBPS = 1/2 * 2; % QPSK
        case 2
            DBPS = 3/4 * 2; % QPSK
        case 3
            DBPS = 1/2 * 4; % 16-QAM
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
            DBPSbasic = 1/2 * 4; % 16-QAM
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
    DBPS = DBPS * Ns * SS;
    DBPSbasic = DBPSbasic * Ns;
end

BOslots = 7.5; % BE AC
T_phy = 20E-6; % legacy preamble
T_ofdm = 16E-6; % OFDM symbol duration

% Frame lengths (bits)
L_sf = 16;      % service field     
L_tail = 6;     % tail bits    
L_header = 272; % mac header
L_rts = 160;     % request to send
L_cts = 112;     % clear to send
L_Back = 256;   % block acknowledgement
L_trigger = 224 + 48 * nSTAs; % Basic trigger
%L_MSBack = 176 + 288 * nSTAs; % Multi-station BACK (MS-BACK)
%L_MU_trigger = 224 + 40 * nSTAs; % % MU-RTS trigger

% Frame lengths for A-MPDU (bits)
L_delimiter = 32;

SIFS = 10E-6; % Short Inter-Frame Space
DIFS = 31E-6; % Distributed Inter-Frame Space
B_slot = 9E-6; % backoff slot duaration

% duration of control frames
T_bo = BOslots * B_slot; % backoff time
T_rts = T_phy + ceil(L_rts / DBPSbasic) * T_ofdm; % request-to-send
%T_MUrts = T_phy + ceil(L_sf + L_MU_trigger + L_tail / DBPSbasic) * T_ofdm; % request-to-send
T_cts = T_phy + ceil(L_cts / DBPSbasic) * T_ofdm; % clear-to-send
T_Back = T_phy + ceil((L_sf + L_Back + L_tail) / DBPSbasic) * T_ofdm;
%T_MSBack = T_phy + ceil((L_sf + L_MSBack + L_tail) / DBPSbasic) * T_ofdm; 
T_trigger = T_phy + ceil((L_sf + L_trigger + L_tail) / DBPSbasic) * T_ofdm; 

% duration of the data frame
T_data_aMPDU = T_phy + ceil((L_sf + Nframes * (L_delimiter + L_header + L_data) + L_tail) / DBPS) * T_ofdm;

% while T_data_aMPDU >= 5e-3 % PPDU < 5 ms
%     Nframes = Nframes - 1;
%     T_data_aMPDU = T_phy + ceil((L_sf + ...
%         Nframes * (L_delimiter + L_header + L_data) + L_tail) / DBPS) * T_ofdm;
% end

%T_data_MU_UL = T_phy + ceil((L_sf + L_header + L_data + L_tail) / DBPS) * T_ofdm;
%T_data_MU_DL = T_phy + ceil((L_sf + L_header + L_data + L_tail) / DBPS) * T_ofdm;

% WITH A-MPDU
% Single User Downlink Transmission (SU DL)
SU_DL_Time = T_bo + T_rts + dprop + SIFS + T_cts + dprop + SIFS + ...
    T_data_aMPDU + dprop + SIFS + T_Back + dprop + DIFS; 

% Single User Uplink Transmission (SU UL)   
SU_UL_Time = T_bo + T_rts + dprop + SIFS + T_cts + dprop + SIFS + T_trigger + ... 
    dprop + SIFS + T_data_aMPDU + dprop + SIFS + T_Back + dprop + DIFS; 

% Multi User Downlink Transmission (MU DL)
%MU_DL_Time = T_MUrts + dprop + SIFS + T_cts + dprop + SIFS + T_data_MU_DL + ...
%    dprop + SIFS + T_Back + dprop + DIFS; 

% Multi User Uplink Transmission (MU UL)
%MU_UL_Time = T_MUrts + dprop + SIFS + T_cts + dprop + SIFS + T_trigger + ...
%    dprop + SIFS + T_data_MU_UL + dprop + SIFS + T_MSBack + dprop + DIFS; 

end
