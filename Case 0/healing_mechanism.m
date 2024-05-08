%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function [people, healing_num_iteration,dead_num_iteration] = healing_mechanism(people,healing_num_iteration,dead_num_iteration,n)  
for p = 1:size(people,1)
    if people(p,3) == 1 %check person is infected or not
        people(p,4) = people(p,4) + 1 ; %if the person is infected, increase the number of iterations by one
        if people(p,4) == 25 %after the M iteration
            if rand() < 0.95 %percentage of the healing
                people(p, 3) = 0 ;
                people(p, 4) = 0 ;
                healing_num_iteration(n) = healing_num_iteration(n) + 1;
            else
                people(p, :) = NaN ; %if the person does not recover, death is recorded as NaN
                dead_num_iteration(n) = dead_num_iteration(n) + 1;
            end                 
        end   
    end  
end
end



    