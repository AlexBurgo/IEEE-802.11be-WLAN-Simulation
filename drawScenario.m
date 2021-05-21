
% Draw the scenario simulation area and the received power graphic per distance (RSSI)

function drawScenario(draw_scenario, b, h, P_rx, distance, coordinates)

if draw_scenario == 1
    
    pgon = polyshape([0 0 b h], [h 0 0 b]); % creates the simulation area
    pg = plot(pgon);    % plots the simulation area
    pg.FaceAlpha = 0;   % transparency 'ON' of the area
    
    hold on;
    figure(1);
    sz = 15;
    p1 = scatter(b / 2, h / 2, sz, 'red', 'Filled'); % plots the AP
    p2 = scatter(coordinates(:,1), coordinates(:,2), sz, 'blue','Filled'); % plots the STA
    title('Scenario'); xlabel('x metres'); ylabel('y metres');
    hold off;
    legend([p1 p2],{'AP', 'STAs'},'Orientation','horizontal');
    legend('boxoff')
    
    figure(2); 
    plot(distance, P_rx, '-ro');
    grid on;
    title('P_{rx} vs Distance'); xlabel('Distance (m)'); ylabel('Received Power (dBm)');   
    legend('P_{rx}'); 
end
end
