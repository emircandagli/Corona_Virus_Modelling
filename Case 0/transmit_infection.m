%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function [people, infected_num_iteration] = transmit_infection(people, P, infected_num_iteration, n)
% people: matrix that represents position and health condition for each
% individual
% P: percentage of infection
counter = 0; 
num_people = size(people, 1);
for p = 1:num_people 
    for j = (p + 1):num_people %check other people after the previous selected individual
        if (people(p,1) == people(j,1)) && (people(p,2) == people(j,2)) %check both of them are same position
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1) %check one of them is infected and both of them are not infected
                if people(p, 3) == 1 && rand() < P
                    people(j, 3) = 1; %second selected person got infected
                    counter = counter + 1;
                elseif people(j, 3) == 1 && rand() < P
                    people(p, 3) = 1; %first selected person got infected
                    counter = counter + 1;
                end
            end
        end
    end
end
infected_num_iteration(n) = counter; %count the infected person
end