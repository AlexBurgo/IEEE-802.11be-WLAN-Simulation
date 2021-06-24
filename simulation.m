


clear; clc;

b = 35; h = 35;   % base & height dimensions in 'meters'
AP = [b/2 h/2];   % central access point
nSTAs = 1;        % number of stations
MaxCycles = 1e6;  % # round robin cycles
SS = 16;          % Spatial streams
%SS = [2, 4, 8, 16]; % Spatial Streams
%BW = [20, 40, 80, 160, 320]; % Channel width
BW = [160, 320]; % Channel width
%BW = 160;         % Channel width
length = 12e3;    % data packet size (bits)
% SuccTx = zeros(1, nSTAs);
%fixedposY = 0.5:0.0025:0.89; % for 2 SS
% fixedposY = 0.5:0.0025:0.9525; % for 4 SS
fixedposY = 0.5:0.0025:0.78; % for 8 SS
%fixedposY = 0.5:0.0025:0.73; % for 16 SS
Ts_throughput = zeros(1, size(fixedposY, 2));
%Ts_throughput = zeros(1, nSTAs);
distance = zeros(1, size(fixedposY, 2));

for i = 1:size(BW, 2)
for j = 1:size(fixedposY, 2)

    opti = 0;  % 1 - to activate MCS & BW optimization algorithm 0 - otherwise
    draw = 0;  % 1 - to plot figures 0 - otherwise.
    
    [distance(j), P_rx, coordinates] = room(nSTAs, b, h, AP, fixedposY(j));
    P_rx = sort(P_rx, 'descend');
    %distance = sort(distance, 'ascend');
    %drawScenario(draw, b, h, P_rx, distance(i), coordinates);
    
    %for i = 1:size(BW, 2)
    SuccTx = zeros(1, nSTAs);
    % round-robin
    [SuccTx, DL_time, UL_time, frames, Ts] = roundRobin(MaxCycles, nSTAs, ...
        SS, P_rx, length, distance(j), SuccTx, opti, BW(i));
    
    % throughput calculus
    [Ts_throughput(j)] = throughput(nSTAs, SuccTx, length, DL_time, UL_time, frames, Ts, draw);

end
    S = Ts_throughput;
    % plot(distance, S, '-b');
    plot(distance, S);
    set(gca,'XTick',0:0.5:size(fixedposY, 2));
    set(gca,'XTickLabel',0:0.5:size(fixedposY, 2));
    grid on;
    xlabel('Distance [m]'); ylabel('Throughput [Mbps]');
    hold on;
    % str = {'320 MHz','16 Spatial Streams'};
    % text(7, 5800, str);
    if i ~= 2
        fixedposY = 0.5:0.0025:0.73; % for 16 SS
        Ts_throughput = zeros(1, size(fixedposY, 2));
        distance = zeros(1, size(fixedposY, 2));
    end
end

legend('160 MHz','320 MHz');
legend('boxoff');

% Ts_throughput = floor(Ts_throughput); 
% figure(5);clf
% X = distance;
% S = Ts_throughput;
% bar(X, S);
% text(X, S, num2str(S','%0.2f'),'vert','bottom','horiz','center');
% xlabel('Distance [m]'); ylabel('Throughput [Mbps]');
% box off

% plot(distance, S, '-b');
% set(gca,'XTick',0:0.5:size(fixedposY, 2));
% set(gca,'XTickLabel',0:0.5:size(fixedposY, 2));
% grid on;
% xlabel('Distance [m]'); ylabel('Throughput [Mbps]');
% str = {'320 MHz','16 Spatial Streams'};
% text(7, 5800, str);

% if size(BW, 2) > 1
%     figure(5);clf
%     c = categorical({'20','40','80','160','320'});
%     c = reordercats(c, string(c)); 
%     S = (Ts_throughput);
%     bar(c, S);
%     text(c, S, num2str(S','%0.f'),'vert','bottom','horiz','center'); 
%     xlabel('Channel Banwidth [MHz]'); ylabel('Throughput [Mbps]');
%     box off
% else
%     figure(5);clf
%     c = categorical({'2','4','8','16'});
%     c = reordercats(c, string(c)); 
%     S = (Ts_throughput);
%     bar(c, S);
%     text(c, S, num2str(S','%0.f'),'vert','bottom','horiz','center'); 
%     xlabel('Spatial Streams'); ylabel('Throughput [Mbps]');
%     box off
% end
