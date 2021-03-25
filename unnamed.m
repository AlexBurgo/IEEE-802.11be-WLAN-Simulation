% El proper pas seria modelar el DCF com un TDMA - Round Robin.
% Jo consideraria només tràfic Downlink, i que l'AP transmet
% sequencialment a l'STA 1, després a l'STA 2, etc. fins l'STA N.

% Per donar-li una mica d'emoció, ja que si no es determinista, fes que
% cada transmissió tingui èxit o falli amb una certa probabilitat 'pe'.
% La simulació pot tenir el següent aspecte:

nSTAs = 10;
MaxCycles = 10;
time = 0;
prob_err = 0.1;
SuccTx = zeros(1, nSTAs);
Throughput = zeros(1, nSTAs);

for i = 1:MaxCycles

    for j = 1:nSTAs
        Ts = TxToSTA(j); % transmition time of each station

        if (rand() < prob_err)
            SuccTx(j) = SuccTx(j) + 1;
        end

        time = time + Ts; % time addition
    end

end

for s = 1:NSTas
    Throughput(s) = L * TxToSTA(s) / time;
end
