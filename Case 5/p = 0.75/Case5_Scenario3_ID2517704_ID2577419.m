%Emir Can Dağlı 2517704 Ekin Akçay 2577419
%arrays that are not required in this case are due to problems that may occur in the algorithm
%similar to the entire algorithm is available in case 4
clear
clc
grid_size = 12;
P = 0.75;
r_s = 0.1; 
people = zeros(200,8);
isolation = zeros(200,2);

infected_num_iteration = zeros(1,250);
infected_total = zeros(1,250);
healing_num_iteration = zeros(1,250);
healing_total = zeros(1,250);
dead_num_iteration = zeros(1,250);
dead_num_total = zeros(1,250) ;
vaccination_iteration = zeros(1,250);
infected_and_vaccinated_total = zeros(1,250);
percentage_total = zeros(1,250);
maximum_percentage = 0;



% Placing people on the grid randomly
for i = 1:200 
    for k = 1:2 
        randomizer = randi([-12 12]) ; 
        people(i, k) = randomizer ;
    end
end
% Randomly selecting 20 people (10% of the 200 population)
% We will use the 3rd column to assign if the person has the disase or not
sum_third_column = 0;
sum_fifth_column = 0;
while sum_third_column < 20 && sum_fifth_column < 15
    selecter  = randi([1 200]) ;
    if people(selecter , 3) == 0
        people(selecter, 3) = 1;
        if sum_fifth_column < 15
            people(selecter, 5) = 1;
            isolation(selecter,1) = people(selecter,1);
            isolation(selecter,2) = people(selecter,2);
            sum_fifth_column = sum(people(:, 5));
        end
    end
    sum_third_column = sum(people(:, 3));
end


% Movement model will include the functions transmit_infection() and
% healing_mechanism()
% Now we will also add the vaccination_mechanism which simulates 

for n = 1:250
    [people,vaccination_iteration] = vaccination_mechanism(people, n,vaccination_iteration);
    [people, healing_num_iteration,dead_num_iteration] = healing_mechanism(people,healing_num_iteration,dead_num_iteration,n);   
    [people,infected_num_iteration] = transmit_infection(people, P,infected_num_iteration,n);
    movement_array = zeros(200,8);
    movement_array = movement(people,movement_array,grid_size,isolation);
    people = people + movement_array; 
    dead_num_total(n) = sum(any(isnan(people), 2)) ;
    infected_and_vaccinated_total(n) = sum(people(:,3) == 1 & people(:,6) == 1);
    if n == 1 
        infected_total(n) = infected_num_iteration(n);
        healing_total(n) = healing_num_iteration(n);
    else 
        infected_total(n) = infected_total(n-1) + infected_num_iteration(n);
        healing_total(n) = healing_total(n-1) + healing_num_iteration(n);
    end
    % Plot individuals and their health status
    sum_infected = sum(people(:, 3) == 1);
    percentage = 100 * sum_infected / 200 ;
    percentage_total(n) = percentage;
    if percentage > maximum_percentage
        maximum_percentage = percentage;
    end 
    
end
   

% PLOTS OF NUMBER OF DISAESED DEAD AND OTHER
% Create a vector of iteration numbers from 1 to 250
iterations = 1:250;


% Plot for the number of infected people
% in this case, controls only percentage of infected people in every
% iteration
figure('Color','w');
bar(iterations, percentage_total, 'FaceColor','#FF0000');
title('Percentage Of Infected People In Any Iteration');
grid on;



fprintf("Maximum infected person percentage in one iteration : %.2f \n", maximum_percentage);

