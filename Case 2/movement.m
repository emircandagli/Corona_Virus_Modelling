%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function movement_array = movement(people, movement_array, grid_size)
directions = ["left", "right", "up", "down", "down-left", "down-right", "up-left", "up-right"];
for i = 1:200
    point(1) = people(i,1); %assign the points for each individual
    point(2) = people(i,2);
    walk = directions(randi(length(directions))); %select positions randomly
    step = randi([0,3]); %select step size randomly
    
    if step == 0
        continue %if step 0 is selected, the person does not move
    end

    move_x = 0;
    move_y = 0;
    %with step size, the distance of the person to the border is controlled, whichever is smaller, the person moves at that distance.
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
    %update the movement array for each individual
    movement_array(i,1) = move_x;
    movement_array(i,2) = move_y;
end
end