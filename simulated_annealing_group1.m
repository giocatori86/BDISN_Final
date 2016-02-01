%          Simulated Annealing                  Assignment Week 7
%          Sander Martijn Kerkdijk               Max Turpijn
%          Course: Behaviour Dynamics in social Networks 
%               Vrije Universiteit Amsterdam 2015
%                    Copying will be punished

% INITIALIZATION


% Load Referenceset (outputs_plus_noises)
load outputs_plus_noises.mat;

% learning rate
Diagonal_Random = 0.2;

% Initialize Temperature
T = 3;

% Number of iterations to find best Accurancy
epochs = 100;

% progress of error to plot
error = zeros(1, epochs);

% Parameter initialization: weights (3*10)
para_values_QFear = rand(10, 1);
para_values_qBeliefSituation = rand(10, 1);
para_values_qBeliefExitOption1 = rand(10, 1);

% Calculate SSR for the para values on EmpericalData2 set
ssr_now = calculate_SSR( para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5);

% Initialize Count Variable
count = 1;

while (T > 0.001)
   % Decreasing the temperature on every step
    T = T * 0.99 ;
 
    error(count) = ssr_now;
    % Temporary Para Values are Para_values + Randomized value between 0
    % and 1 * Diagonal Random
    temp_para_values_QFear = para_values_QFear + (rand(10,1)-0.5) * Diagonal_Random;
    temp_para_values_qBeliefSituation = para_values_qBeliefSituation + (rand(10,1)-0.5) * Diagonal_Random;
    temp_para_values_qBeliefExitOption1 = para_values_qBeliefExitOption1 + (rand(10,1)-0.5) * Diagonal_Random;
    
    
    % For every element of para_values adjust with temporary para_values)
        for i = 1 : length(para_values_QFear)
                    temp_para_values_QFear(i) = max(0.5, min(1, temp_para_values_QFear(i) ));  
                    temp_para_values_qBeliefSituation(i) = max(0.5, min(1, temp_para_values_qBeliefSituation(i) ));
                    temp_para_values_qBeliefExitOption1(i) = max(0.5, min(1, temp_para_values_qBeliefExitOption1(i) ));
                    
                    
        end
        % Calculate temporary SSR with the temp para_values on ReferenceSet 
        temp_ssr = calculate_SSR( temp_para_values_QFear,temp_para_values_qBeliefSituation,temp_para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5);
        
        % Calculate Delta with temporary SSR - SSR_now
        delta = temp_ssr - ssr_now ;
        
        % If Delta < 0 OR random Variable < exponential(-delta/Temperature)
        if ( (delta < 0) || (rand() < exp(-delta/T) )  )
            para_values_QFear = temp_para_values_QFear ;
            para_values_qBeliefSituation = temp_para_values_qBeliefSituation ;
            para_values_qBeliefExitOption1 = temp_para_values_qBeliefExitOption1;
             
            % ssr_now becomes temporary SSR 
            ssr_now = temp_ssr ;
        end
    count = count + 1;
end

% Make Plot
x = (1: 1: count - 1 );
plot(x, error);
title({'Plot of Error within Weights'});
xlabel('epochs');
ylabel('SSR');

% Show best values in the terminal
disp('qfear =');
disp(para_values_QFear);
disp('qBeliefSituation =');
disp(para_values_qBeliefSituation);
disp('qBeliefExitOption1 =');
disp(para_values_qBeliefExitOption1);




