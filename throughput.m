


function [Ts_throughput] = throughput(nSTAs, SuccTx, length, DL_time, UL_time, frames, Ts, draw)

DL_throughput = zeros(1, nSTAs); % initialize dowlink throughput array
UL_throughput = zeros(1, nSTAs); % initialize uplink throughput array
Ts_throughput = zeros(1, nSTAs); % initialize total throughput array

%-------- DOWNLINK TRANSMISSION ------ 
for i = 1:nSTAs
    DL_throughput(i) = SuccTx(i) * frames(i) * length / (DL_time);
    DL_throughput(i) = DL_throughput(i) / 1E6; % scale bps to Mbps
end
%-------- UPLINK TRANSMISSION -------- 
for i = 1:nSTAs
    UL_throughput(i) = SuccTx(i) * frames(i) * length / (UL_time);
    UL_throughput(i) = UL_throughput(i) / 1E6; % scale bps to Mbps
end
%--------- TOTAL TRANSMISSION -------- 
for i = 1:nSTAs
    Ts_throughput(i) = SuccTx(i) * 2*frames(i) * length / (Ts);
    Ts_throughput(i) = Ts_throughput(i) / 1E6; % scale bps to Mbps
end

Ts_throughput = floor(Ts_throughput); 
% DL_throughput = floor(DL_throughput);
% UL_throughput = floor(UL_throughput);

if draw == 1
    %figure(3);clf
    %c = categorical({'Downlink', 'Uplink'});
    %S = [DL_throughput; UL_throughput];
    %bar(c, S);
    %ylabel('Throughput [Mbps]');
    %legend('STA 1','STA 2','STA 3','STA 4','Location','NorthEastOutside');
    
    figure(4);clf
    c = categorical({'1','2','3','4','5','6','7','8','9','10','11','12','13','14' ... 
                    ,'15','16','17','18','19','20'});
    c = reordercats(c, string(c)); 
    S = Ts_throughput;
    bar(c, S);
    text(c, S, num2str(S','%0.f'),'vert','bottom','horiz','center'); 
    xlabel('STA'); ylabel('Throughput [Mbps]');
    box off
end

% Ts_throughput = mean(Ts_throughput); % mean of all station throughputs

end
