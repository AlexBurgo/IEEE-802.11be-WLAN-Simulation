


function [distance, P_rx] = room(nSTAs, b, h, AP, draw)

    i = 1;  % iterator
    P_rx = zeros(nSTAs,1);         % initialize array received power
    distance = zeros(nSTAs,1);     % initialize array distance
    coordinates = zeros(nSTAs,2);  % initialize matrix coordinates
    fixedpos = [0.125 0.32 0.51 1];

    P_tx = 21;      % transmitted power by AP in dBm
    k = 5.25;       % attenuation of each wall
    W = 0.1467;     % average number of traversed walls per meter
    lambda = 2.06;  % attenuation factor
    L_o = 54.1200;  % path loss intercept

    while i <= nSTAs

        % random position generation of STAs
        j = 1;
        %xSTA = rand * b; % x random position
        xSTA = fixedpos(i) .* b; % x random position
        coordinates(i, j) = xSTA;
        j = 2;

        while j == 2
            %ySTA = rand * h; % y random position
            ySTA = fixedpos(i) .* h; % y random position
            coordinates(i, j) = ySTA;
            break;
        end

        if (draw == 1); plot(xSTA, ySTA, "*b", 'MarkerSize', 3); end % plots the STA

        distance(i) = distanceToAP(AP, coordinates(i, 1), coordinates(i, 2));
        P_rx(i) = STAPowerReceived(P_tx, distance(i), lambda, L_o, k, W); % received power

        i = i + 1;
    end

end
