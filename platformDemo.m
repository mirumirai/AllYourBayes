function [] = platformDemo(platforms)

    timesteps = length(platforms);

    figure('Renderer', 'zbuffer');

    height = 5;
    width = 5;
    axis([0 width 0 height]);
    
    set(gca, 'XTick', [0:width]);
    set(gca, 'YTick', [0:height]);
    
    for x=(1:width)
        hh1(x) = line([x-1, x], [0, 0]);
    end
    
    % Preallocate data (for storing frame data)
    pos = get(gcf, 'Position');
    fWidth = pos(3); fHeight = pos(4);
    %mov = zeros(fHeight, fWidth, 1, timesteps, 'uint8');
    
    for time=(1:timesteps)
        for x=(1:width)
            curPlat = platforms(time);
            if (x < width) % Move old platforms left
                set(hh1(x), 'YData', get(hh1(x+1), 'YData'));
            else % New platform for this timestep
                set(hh1(x), 'YData', (get(hh1(x),'YData') + curPlat));
            end
        end
        
        % Get frame as an image
        F(time) = getframe(gcf);
    end

    figure();
    movie(gcf,F, 1, 1); 
end