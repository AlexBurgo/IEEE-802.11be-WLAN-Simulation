


function [best_BW, MCS, MCSbasic] = optimization(BW, P_rx)

    % BW = [20, 40, 80, 160, 320];
    nBW = size(BW, 2);
    possible_MCS = zeros(1, nBW); % initialize possible_MCS array

    % get all possible MCS
    for i = 1:nBW
        possible_MCS(i) = modulationSelection(BW(i), P_rx);
    end

    indx = find(max(possible_MCS)); % get the maximum MCS position in the array

    while possible_MCS(indx) == possible_MCS(indx + 1)

        indx = indx + 1;
        if indx == nBW
            break;
        end

    end

    MCS = possible_MCS(indx);
    MCSbasic = MCS;
    best_BW = BW(indx);

end
