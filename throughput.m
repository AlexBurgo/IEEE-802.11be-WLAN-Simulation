


function throughput(nSTAs, SuccTx, length, MaxCycles, DL_time, UL_time)

DL_throughput = zeros(1, nSTAs);
UL_throughput = zeros(1, nSTAs);

fprintf("-------- DOWNLINK TRANSMISSION ------ \n");
for i = 1:nSTAs
    DL_throughput(i) = SuccTx(i) * length / (MaxCycles * (DL_time / MaxCycles));
    DL_throughput(i) = DL_throughput(i) / 1E6; % scale bps to Mbps
    fprintf("S%d = %.6f Mbps \n", i, DL_throughput(i));
end

fprintf("\n-------- UPLINK TRANSMISSION -------- \n");
for i = 1:nSTAs
    UL_throughput(i) = SuccTx(i) * length / (MaxCycles * (UL_time / MaxCycles));
    UL_throughput(i) = UL_throughput(i) / 1E6; % scale bps to Mbps
    fprintf("S%d = %.6f Mbps \n", i, UL_throughput(i));
end

c = categorical({'Downlink', 'Uplink'});
S = [DL_throughput; UL_throughput];
bar(c, S);
ylabel('Throughput [Mbps]');
legend('STA 1','STA 2','STA 3','STA 4');

end
