function movement_array = movement(people, movement_array, grid_size,isolation)
directions = ["left", "right", "up", "down", "down-left", "down-right", "up-left", "up-right"];
for i = 1:200
    point = people(i, 1:2);
    walk = directions(randi(length(directions))); %choose random movement position
    move_x = 0;
    move_y = 0;
    
    if people(i, 5) == 1
        step = randi([0,1]);
        bounds = [isolation(i, 1) - 1, isolation(i, 1) + 1, isolation(i, 2) - 1, isolation(i, 2) + 1];
        bounds = [max(bounds(1), -grid_size), min(bounds(2), grid_size), max(bounds(3), -grid_size), min(bounds(4), grid_size)];
        if step == 0
            continue
        end
        if walk == "left"
            move_x = -min(step, point(1) - bounds(1));
        elseif walk == "right"
            move_x = min(step, bounds(2) - point(1));
        elseif walk == "up"
            move_y = min(step, bounds(4) - point(2));
        elseif walk == "down"
            move_y = -min(step, point(2) - bounds(3));
        elseif walk == "down-left"
            move_x = -min(step, point(1) - bounds(1));
            move_y = -min(step, point(2) - bounds(3));
        elseif walk == "down-right"
            move_x = min(step, bounds(2) - point(1));
            move_y = -min(step, point(2) - bounds(3));
        elseif walk == "up-left"
            move_x = -min(step, point(1) - bounds(1));
            move_y = min(step, bounds(4) - point(2));
        elseif walk == "up-right"
            move_x = min(step, bounds(2) - point(1));
            move_y = min(step, bounds(4) - point(2));
        end

        % Hareket sonuçlarını bir diziye kaydetme
        movement_array(i, 1) = move_x;
        movement_array(i, 2) = move_y;

    elseif people(i,5) == 0
        step = randi([0,3]);
        
        if step == 0
            continue
        end
    
        move_x = 0;
        move_y = 0;
    
        if walk == "left"
            move_x = -min(step, point(1) + grid_size);
        elseif walk == "right"
            move_x = min(step, grid_size - point(1));
        elseif walk == "up"
            move_y = min(step, grid_size - point(2));
        elseif walk == "down"
            move_y = -min(step, point(2) + grid_size);
        elseif walk == "down-left"
            move_x = -min(step, point(1) + grid_size);
            move_y = -min(step, point(2) + grid_size);
        elseif walk == "down-right"
            move_x = min(step, grid_size - point(1));
            move_y = -min(step, point(2) + grid_size);
        elseif walk == "up-left"
            move_x = -min(step, point(1) + grid_size);
            move_y = min(step, grid_size - point(2));
        elseif walk == "up-right"
            move_x = min(step, grid_size - point(1));
            move_y = min(step, grid_size - point(2));
        end
        
        movement_array(i,1) = move_x;
        movement_array(i,2) = move_y;
    end
end
end