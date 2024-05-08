%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function [people, infected_num_iteration,isolation] = transmit_infection(people,P, infected_num_iteration, n, isolation)
% people: matrix that represents position and health condition for each
% individual
% P: percentage of infection
counter = 0;
num_people = size(people, 1);
q_s = 0.7; %isolation probability
for p = 1:num_people
    for j = (p + 1):num_people %check other people after the previous selected individual
        if (people(p,1) == people(j,1)) && (people(p,2) == people(j,2)) %check both of them are same position
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1) %check one of them is infected and both of them are not infected
                if people(p, 3) == 1 && rand() < P
                    people(j, 3) = 1; %second selected person got infected
                    if rand() < q_s
                        people(j,5) = 1; %there is a certain probability that the person will comply with the isolation rules at the beginning of the disease.
                        isolation(j,1) = people(j,1); %control of the infected position
                        isolation(j,2) = people(j,2);
                    end
                    counter = counter + 1;
                elseif people(j, 3) == 1 && rand() < P
                    people(p, 3) = 1; %first selected person got infected
                    if rand() < q_s
                        people(p,5) = 1;
                        isolation(p,1) = people(p,1); %control of the infected position
                        isolation(p,2) = people(p,2);
                    end
                    counter = counter + 1;
                end
            end
        end
    end
end
infected_num_iteration(n) = counter;
end