%          Gradient Descent                      Assignment Week 7
%          Sander Martijn Kerkdijk               Max Turpijn
%          Course: Behaviour Dynamics in social Networks 
%               Vrije Universiteit Amsterdam 2015
%                    Copying will be punished

% INITIALIZATION

% Load Referenceset (outputs_plus_noises)
load matlab.mat;

X1= X1(:,1:60);
Z1= Z1(:,1:60);
Z2= Z2(:,1:60);
Z3= Z3(:,1:60);
Z4= Z4(:,1:60);
Z5= Z5(:,1:60);

% parameter step
parameter_step = 0.01;

% learning rate
learning_rate = 0.01;

% Number of iterations to find best accurancy
epochs = 10000;

% progress of error to plot
error = zeros(1, epochs);

% Parameter initialization: weights (48)
% Parameter initialization: weights (3*10)
para_values_QFear = rand(10, 1);
para_values_qBeliefSituation = rand(10, 1);
para_values_qBeliefExitOption1 = rand(10, 1);


count = 2;
while (count <= epochs)
    % Calculate SSR for the para values on EmpericalData2 set
    ssr_now = calculate_SSR( para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5);
    error(count) = ssr_now;
        % make a empty sensibility values matrix with zeros of the length
        % of para_values
        sensitivity_values_QFear = zeros(1,length(para_values_QFear));
        sensitivity_values_qBeliefSituation = zeros(1,length(para_values_qBeliefSituation));
        sensitivity_values_qBeliefExitOption1 = zeros(1,length(para_values_qBeliefExitOption1));
        
        
        % For every element of para_values calculate parameter sensitivity)
        for i = 1 : length(para_values_QFear)
            sensitivity_values_QFear(i) = calculate_param_sensitivity( para_values_QFear, i, parameter_step, Z4, ssr_now );
            sensitivity_values_qBeliefSituation(i) = calculate_param_sensitivity( para_values_qBeliefSituation, i, parameter_step, Z4, ssr_now );
            sensitivity_values_qBeliefExitOption1(i) = calculate_param_sensitivity( para_values_qBeliefExitOption1, i, parameter_step, Z4, ssr_now );
        end
        % For every element of para_values adjust with temporary para_values - learning_rate * sensitivityvalue)
        for i = 1 : length(para_values)
                    para_values_QFear(i) = max(0, min(1, ( para_values_QFear(i)- learning_rate * sensitivity_values(i) )));
                    para_values_qBeliefSituation(i) = max(0, min(1, ( para_values_qBeliefSituation(i)- learning_rate * sensitivity_values(i) )));
                    para_values_qBeliefExitOption1(i) = max(0, min(1, ( para_values_qBeliefExitOption1(i)- learning_rate * sensitivity_values(i) )));
                    
                    
                    
        end
        
    
        if (error(count-1) - error(count) < -0.003)
         count = (epochs-1); 
        end
    count = count + 1;
end

% Make Plot
x = (1: 1: count-1);
plot(x, error);
xlabel('epochs');
ylabel('SSR');
title({'Plot of Error within Weights'});
