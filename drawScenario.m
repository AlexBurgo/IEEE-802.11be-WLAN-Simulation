% Draw the scenario simulation area

function drawScenario(draw_scenario, b, h)

pgon = polyshape([0 0 b h],[h 0 0 b]); % creates the simulation area
pg = plot(pgon); % plots the simulation area
pg.FaceAlpha = 0; % transparency ON of the area
hold on;
plot(b/2, h/2, "*r", 'MarkerSize', 3); % plots the central AP
%title('Scenario'); xlabel('x metres'); ylabel('y metres');

end