
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Mantle_Variables.m
% Description     : Compute variables used in mantle computation
%
% Original Author : main code by old GEONU
% Modified by     : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Modified
%
%
% Physical Units:
%   - mass          : kg
%   - abundance     : g/g
%
% Created On      : 2025-03-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to process: Mantle\n');
layer_part = 'Mantle';

% ~~~~~~~~~~~~~~~~~~~~ Mass ~~~~~~~~~~~~~~~~~~~~ %
% From tbl1 in Chambat & Valette (2010), https://doi.org/10.1111/j.1365-246X.2010.04771.x
% and tbl2 in Yoder (1995), https://doi.org/10.1029/RF001p0001
earth_mass = Generate_Random_Normal(5.97218e24, 6e19, iteration);
x = 1.835e24 + 9.675e22; % Unit: kg; Mass of inner and outer core %
core_mass = Generate_Random_Normal(x, x * 0.03 ,iteration); % Unit: kg %
bse_mass = earth_mass - core_mass; % Unit: kg %
mantle_mass = bse_mass - Output.Lithosphere.Mass.Total.Rock; % Unit: kg %
mantle_u_mass = bse_mass .* Geology.BSE.Abundance.U - Output.Lithosphere.Mass.Total.U; % Unit: kg %
mantle_th_mass = bse_mass .* Geology.BSE.Abundance.Th - Output.Lithosphere.Mass.Total.Th; % Unit: kg %
clear x;

% ~~~~~~~~~~~~~~~~~~~~ Generate Abundance for DM ~~~~~~~~~~~~~~~~~~~~ %
prop_em = Geology.Mantle.Proption_EM;
prop_dm = 1- prop_em;
cor = Geology.Mantle.Correlation;
TH_U_Ratio_DM = Generate_Random_Log_Normal(3.45, 1.66, 1.18, iteration, cor); % Unit: g/g %
K_U_Ratio_DM = Generate_Random_Normal(19000, 1300, iteration, cor); % Unit: g/g %
temp_au_dm = Generate_Random_Normal(8, 8 * 0.3, iteration, cor) .* 1e-9; % Unit: g/g %
temp_au_dm(temp_au_dm < 0, 1) = 0;

index = mantle_u_mass >= temp_au_dm .* (mantle_mass .* prop_dm);
% % For the index is true, assign temp_au_dm % %
template = zeros(iteration, 1);
mantle_au_dm = template;
mantle_ath_dm = template;

mantle_au_dm(index) = temp_au_dm(index);
mantle_ath_dm(index) = mantle_au_dm(index) .* TH_U_Ratio_DM(index);

% % For the index is false, assign anther abundance % %
mantle_au_dm(~index) = mantle_u_mass(~index) ./ (mantle_mass(~index) * prop_dm);
mantle_ath_dm(~index) = mantle_au_dm(~index) .* TH_U_Ratio_DM(~index);
mantle_au_dm(mantle_au_dm < 0) = 0;
mantle_ath_dm(mantle_ath_dm < 0) = 0;

% ~~~~~~~~~~~~~~~~~~~~ Generate Abundance for EM ~~~~~~~~~~~~~~~~~~~~ %
mantle_au_em = (mantle_u_mass - mantle_au_dm  .* mantle_mass * prop_dm) ./ (mantle_mass * prop_em);
mantle_ath_em = (mantle_th_mass - mantle_ath_dm .* mantle_mass * prop_dm) ./ (mantle_mass * prop_em);
mantle_au_em(mantle_au_em < 0) = 0;
mantle_ath_em(mantle_ath_em < 0) = 0;

% ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ %
Geology.Other.Earth.Mass = earth_mass;
Geology.Other.Core.Mass = core_mass;
Geology.BSE.Mass.Rock = bse_mass;
Geology.BSE.Mass.U = bse_mass .* Geology.BSE.Abundance.U;
Geology.BSE.Mass.U238 = Geology.BSE.Mass.U .* Physics.Elements.Abundance.Mass.U238;
Geology.BSE.Mass.U235 = Geology.BSE.Mass.U .* Physics.Elements.Abundance.Mass.U235;
Geology.BSE.Mass.Th = bse_mass .* Geology.BSE.Abundance.Th;

Geology.Mantle.Mass.Total.Rock = mantle_mass;
Geology.Mantle.Mass.Total.U = mantle_u_mass;
Geology.Mantle.Mass.Total.U238 = Geology.Mantle.Mass.Total.U .* Physics.Elements.Abundance.Mass.U238;
Geology.Mantle.Mass.Total.U235 = Geology.Mantle.Mass.Total.U .* Physics.Elements.Abundance.Mass.U235;
Geology.Mantle.Mass.Total.Th = mantle_th_mass;

Geology.Mantle.Mass.DM.Rock = Geology.Mantle.Mass.Total.Rock .* prop_dm;
Geology.Mantle.Mass.DM.U = Geology.Mantle.Mass.DM.Rock .* mantle_au_dm;
Geology.Mantle.Mass.DM.U238 = Geology.Mantle.Mass.DM.U .* Physics.Elements.Abundance.Mass.U238;
Geology.Mantle.Mass.DM.U235 = Geology.Mantle.Mass.DM.U .* Physics.Elements.Abundance.Mass.U235;
Geology.Mantle.Mass.DM.Th = Geology.Mantle.Mass.DM.Rock .* mantle_ath_dm;

Geology.Mantle.Mass.EM.Rock = Geology.Mantle.Mass.Total.Rock .* prop_em;
Geology.Mantle.Mass.EM.U = Geology.Mantle.Mass.EM.Rock .* mantle_au_em;
Geology.Mantle.Mass.EM.U238 = Geology.Mantle.Mass.EM.U .* Physics.Elements.Abundance.Mass.U238;
Geology.Mantle.Mass.EM.U235 = Geology.Mantle.Mass.EM.U .* Physics.Elements.Abundance.Mass.U235;
Geology.Mantle.Mass.EM.Th = Geology.Mantle.Mass.EM.Rock .* mantle_ath_em;

Geology.Mantle.Abundance.Total.U = mantle_u_mass ./ mantle_mass;
Geology.Mantle.Abundance.Total.U238 = mantle_u_mass .* Physics.Elements.Abundance.Mass.U238 ./ mantle_mass;
Geology.Mantle.Abundance.Total.U235 = mantle_u_mass .* Physics.Elements.Abundance.Mass.U235 ./ mantle_mass;
Geology.Mantle.Abundance.Total.Th = mantle_th_mass ./ mantle_mass;

Geology.Mantle.Abundance.DM.U = mantle_au_dm;
Geology.Mantle.Abundance.DM.U238 = mantle_au_dm .* Physics.Elements.Abundance.Mass.U238;
Geology.Mantle.Abundance.DM.U235 = mantle_au_dm .* Physics.Elements.Abundance.Mass.U235;
Geology.Mantle.Abundance.DM.Th = mantle_ath_dm;

Geology.Mantle.Abundance.EM.U = mantle_au_em;
Geology.Mantle.Abundance.EM.U238 = mantle_au_em .* Physics.Elements.Abundance.Mass.U238;
Geology.Mantle.Abundance.EM.U235 = mantle_au_em .* Physics.Elements.Abundance.Mass.U235;
Geology.Mantle.Abundance.EM.Th = mantle_ath_em;

% % Clear % %
clear earth_mass x core_mass bse_mass mantle_mass mantle_u_mass mantle_th_mass;
clear prop_em prop_dm cor TH_U_Ratio_DM K_U_Ratio_DM temp_au_dm;
clear index template temp_au_dm mantle_au_dm mantle_ath_dm mantle_au_em mantle_ath_em;