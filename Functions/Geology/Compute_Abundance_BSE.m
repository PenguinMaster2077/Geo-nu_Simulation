function Geology = Compute_Abundance_BSE(Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Abundance_BSE.m
% Description     : Compute abundance for BSE
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
% Physical Units:
%   - Abundance   : g/g
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ~~~~~~~~~~~~~~~~~~~~ Setup ~~~~~~~~~~~~~~~~~~~~ % %
iteration = Geology.Iteration;
cor = Geology.BSE.Correlation;
U_mean = Geology.BSE.Abundance.U_Mean; % Unit: ppb %

% % ~~~~~~~~~~~~~~~~~~~~ Mass Ratio ~~~~~~~~~~~~~~~~~~~~ % %
% From Wipperfurth et al. (2018), https://doi.org/10.1016/j.epsl.2018.06.029,
% and Arevalo et al. (2009), https://doi.org/10.1016/j.epsl.2008.12.023% %
Th_U_Ratio = Generate_Random_Log_Normal(3.776, 0.122, 0.075, iteration, cor);
K_U_Ratio = Generate_Random_Normal(13800, 1300, iteration, cor); % ? %

% % ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ % %
% From tbl5 in McDonough & Sun (1995), https://doi.org/10.1016/0009-2541(94)00140-4 %
Geology.BSE.Abundance.U = Generate_Random_Normal(U_mean, U_mean * 0.2, iteration, cor) * 1e-9; % Unit: g/g %
% 1e-9 is used because ppb = 1e-9. The unit was not included in the input,
% so the unit effect is accounted for here. %
Geology.BSE.Abundance.Th = Th_U_Ratio .* Geology.BSE.Abundance.U; % Unit: g/g %
Geology.BSE.Abundance.K = K_U_Ratio .* Geology.BSE.Abundance.U; % Unit: g/g %

end