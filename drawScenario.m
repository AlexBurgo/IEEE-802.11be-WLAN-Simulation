% Draw the scenario simulation area and the received power graphic per distance

function drawScenario(draw_scenario, b, h, P_rx, distance)

    if draw_scenario == 1

        pgon = polyshape([0 0 b h], [h 0 0 b]); % creates the simulation area
        pg = plot(pgon);    % plots the simulation area
        pg.FaceAlpha = 0;   % transparency 'ON' of the area

        hold on;
        figure(1); plot(b / 2, h / 2, "*r", 'MarkerSize', 3); % plots the central AP
        title('Scenario'); xlabel('x metres'); ylabel('y metres');
        legend('STAs');

        figure(2); plot(distance, P_rx, '-rx');
        grid on;
        title('P_{RX} vs Distance'); xlabel('Distance (m)'); ylabel('Received power (dBm)');
        legend('P_{rx}');

    end
end
