%Emir Can Dağlı 2517704 Ekin Akçay 2577419

%the center of the grid is assumed to be (0,0)

clear
clc
grid_size = 12;
P = 0.5 ;
people = zeros(200,5);
%array has been created for each individual
%first column states x-coordinates of individual
%second column states y-coordinates of individual
%third column checks infection status (1: infected, 0: not infected)
%fourth column checks how many iterations have passed since the patient
%became infected
%fifth column checked whether the person complies with the isolation rules
%(1: obey the rules, 0: not obey)
isolation = zeros(200,2);
%isolation array controls the infection position if the individual obey the
%isolation rules
maximum_percentage = 0;
%additional parameters are controlled within functions

%creating arrays for plotting purposes
infected_num_iteration = zeros(1,250);
infected_total = zeros(1,250);
healing_num_iteration = zeros(1,250);
healing_total = zeros(1,250);
dead_num_iteration = zeros(1,250);
dead_num_total = zeros(1,250) ;

%placing people on the grid randomly
for i = 1:200 
    for k = 1:2 
        randomizer = randi([-12 12]) ; 
        people(i, k) = randomizer ;
    end
end
%randomly selecting 20 people (10% of the 200 population)
%it is ensured that 10 people among the 20 selected people comply with the isolation rules
%we will use the 3rd column to assign if the person has the infected or not
sum_third_column = 0;
sum_fifth_column = 0;
while sum_third_column < 20 || sum_fifth_column < 10
    selecter  = randi([1 200]) ;
    if people(selecter , 3) == 0
        people(selecter, 3) = 1;
        if sum_fifth_column < 10
            people(selecter, 5) = 1;
            isolation(selecter,1) = people(selecter,1);
            isolation(selecter,2) = people(selecter,2);
            sum_fifth_column = sum(people(:, 5));
        end
    end
    sum_third_column = sum(people(:, 3));
end

for n = 1:250
    %healing mechanism
    %for the detailed information check healing_mechanism function
    [people, healing_num_iteration,dead_num_iteration] = healing_mechanism(people,healing_num_iteration,dead_num_iteration,n); 
    %for the detailed information check transmit_infection function
    [people,infected_num_iteration,isolation] = transmit_infection(people, P,infected_num_iteration,n, isolation);
    %create movement array for each iteration and adding the movement array
    %for people positions
    %movement function also includes the isolation movement
    movement_array = zeros(200,5);
    movement_array = movement(people,movement_array,grid_size,isolation);
    people = people + movement_array;
    %control total dead people
    dead_num_total(n) = sum(any(isnan(people), 2)) ;
    %adding plot variables
    if n == 1 
        infected_total(n) = infected_num_iteration(n);
        healing_total(n) = healing_num_iteration(n);
    else 
        %control total infected and healed people
        infected_total(n) = infected_total(n-1) + infected_num_iteration(n);
        healing_total(n) = healing_total(n-1) + healing_num_iteration(n);
    end
    sum_third_column = sum(people(:, 3));
    percentage = 100 * sum_third_column / 200 ;
    %control the percentage total infected person in every iteration
    if percentage > maximum_percentage
        maximum_percentage = percentage;
    end 
end
   

iterations = 1:250;

figure('color','w');

% Plot for the number of infected people
subplot(3,2,1);
bar(iterations, infected_num_iteration, 'FaceColor','#FF0000');
title('Number of Infected People Over Iterations');
grid on;

subplot(3,2,2);
bar(iterations, infected_total, 'FaceColor','#FF0000');
title('Total Number of Infected People Over Iterations');
grid on;

% Plot for the number of healed people
subplot(3,2,3);
bar(iterations, healing_num_iteration, 'FaceColor', '#0091FF');
title('Number of Healed People Over Iterations');
grid on;

subplot(3,2,4);
bar(iterations, healing_total, 'FaceColor', '#0091FF');
title('Total Number of Healed People Over Iterations');
grid on;

% Plot for the number of dead people
subplot(3,2,5);
bar(iterations, dead_num_iteration, 'FaceColor', '#202020');
title('Number of Dead People Over Iterations');
grid on;

subplot(3,2,6);
bar(iterations, dead_num_total, 'FaceColor', '#202020');
title('Total Number of Dead People Over Iterations');
grid on;

% Display the maximum percentage of infected person
fprintf("Maximum infected person percentage in one iteration : %.2f \n", maximum_percentage);



