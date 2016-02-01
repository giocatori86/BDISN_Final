%          Calculate SSR                         Assignment Week 7
%          Sander Martijn Kerkdijk               Max Turpijn
%          Course: Behaviour Dynamics in social Networks 
%               Vrije Universiteit Amsterdam 2015
%                    Copying will be punished

function ssr = calculate_SSR( para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5)
% Make a CurrentMatrix with the function Model Compilation
[Z1_new, Z2_new, Z3_new, Z4_new, Z5_new] = model_compilation (para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5);
% Calculate residuals CurrentMatrix - ReferenceMatrix
 Z_All = [Z1,Z2,Z3,Z4,Z5];
 Z_All_New = [Z1_new,Z2_new,Z3_new,Z4_new,Z5_new];
 
residuals =  (Z_All - Z_All_New);
% Calculate SSR
ssr = sum(residuals(:).^2);
% Display the SSR (Temporary line)
end