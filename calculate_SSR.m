%          Calculate SSR                         Assignment Week 7
%          Sander Martijn Kerkdijk               Max Turpijn
%          Course: Behaviour Dynamics in social Networks 
%               Vrije Universiteit Amsterdam 2015
%                    Copying will be punished

function ssr = calculate_SSR( para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5)
% Make a CurrentMatrix with the function Model Compilation
CurrentZ4 = model_compilation (para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5);
% Calculate residuals CurrentMatrix - ReferenceMatrix
residuals =  CurrentZ4 - Z4;
% Calculate SSR
ssr = sum(residuals(:).^2);
% Display the SSR (Temporary line)
disp(ssr);
end