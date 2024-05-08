%Emir Can Dağlı 2517704 Ekin Akçay 2577419
function [people,vaccination_iteration] = vaccination_mechanism(people, n,vaccination_iteration)
t_s = 20;
k = 1.5;
if n >= t_s 
    %vaccination starts
    t_v = t_s + (n-20);
    delta3 = 1/(k*(t_v-19)) ; 
    % we need %delta3 percent of healthy unvaccinated individuals
    number_of_vaccination = sum(people(:, 3) == 0 & people(:, 6) == 0 & people(:, 8) == 0) * delta3;
    %the sum of uninfected, currently unvaccinated, and previously unvaccinated people multiplied by the given formula
    vaccinated_count = 0;
    while vaccinated_count < number_of_vaccination %continues until the vaccinated number of people is reached.
        selecter = randi([1 200]);
        if people(selecter, 3) == 0 && people(selecter, 6) == 0 && people(selecter,8) == 0
            people(selecter, 6) = 1;
            people(selecter, 8) = 1;  %marked as previously vaccinated
            vaccinated_count = vaccinated_count + 1;
        end

    end
    vaccination_iteration(n) = vaccinated_count;
end

for i = 1:size(people, 1) 
    if people(i, 6) == 1
        people(i, 7) = people(i , 7) + 1 ;%the number of iterations vaccinated is checked
        w = 0.8; %second vaccination probability
        if people(i, 7) == 10 && people(i,3) == 0 && rand() < w
             %people who gets the second dose
             people(i , 6) = 0 ;
             people(i , 7) = 0 ;
             people(i, 8) = 2 ; %second dose control
        end
        if people(i, 7) == 20 %after a certain number of rounds (20) the effects of the vaccine disappear
            people(i, 6) = 0 ;
            people(i, 7) = 0 ;
        end
        
    end
end
end

