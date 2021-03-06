%          Model Compilation                     Assignment Week 7
%          Sander Martijn Kerkdijk               Max Turpijn
%          Course: Behaviour Dynamics in social Networks 
%               Vrije Universiteit Amsterdam 2015
%                    Copying will be punished


function [Z1_new,Z2_new,Z3_new,Z4_new,Z5_new] = model_compilation(para_values_QFear,para_values_qBeliefSituation,para_values_qBeliefExitOption1,X1,Y1,Z1,Z2,Z3,Z4,Z5)

%   Calculate size of Given Matrix
Size = size(Y1);

%   Initialize number of agents
numberOfAgents = Size(1,2);

Size = size(Z5);
%   Set endtime
numberOfSteps = Size(1,2);
    
 % Belief about an exit and emotions felt for different exits.
deltaT = 0.1;

% The speed parameters for the formulas with Beta,Eta and Delta parameters.
% The parameters are already optimized
muBeta = 0.1; 
muEta = 0.1;
muDelta = 0.1;

%personality characteristic that controls what you do in case or fear: + is
%positive and a - is negative
zeta = 1;

% parameter for treshold function in formulas for delta, ebta and eta
sigma = 40; 
tau = 0.5; %is treshold for qFear(used in speed parameters)

% parameters for combination functions for intentions and emotions for options.
% Calculated together it should always equal 1
omegaOEA1 = 0.2;
omegaOBA1 = 0.2;
omegaOEBA = omegaOEA1 + omegaOBA1; % 1
omegaOEA2 = 0.2;
omegaOIA1 = 0.2;
omegaOBA2 = 0.2;
omegaOIEBA = omegaOEA2 + omegaOIA1 + omegaOBA2; % 1
omegaOIA2 = 0.0;
omegaOBA3 = 1;
omegaOIBA = omegaOIA2 + omegaOBA3; % 1

%initial values for Fear about a situation
standardEpsilonFear = 0.5; standardDeltaFear = 0.5; standardEtaFear = 0.5; standardBetaFear = 0.5; standardNuFear = 0.5;

%initial values for Belief about a situation
standardEpsilonBeliefSituation = 0.5;
standardDeltaBeliefSituation = 0.2;
standardEtaBeliefSituation = 0.2;
standardBetaBeliefSituation = 0.2;

%1 means very relevant and relevant for survival and 
%0 means situation dangerious but not relevant for survival
standardRBeliefSituation = 1; 
standardPBeliefSituation = 0; 

initialBetaBeliefExitOption1 = 0.4;
initialEpsilonBeliefExitOption1 = 0.3;
initialDeltaBeliefExitOption1 = 0.1;
initialEtaBeliefExitOption1 = 0.5; 

%initial values for parameters/variables that have to do with EMOTIONS felt 
%for each exit options
standardEpsilonEmotionExitOption1 = 0.2;
standardDeltaEmotionExitOption1 = 0.3;
 initialQEmotionExitOption1 = 0; 
standardEtaEmotionExitOption1 = 0.2;
standardBetaEmotionExitOption1 = 0.1; 


%initial or standard values for parameters/variables that have to do with
%intensions.

initialQIntentionExitOption1 = 0;
standardEpsilonIntentionExitOption1 = 0.2; 
standardDeltaIntentionExitOption1 = 0.2; 
standardEtaIntentionExitOption1 = 0.2; 
standardBetaIntentionExitOption1 = 0.3; 


%defining size of matricis
epsilonFear = zeros(numberOfAgents, 1);
deltaFear = zeros(numberOfAgents, 1);
etaFear = zeros(numberOfAgents, 1);
betaFear = zeros(numberOfAgents, 1);
nuFear = zeros(numberOfAgents, 1);
normalGroupImpactFear = zeros(numberOfAgents, numberOfSteps + 1);
qFearStar = zeros(numberOfAgents, numberOfSteps + 1); gammaFear = zeros(numberOfAgents , numberOfAgents);
overallGammaFear = zeros(numberOfAgents , 1);
rBeliefSituation = zeros(numberOfAgents, 1); 
pBeliefSituation = zeros(numberOfAgents, 1);
qFear = zeros(numberOfAgents, numberOfSteps + 1); 
qBeliefSituation = zeros(numberOfAgents, numberOfSteps + 1); 
betaBeliefSituation = zeros(numberOfAgents, numberOfSteps + 1);
epsilonBeliefSituation = zeros(numberOfAgents, 1); 
deltaBeliefSituation = zeros(numberOfAgents, numberOfSteps + 1);
etaBeliefSituation = zeros(numberOfAgents, numberOfSteps + 1);
overallGammaBeliefSituation = zeros(numberOfAgents , numberOfSteps + 1);
qBeliefExitOption1 = zeros(numberOfAgents, numberOfSteps + 1); 
qBeliefExitOption1Star = zeros(numberOfAgents, numberOfSteps + 1);
gammaBeliefSituation = zeros(numberOfAgents, numberOfAgents);
qBeliefSituationStar = zeros(numberOfAgents, numberOfSteps );
gammaBeliefExitOption1 = zeros(numberOfAgents, numberOfAgents); 
overallGammaBeliefExitOption1 = zeros(numberOfAgents, numberOfSteps + 1); 
betaBeliefExitOption1 = zeros(numberOfAgents, numberOfSteps + 1); 
epsilonBeliefExitOption1 = zeros(numberOfAgents, 1); 
deltaBeliefExitOption1 = zeros(numberOfAgents, numberOfSteps + 1); 
etaBeliefExitOption1 = zeros(numberOfAgents, numberOfSteps + 1); 
epsilonEmotionExitOption1 = zeros(numberOfAgents, 1); 
deltaEmotionExitOption1 = zeros(numberOfAgents, 1);  
gammaEmotionExitOption1 = zeros(numberOfAgents, numberOfAgents);
overallGammaEmotionExitOption1 = zeros(numberOfAgents,1); 
overallGammaEmotionExitOption1Star = zeros(numberOfAgents, 1);
qEmotionExitOption1 = zeros(numberOfAgents, numberOfSteps + 1);
etaEmotionExitOption1 = zeros(numberOfAgents, 1); 
betaEmotionExitOption1 = zeros(numberOfAgents, 1); 
qEmotionExitOption1Star = zeros(numberOfAgents, numberOfSteps + 1);
qEmotionExitOption1StarStar = zeros(numberOfAgents, numberOfSteps + 1);
qIntentionExitOption1 = zeros(numberOfAgents, numberOfSteps + 1);
epsilonIntentionExitOption1 = zeros(numberOfAgents, 1); 
deltaIntentionExitOption1 = zeros(numberOfAgents, 1);
gammaIntentionExitOption1 = zeros(numberOfAgents, numberOfAgents);
overallGammaIntentionExitOption1 = zeros(numberOfAgents , 1);
overallGammaIntentionExitOption1Star = zeros(numberOfAgents, 1);
etaIntentionExitOption1 = zeros(numberOfAgents, 1); 
betaIntentionExitOption1 = zeros(numberOfAgents, 1); 
qIntentionExitOption1Star = zeros(numberOfAgents, numberOfSteps + 1);
qIntentionExitOption1StarStar = zeros(numberOfAgents, numberOfSteps + 1);


%Set initial values.
qFear = para_values_QFear;
qBeliefSituation = para_values_qBeliefSituation;
qBeliefExitOption1 = para_values_qBeliefExitOption1;

%Setting the values for parameters and initial values for variables
for i = 1:numberOfAgents
    epsilonFear(i, 1) = standardEpsilonFear; deltaFear(i, 1) = standardDeltaFear; etaFear(i, 1) = standardEtaFear; betaFear(i,1) = standardBetaFear; nuFear(i,1) = standardNuFear;
rBeliefSituation(i, 1) = standardRBeliefSituation; pBeliefSituation(i,1) = standardPBeliefSituation;
epsilonBeliefSituation(i, 1) = standardEpsilonBeliefSituation; 
deltaBeliefSituation(i, 1) = standardDeltaBeliefSituation; 
etaBeliefSituation(i, 1) = standardEtaBeliefSituation; 
betaBeliefSituation(i, 1) = standardBetaBeliefSituation;
epsilonEmotionExitOption1(i, 1) = standardEpsilonEmotionExitOption1; 
deltaEmotionExitOption1(i, 1) = standardDeltaEmotionExitOption1; 
qEmotionExitOption1(i, 1) = initialQEmotionExitOption1; 
etaEmotionExitOption1(i, 1) = standardEtaEmotionExitOption1; 


%Constant for all.
qIntentionExitOption1(i, 1) = initialQIntentionExitOption1; 
epsilonIntentionExitOption1(i,1) = standardEpsilonIntentionExitOption1; 
deltaIntentionExitOption1(i, 1) = standardDeltaIntentionExitOption1;  
etaIntentionExitOption1(i,1) = standardEtaIntentionExitOption1; 
betaIntentionExitOption1(i, 1) = standardBetaIntentionExitOption1; 
end


for i = 1:numberOfAgents
betaBeliefExitOption1(i, 1) = initialBetaBeliefExitOption1; 
epsilonBeliefExitOption1(i, 1) = initialEpsilonBeliefExitOption1; 
deltaBeliefExitOption1(i, 1) = initialDeltaBeliefExitOption1; 
etaBeliefExitOption1(i, 1) = initialEtaBeliefExitOption1; 
end

%setting the beliefs of the emergenecy options about their accessibility
pBeliefExitOption1(1,1) = 0; % not accessible
rBeliefExitOption1(1,1) = 1; % information = relevant for survival

for i = 1: numberOfAgents
    if i> numberOfAgents
        qBeliefExitOption1(i, 1) = pBeliefExitOption1(i-18,1);
    end
    
end

%Calculate gamma's
%gammaFear = epsilonFear of sender * deltaFear of receiver
%overallGammaFear = sum of all gamma's from the senders to the receiver 

for i = 1: numberOfAgents
    for j = 1: numberOfAgents
        gammaFear(i,j) = epsilonFear(j,1) * deltaFear(i, 1); 
        overallGammaFear(i, 1) = sum(gammaFear(i,:)) - gammaFear(i, i);
 gammaEmotionExitOption1(i,j) = epsilonEmotionExitOption1(j,1) * deltaEmotionExitOption1(i, 1);      
overallGammaEmotionExitOption1(i, 1) = sum(gammaEmotionExitOption1(i,:)) - gammaEmotionExitOption1(i, i);

    end
end

%calculation of overallGammaExitOptionStar = overallGamm multiplied by the sum of the omega's

for i =1: numberOfAgents
    overallGammaEmotionExitOption1Star(i, 1) = overallGammaEmotionExitOption1(i, 1) * omegaOEBA;
end
        
%calculating contagion strengths for intentions towards the exit option 
%calculation of overallGamma's of intentions for exit option = sum of all sending gamma's to a receiver

for i = 1: numberOfAgents
for j = 1: numberOfAgents 
    gammaIntentionExitOption1(i,j) = epsilonIntentionExitOption1(j,1) * deltaIntentionExitOption1(i, 1);     
    overallGammaIntentionExitOption1(i, 1) = sum(gammaIntentionExitOption1(i,:)) - gammaIntentionExitOption1(i, i);

end
end

%calculation of overallGammaExitOptionStar = overallGamm multiplied by the sum of the omega's

for i =1: numberOfAgents
if i <= numberOfAgents
overallGammaIntentionExitOption1Star(i, 1) = overallGammaIntentionExitOption1(i, 1) * omegaOIEBA;
overallGammaIntentionExitOption1Star(i, 1) = overallGammaIntentionExitOption1 (i, 1) * omegaOIBA;

end
end


%The calculations that run over time ; Beliefs, Intentions,Emotions and
%Fear.


for n = 1: numberOfSteps;
%qFearStar = group impact of qFear on receiver
%qFear = fear of person as a receiver = first formula,

for i=1: numberOfAgents
for j= 1: numberOfAgents 
normalGroupImpactFear(i, n) = (gammaFear(i, 1: numberOfAgents) * qFear(1: numberOfAgents, n)) /overallGammaFear(i, 1);
qFearStar(i, n+1) = nuFear(i, 1) * normalGroupImpactFear(i, n) + (1-nuFear (i,1)) * ((1-pBeliefSituation(i,1)) * rBeliefSituation(i,1) * qBeliefSituation(i, n));

if i <= numberOfAgents
qFear(i, n+1) = qFear(i, n) + overallGammaFear(i, 1)*(etaFear(i, 1)*(betaFear(i, 1)*(1 - (1 - qFearStar(i, n))*(1-qFear(i, n))) + (1-betaFear(i,1)) * qFearStar(i, n) * qFear(i, n)) + (1-etaFear(i, 1)) * qFearStar(i, n) - qFear(i, n)) * deltaT;
else
qFear(i, n+1) = qFearStar(i, n+1);
end

end

end


%Belief about the situation
%calculates the contagion strength for belief about the situation
%overallGammaBeliefSituation = sum of all gamma's from the senders to a the receiver


for i = 1: numberOfAgents
for j = 1: numberOfAgents
gammaBeliefSituation(i, j) = epsilonBeliefSituation(i,1) * deltaBeliefSituation(j, n);
overallGammaBeliefSituation(i, n) = sum(gammaBeliefSituation(i,:)) - gammaBeliefSituation(i, i);
end
end

%updates delta, beta en eta
for i = 1: numberOfAgents
betaBeliefSituation(i, n+1) = betaBeliefSituation(i, n) + muBeta * (1 / (1 + exp(-sigma*(qFear(i, n) - tau)))) * (1- qBeliefSituation(i, n)) * ((1 - pBeliefSituation(i, 1)) - betaBeliefSituation(i, n)) * deltaT;

if(betaBeliefSituation(i, n+1) > 1)
 betaBeliefSituation(i, n+1) = 1;   
end
if(betaBeliefSituation(i, n+1) < 0)
 betaBeliefSituation(i, n+1) = 0;   
end

etaBeliefSituation(i, n+1) = etaBeliefSituation(i, n) + muEta * (1 / (1 + exp(- sigma*(qFear(i, n) - tau)))) * (rBeliefSituation(i, 1) * (1 - pBeliefSituation(i, 1)) * (qBeliefSituation(i, n) - etaBeliefSituation(i, n))) * deltaT;
deltaBeliefSituation(i, n+1) = deltaBeliefSituation(i, n) + muDelta * (1 / (1 + exp(-sigma*(qFear(i, n) - tau)))) * ((1 -( 1- rBeliefSituation(i, 1)) * qBeliefSituation(i, n)) - deltaBeliefSituation(i, n)) * deltaT;
end

%qStarBeliefSituation = group impact of qBeliefSituation on receiver 
for i=1: numberOfAgents
for j= 1: numberOfAgents
qBeliefSituationStar(i, n) = (gammaBeliefSituation(i, 1: numberOfAgents) * qBeliefSituation(1: numberOfAgents, n))/overallGammaBeliefSituation(i, n);
qBeliefSituation(i, n+1) = qBeliefSituation(i, n) + overallGammaBeliefSituation(i, n) * ( etaBeliefSituation(i, n) * ( betaBeliefSituation (i, n) * (1 - ( 1 - qBeliefSituationStar(i, n)) * ( 1 - qBeliefSituation(i, n))) + (1 - betaBeliefSituation(i,n)) * qBeliefSituationStar(i, n) * qBeliefSituation(i, n)) + (1 - etaBeliefSituation(i,n)) * qBeliefSituationStar(i, n) - qBeliefSituation(i, n)) * deltaT;
end
end

%calculating contagion strengths for belief about the exit option
%overallGammaBeliefExitOptions = sum of all gamma's from the senders to the receiver

for i = 1: numberOfAgents
for j = 1: numberOfAgents
  gammaBeliefExitOption1(i,j) = epsilonBeliefExitOption1(j,1) * deltaBeliefExitOption1(i, n);
  overallGammaBeliefExitOption1(i, n) = sum(gammaBeliefExitOption1(i,:)) - gammaBeliefExitOption1(i, i); 
end
end


%update of delta, beta en eta 
%pBeliefExitOptionX / rBeliefExitOptionX are the info the exit option send

for i = 1: numberOfAgents
if i <= numberOfAgents
betaBeliefExitOption1(i, n+1) = betaBeliefExitOption1(i, n) + muBeta * (1 /(1 + exp(-sigma*(qFear(i, n) - tau)))) * (1- qBeliefExitOption1(i, n)) * ((zeta *pBeliefExitOption1(1,1)) + ((1-zeta) * (1-pBeliefExitOption1(1, 1))) - betaBeliefExitOption1(i, n)) * deltaT;
etaBeliefExitOption1(i, n+1) = etaBeliefExitOption1(i, n) + muEta * (1 / (1+ exp(-sigma*(qFear(i, n) - tau)))) * (rBeliefExitOption1(1, 1) * (1 -pBeliefExitOption1(1, 1)) * (qBeliefExitOption1(i, n) - etaBeliefExitOption1(i, n))) * deltaT;
deltaBeliefExitOption1(i, n+1) = deltaBeliefExitOption1(i, n) + muDelta * (1 / (1 + exp(-sigma*(qFear(i, n) - tau)))) * ((1 -( 1- rBeliefExitOption1(1,1)) * qBeliefExitOption1(i, n)) - deltaBeliefExitOption1(i, n)) * deltaT;
else 
betaBeliefExitOption1(i, n+1) = betaBeliefExitOption1(i, n); 
etaBeliefExitOption1(i, n+1) = etaBeliefExitOption1(i, n); 
deltaBeliefExitOption1(i, n+1) = deltaBeliefExitOption1(i, n); 
end
end

%qStarBeliefExitOption = group impact of qBeliefExitOptions on receiver
for i=1: numberOfAgents
for j= 1: numberOfAgents
qBeliefExitOption1Star(i, n + 1) = (gammaBeliefExitOption1(i, 1: numberOfAgents) * qBeliefExitOption1(1: numberOfAgents, n))/overallGammaBeliefExitOption1(i, n);
end
end

for i=1: numberOfAgents
    if i<= numberOfAgents
      qBeliefExitOption1(i, n+1) = qBeliefExitOption1(i, n) + overallGammaBeliefExitOption1(i, n) * ( etaBeliefExitOption1(i, n) * ( betaBeliefExitOption1(i, n) * (1 - ( 1 - qBeliefExitOption1Star(i, n)) * ( 1 - qBeliefExitOption1(i, n))) + (1 - betaBeliefExitOption1(i,n)) * qBeliefExitOption1Star (i, n) * qBeliefExitOption1(i, n)) + (1 - etaBeliefExitOption1(i,n)) * qBeliefExitOption1Star(i, n) - qBeliefExitOption1(i, n)) * deltaT; 
    else
      
qBeliefExitOption1(i, n+1) = qBeliefExitOption1(i, n); 

    end
end


%qEmotionExitOptionsStar = group impact of qEmotionExitOption on receiver
for i=1: numberOfAgents
    for j= 1: numberOfAgents
        qEmotionExitOption1Star(i, n + 1) = (gammaEmotionExitOption1(i, 1: numberOfAgents) * qEmotionExitOption1(1: numberOfAgents, n))/overallGammaEmotionExitOption1(i, 1);
    end
end

%qEmotionExitOptionsStarStar = group impact of qEmotionExitOptions AND qBeliefExitOptions on receiver

for i=1: numberOfAgents 
    qEmotionExitOption1StarStar(i, n+1) =(omegaOEA1 / omegaOEBA) *qEmotionExitOption1Star(i, n) + (omegaOBA1 / omegaOEBA) * qBeliefExitOption1(i, n);
end

%qEmotionExitOption = emotions of persons for each of the exit option
for i=1: numberOfAgents
for j= 1: numberOfAgents
    if i <= numberOfAgents
        qEmotionExitOption1(i, n+1) = qEmotionExitOption1(i, n) + overallGammaEmotionExitOption1Star(i, 1) * (etaEmotionExitOption1(i, 1) * (betaEmotionExitOption1(i, 1) * (1 - (1 - qEmotionExitOption1StarStar(i, n)) * (1- qEmotionExitOption1(i, n))) + (1-betaEmotionExitOption1(i,1)) * qEmotionExitOption1StarStar(i, n) * qEmotionExitOption1(i, n)) + (1- etaEmotionExitOption1(i, 1)) * qEmotionExitOption1StarStar(i, n) - qEmotionExitOption1 (i, n)) * deltaT;
    else
        qEmotionExitOption1(i + n+1) = qEmotionExitOption1StarStar(i, n + 1);
    end
end
end

%qIntentionExitOptionsStar = group impact of qIntentionExitOptions on receiver
for i=1: numberOfAgents
    for j= 1: numberOfAgents
        qIntentionExitOption1Star(i, n + 1) = (gammaIntentionExitOption1(i, 1: numberOfAgents) * qIntentionExitOption1(1: numberOfAgents, n))/overallGammaIntentionExitOption1(i, 1);
    end
end

%qIntentionExitOptionsStarStar = group impact of qIntentionExitOptions AND qBeliefExitOptions on receiver
for i=1: numberOfAgents
    if i <= numberOfAgents   
qIntentionExitOption1StarStar(i, n+1) =(omegaOIA1 / omegaOIEBA) * qIntentionExitOption1Star(i, n) + (omegaOEA2 / omegaOIEBA) * qEmotionExitOption1(i, n) + (omegaOBA2 / omegaOIEBA) * qBeliefExitOption1(i, n);
    else
        qIntentionExitOption1StarStar(i, n+1) =(omegaOIA2 / omegaOIBA) * qIntentionExitOption1Star(i, n) + (omegaOBA3 / omegaOIBA) * qBeliefExitOption1(i, n);
    end
end

%qIntentionExitOption = intentions of persons for the exit option
for i=1: numberOfAgents
    for j= 1: numberOfAgents
        if i <= numberOfAgents
            qIntentionExitOption1(i, n+1) = qIntentionExitOption1(i, n) + overallGammaIntentionExitOption1Star(i, 1) * (etaIntentionExitOption1(i, 1) * (betaIntentionExitOption1(i, 1) * (1 - (1 - qIntentionExitOption1StarStar(i, n)) * (1- qIntentionExitOption1(i, n))) + (1-betaIntentionExitOption1(i,1)) * qIntentionExitOption1StarStar(i, n) * qIntentionExitOption1(i, n)) + (1- etaIntentionExitOption1(i, 1)) * qIntentionExitOption1StarStar(i, n) - qIntentionExitOption1(i, n)) * deltaT;
        else
         
qIntentionExitOption1(i, n + 1) = qIntentionExitOption1StarStar(i, n + 1);
        end
    end
end
end

Z1 = zeros(numberOfAgents, numberOfSteps); 
Z2 = zeros(numberOfAgents, numberOfSteps); 
Z3 = zeros(numberOfAgents, numberOfSteps);
Z4 = zeros(numberOfAgents, numberOfSteps); 
Z5 = zeros(numberOfAgents, numberOfSteps); 

for i=1:numberOfAgents
    for j=1:numberOfSteps
        Z1(i, j) = qFearStar(i, j);
        Z2(i, j) = qBeliefSituation(i, j); 
        Z3(i, j) = qBeliefExitOption1(i, j); 
        Z4(i, j) = qIntentionExitOption1(i, j); 
        Z5(i, j)= qEmotionExitOption1(i, j);

        
    end
end
Z1_new = Z1;
Z2_new = Z2;
Z3_new = Z3;
Z4_new = Z4;
Z5_new = Z5;
end