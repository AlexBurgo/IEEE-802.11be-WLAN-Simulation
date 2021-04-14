


function throughput(nSTAs, SuccTx, length, MaxCycles, DL_time, UL_time)

    throughput = zeros(1, nSTAs);
    
    fprintf("-------- DOWNLINK TRANSMISSION ------ \n");
    for i = 1:nSTAs
        throughput(i) = SuccTx(i) * length / (MaxCycles * (DL_time / MaxCycles));
        throughput(i) = throughput(i) / 1E6; % scale bps to Mbps
        fprintf("S%d = %.6f Mbps \n", i, throughput(i));
    end

    fprintf("\n-------- UPLINK TRANSMISSION -------- \n");
    for i = 1:nSTAs
        throughput(i) = SuccTx(i) * length / (MaxCycles * (UL_time / MaxCycles));
        throughput(i) = throughput(i) / 1E6; % scale bps to Mbps
        fprintf("S%d = %.6f Mbps \n", i, throughput(i));
    end

end
