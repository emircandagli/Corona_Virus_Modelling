function [people, infected_num_iteration,isolation] = transmit_infection(people,P, infected_num_iteration, n, isolation)
counter = 0;
num_people = size(people, 1);
r_s = 0.1;
q_s = 1;
for p = 1:num_people
    for j = (p + 1):num_people
        if (people(p,1) == people(j,1)) && (people(p,2) == people(j,2))
            if (people(p, 3) == 1 || people(j, 3) == 1) && ~(people(p, 3) == 1 && people(j, 3) == 1)
                if people(p,8) == 2 || people(j,8) == 2
                    continue
                else
                    infect_probability = P;
                    if people(p, 6) == 1 || people(j, 6) == 1
                        infect_probability = r_s; % Reduced probability if vaccinated
                    end
                % Apply infection based on the probability
                    if rand() < infect_probability
                        if people(p, 3) == 1
                            people(j, 3) = 1;
                            if rand() < q_s
                                people(j,5) = 1;
                                isolation(j,1) = people(j,1);
                                isolation(j,2) = people(j,2);
                            end
                        elseif  people(j, 3) == 1
                            people(p, 3) = 1;
                            if rand() < q_s
                                people(p,5) = 1;
                                isolation(p,1) = people(p,1);
                                isolation(p,2) = people(p,2);
                            end
                        end
                        counter = counter + 1;
                    end
                % p gets j sick when j is vaccinated
                end
            end
        end
    end
end
infected_num_iteration(n) = counter;
end