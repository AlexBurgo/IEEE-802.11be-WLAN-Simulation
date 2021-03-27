% function to calculate the euclidian-distance between the AP and STA

% AP: coordinates of the Acces Point
% xSTA: coordinates of axis xSTA
% ySTA: coordinates of axis ySTA

function distanceToAP = distanceToAP(AP, xSTA, ySTA)

% euclidean-distance
distanceToAP = sqrt((xSTA - AP(1))^2 + (ySTA - AP(2))^2);

end
