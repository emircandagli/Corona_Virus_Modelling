
function [people,vaccination_iteration] = vaccination_mechanism(people, n,vaccination_iteration)
t_s = 10;
k = 2;
w = 0.6;
t_sec = 10;
if n >= t_s 
    %vaccination starts
    t_v = n ;
    delta3 = 1/(k*(t_v-9)) ; 
    % we need %delta3 percent of healthy unvaccinated individuals
    number_of_vaccination = sum(people(:, 3) == 0 & people(:, 6) == 0 & people(:, 8) == 0) * delta3;
 
    vaccinated_count = 0;
    while vaccinated_count < number_of_vaccination 
        selecter = randi([1 200]);
        if people(selecter, 3) == 0 && people(selecter, 6) == 0 && people(selecter,8) == 0
            people(selecter, 6) = 1;
            people(selecter, 8) = 1;
            vaccinated_count = vaccinated_count + 1;
        end
    end
    vaccination_iteration(n) = vaccinated_count;
end

for i = 1:size(people, 1) 
    if people(i, 6) == 1
        people(i, 7) = people(i , 7) + 1 ;
        
        if people(i, 7) == t_sec && people(i,3) == 0 && rand() < w
             %people who gets the second dose
             people(i , 6) = 0 ;
             people(i , 7) = 0 ;
             people(i, 8) = 2 ;
        end
        if people(i, 7) == 20
            people(i, 6) = 0 ;
            people(i, 7) = 0 ;
        end
        
    end
end
end

