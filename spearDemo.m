function [] = spearDemo(spears, smiles, perceived)

    % Setup the timesteps / canvas / initial plot
    timesteps = min(length(spears), ...
        min(length(smiles), length(perceived)));

    figure('Renderer', 'zbuffer');
    hold on;
    
    height = 2;
    width = 5;
    axis([0 width 0 height]);
    
    % Set the x and y axis tick marks.
    set(gca, 'XTick', [0:width]);
    set(gca, 'YTick', [0:height]);
    
    % Load the smiley images.
    smileyFace = imread('smiley-face.jpg');
    deadFace = imread('dead-smiley.jpg');
    
    % Set the smiley's initial position / condition (alive)
    dead = false;
    smileyRight = 0.9; smileyLeft = 0.1; 
    smileyTop = 0.75; smileyBottom = 0.25;
    
    % Assign the possible spear heights
    spearLow = [0.5, 0.5];
    spearHigh = [1.5, 1.5];
    
    % Draw initial spears
    for x=(1:width)
        % Real positions of incoming spears in red.
        hh1(x) = line([x-1, x], spearLow, 'Color', 'r', 'LineWidth', 2, ...
            'Marker', '<', 'MarkerFaceColor', 'r');
        
        % Perceived positions of the incoming spears in green.
        hh1(width + x) = line([x-1, x], [0 0], 'LineStyle', ':', 'Color', 'g', ...
            'LineWidth', 2, 'Marker', '<', 'MarkerFaceColor', 'g', ...
            'MarkerEdgeColor', 'g');
    end
    
    % Only draw on the figure from this function!
    function [] = redrawAll(time)
        drawSmiley();
        drawSpears();
        
        % Get frame as an image
        F(time) = getframe(gcf);
    end

    % Draw the smiley (or dead smiley) face
    function [] = drawSmiley() 
        if (~dead) 
            hh1(2*width+1) = image([smileyRight, smileyLeft], ...
                [smileyTop, smileyBottom], smileyFace);
        else
            deadOffset = 0.05;
            hh1(2*width+1) = image([smileyRight+deadOffset, ...
                smileyLeft-deadOffset], ...
                [smileyTop+deadOffset, smileyBottom-deadOffset], ...
                deadFace);
        end
    end

    % Draw the incoming spears.
    function [] = drawSpears()
        for i=(1:width)
            curSpear = spears(time);
            seenHeight = perceived(time);
            
            if (i < width) % Move old platforms left
            
                % Actual spear positions.
                set(hh1(i), 'YData', get(hh1(i+1), 'YData'));
                
                % Perceived spear positions.
                set(hh1(width+i), 'YData', get(hh1(width+i+1), 'YData'));
            
            else % New platform for this timestep
                
                % Actual spear position
                if (curSpear == 1)
                    set(hh1(i), 'YData', spearHigh);
                elseif (curSpear == 0)
                    set(hh1(i), 'YData', spearLow);
                else
                    disp('Invalid spear value.  Must be 0 or 1.  Oops!');
                end
                
                % Perceived spear position.
                set(hh1(width+i), 'YData', [seenHeight seenHeight]);                
            end
        end
    end

    % Set dead to true iff the smiley died on this time step. -- OUCH!!!
    function [] = checkDead(time)
        if (spears(time) == smiles(time))
            dead = true;
        end
    end

    % Timing loop (Every iteration is one time step.)
    for time=(1:timesteps)
        checkDead(time);
        redrawAll(time);
        if (dead)
            break;
        end
    end

    figure();
    movie(gcf,F, 1, 1); 
end