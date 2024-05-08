%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function [people, infected_num_iteration] = transmit_infection(people, P, infected_num_iteration, n)
% people: matrix that represents position and health condition for each
% individual
% P: percentage of infection
counter = 0;
num_people = size(people, 1);
r_s = 0.1 ; %infection probability for vaccinated individuals
for p = 1:num_people
    for j = (p + 1):num_people
        if isequal(people(p, 1:2), people(j, 1:2)) %check other people after the previous selected individual
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1) %check one of them is infected and both of them are not infected
                infect_probability = P;
                if people(p, 6) == 1 || people(j, 6) == 1
                    infect_probability = r_s; %reduced probability if vaccinated
                end
                %apply infection based on the probability
                if rand() < infect_probability
                    if people(p, 3) == 1
                        people(j, 3) = 1;
                    else
                        people(p, 3) = 1;
                    end
                    counter = counter + 1;
                end
            end
        end
    end
end
infected_num_iteration(n) = counter;
end