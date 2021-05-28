


function throughput(nSTAs, SuccTx, length, DL_time, UL_time, Ts, draw)

DL_throughput = zeros(1, nSTAs);
UL_throughput = zeros(1, nSTAs);
Ts_throughput = zeros(1, nSTAs);

%fprintf("-------- DOWNLINK TRANSMISSION ------ \n");
for i = 1:nSTAs
    DL_throughput(i) = SuccTx(i) * length / (DL_time);
    DL_throughput(i) = DL_throughput(i) / 1E6; % scale bps to Mbps
    %fprintf("S%d = %.6f Mbps \n", i, DL_throughput(i));
end

%fprintf("\n-------- UPLINK TRANSMISSION -------- \n");
for i = 1:nSTAs
    UL_throughput(i) = SuccTx(i) * length / (UL_time);
    UL_throughput(i) = UL_throughput(i) / 1E6; % scale bps to Mbps
    %fprintf("S%d = %.6f Mbps \n", i, UL_throughput(i));
end

fprintf("--------- TOTAL TRANSMISSION -------- \n");
for i = 1:nSTAs
    Ts_throughput(i) = SuccTx(i) * 2*length / (Ts);
    Ts_throughput(i) = Ts_throughput(i) / 1E6; % scale bps to Mbps
    fprintf("S%d = %.6f Mbps \n", i, Ts_throughput(i));
end

if draw == 1
    figure(3);clf
    c = categorical({'Downlink', 'Uplink'});
    S = [DL_throughput; UL_throughput];
    bar(c, S);
    ylabel('Throughput [Mbps]');
    legend('STA 1','STA 2','STA 3','STA 4','Location','NorthEastOutside');
    
    figure(4);clf
    S = Ts_throughput;
    bar(S);
    xlabel('STA'); ylabel('Throughput [Mbps]');
end

end
