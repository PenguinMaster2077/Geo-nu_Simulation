function Geology = Generate_Correlations(Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Generate_Correlations.m
% Description     : Generate random correlation coefficients
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Geology     : Geology data structure
%
% Output Parameters:
%   - Geology     : Geology data structure
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Generate Correlations ~~~~~~~~~~~~~~~~~~~~ %
iteration = Geology.Iteration;
% % ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
randoms = Generate_Random_Standard_Normal(iteration); % All layers use same correlation %
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
for i = 1:length(layers)
    layer = layers{i};
    template.Vp = Generate_Random_Standard_Normal(iteration);
    template.Abundance = Generate_Random_Standard_Normal(iteration);
    template.Thickness = randoms;
    Geology.Lithosphere.Model.Correlation.(layer) = template;
end
clear layers i layer template;

% % ~~~~~~~~~~~~~~~~~~~~ Lithosphere: Deepcrust ~~~~~~~~~~~~~~~~~~~~ % %
% % % End and Bivar are used for computate abundance in MC and LC % % %
% % % End is used in Huang method; Bivar is used in Bivart method % % %
layers = {'MC', 'LC'};
for i = 1:length(layers)
    layer = layers{i};
    template.End.Abundance = Generate_Random_Standard_Normal(iteration);
    template.End.Vp = Generate_Random_Standard_Normal(iteration);
    template.Bivar.Abundance = Generate_Random_Standard_Normal(iteration);
    Geology.Lithosphere.Model.Correlation.(layer).DeepCrust = template;
end
clear layers i layer template;
% % % Bivart: SiO2 % % %
Geology = Generate_Correlations_DeepCrust(Geology, iteration);

% % ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ % %
Geology.Mantle.Correlation = Generate_Random_Standard_Normal(iteration);

% % ~~~~~~~~~~~~~~~~~~~~ BSE ~~~~~~~~~~~~~~~~~~~~ % %
Geology.BSE.Correlation = Generate_Random_Standard_Normal(iteration);

end