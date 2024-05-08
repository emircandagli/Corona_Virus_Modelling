%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function [people, infected_num_iteration] = transmit_infection(people, P, infected_num_iteration, n)

counter = 0;
num_people = size(people, 1);
r_s = 0.1;
for p = 1:num_people
    for j = (p + 1):num_people
        if (people(p,1) == people(j,1)) && (people(p,2) == people(j,2))
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1)
                if people(p,8) == 2 || people(j,8) == 2 %if one in two people receives a second dose of vaccine, the possibility of the disease spreading is eliminated.
                    continue
                else
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
end
infected_num_iteration(n) = counter;
end