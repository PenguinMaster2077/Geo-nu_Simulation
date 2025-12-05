%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Structure_Geology.m
% Description     : Define data structure of Geology
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Modified by     : Zhihao Xu
% Institution     : Tohoku University, JP
% Classification  : Modified
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Run Info ~~~~~~~~~~~~~~~~~~~~ %
Geology.Iteration = 'Input';
Geology.Random_Seed = 'Input';
global baseDir;

% ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
% % Lithosphere.Model % %
Geology.Lithosphere.Model.Index = 'Input';
Geology.Lithosphere.Model.Name = 'Load_Lithosphere_Data()';
Geology.Lithosphere.Model.Data = 'Load_Lithosphere_Data()';
Geology.Lithosphere.Model.GeoPhys = 'Load_Lithosphere_Data()';

% % % Lithosphere.Model.Method % % %
Geology.Lithosphere.Model.Method.Near_Field = 'TBD';
Geology.Lithosphere.Model.Method.Deep_Crust = 'Compute_Abundance_DeepCrust()';

% % % Lithosphere.Model.Logical % % %
Geology.Lithosphere.Model.Logical.OC = 'Assign_OC_CC()';
Geology.Lithosphere.Model.Logical.CC = 'Assign_OC_CC()';
Geology.Lithosphere.Model.Logical.Near_Field = 'TBD';

% % % Lithosphere.Model.Abundance % % %
template.U = 'Assign_Abundance_Layer()'; % Unit: g/g %
template.Th = 'Assign_Abundance_Layer()'; % Unit: g/g %
template.K = 'Assign_Abundance_Layer()'; % Unit: g/g %
layers = {'OC', 'CC', 'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
for i = 1 : length(layers)
    layer = layers{i};
    Geology.Lithosphere.Model.Abundance.(layer) = template;
end
clear template layers i layer;

% % % Lithosphere.Model.Correlation % % %
template.Vp = 'Generate_Correlations()';
template.Abundance = 'Generate_Correlations()';
template.Thickness = 'Generate_Correlations()';
layers = {'UC', 'MC', 'LC', 'LM', 's1', 's2', 's3'};
for i = 1 : length(layers)
    layer = layers{i};
    Geology.Lithosphere.Model.Correlation.(layer) = template;% Unit: g/g
end
clear template layers i layer;

% % % Lithosphere.Mode.Correlation.MC/LC.DeepCrust % % %
template.End.Abundance = 'Generate_Correlations()';
template.End.Vp = 'Generate_Correlations()';
template.Bivar.Abundance = 'Generate_Correlations()';
template.Bivar.SiO2 = 'Generate_Correlations(), Compute_DeepCrust()';
Geology.Lithosphere.Model.Correlation.MC.DeepCrust = template;
Geology.Lithosphere.Model.Correlation.LC.DeepCrust = template;
clear template;

% % % Lithosphere.Model.DeepCrust: Hunag % % %
template.Felsic.U = 'Compute_Abundance_DeepCrust()';
template.Felsic.Th = 'Compute_Abundance_DeepCrust()';
template.Felsic.K = 'Compute_Abundance_DeepCrust()';
template.Mafic.U = 'Compute_Abundance_DeepCrust()';
template.Mafic.Th = 'Compute_Abundance_DeepCrust()';
template.Mafic.K = 'Compute_Abundance_DeepCrust()';
Geology.Lithosphere.Model.DeepCrust.Amphibolite = template;
Geology.Lithosphere.Model.DeepCrust.Granulite = template;
clear template;

% % % Lithosphere.Model.DeepCrust: Bivart % % %
Geology.Lithosphere.Model.DeepCrust.Bivart = 'Compute_Abundance_DeepCrust()';

% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %
Geology.Mantle.Method = 'Input';
Geology.Mantle.Proption_EM = 'Input';
Geology.Mantle = load(fullfile(baseDir, "Input_Files", "PREM.mat"));
Geology.Mantle.Correlation = 'Generate_Correlations()';
% % Mantle.Abundance % %
abundance_fields = {'U', 'Th', 'K', 'U238', 'U235'};
for ii1 = 1 : length(abundance_fields)
    field = abundance_fields{ii1};
    Geology.Mantle.Abundance.DM.(field) = 'Compute_Mantle_Variables.m';
    Geology.Mantle.Abundance.EM.(field) = 'Compute_Mantle_Variables.m';
    Geology.Mantle.Abundance.Total.(field) = 'Compute_Mantle_Variables.m';
end

% % Mantle.Mass % %
Geology.Mantle.Mass.Total.Rock = 'Compute_Mantle_Variables.m';
Geology.Mantle.Mass.Total.U = 'Compute_Mantle_Variables.m';
Geology.Mantle.Mass.Total.U238 = 'Compute_Mantle_Variables.m';
Geology.Mantle.Mass.Total.U235 = 'Compute_Mantle_Variables.m';
Geology.Mantle.Mass.Total.Th = 'Compute_Mantle_Variables.m';
mass_fields = {'Rock', 'U238', 'U235', 'U', 'Th', 'K40'};
for ii1 = 1 : length(mass_fields)
    field = mass_fields{ii1};
    Geology.Mantle.Mass.DM.(field) = 'Compute_Mantle_Variables.m';
    Geology.Mantle.Mass.EM.(field) = 'Compute_Mantle_Variables.m';
end
clear abundance_fields mass_fields;
clear ii1 field;

% ~~~~~~~~~~~~~~~~~~~~ BSE ~~~~~~~~~~~~~~~~~~~~ %
% % BSE.Mass % %
Geology.BSE.Mass.Rock = 'Compute_Mantle_Variables.m';
Geology.BSE.Mass.U = 'Compute_Mantle_Variables.m';
Geology.BSE.Mass.U238 = 'Compute_Mantle_Variables.m';
Geology.BSE.Mass.U235 = 'Compute_Mantle_Variables.m';
Geology.BSE.Mass.Th = 'Compute_Mantle_Variables.m';
Geology.BSE.Mass.K = 'TBD';

% % BSE.Abundance % %
Geology.BSE.Abundance.U_Mean = 'Input';
Geology.BSE.Abundance.U = 'Compute_Abundance_BSE()';
Geology.BSE.Abundance.Th = 'Compute_Abundance_BSE()';
Geology.BSE.Abundance.K = 'Compute_Abundance_BSE()';

% % BSE.Correlation % %
Geology.BSE.Correlation = 'Generate_Correlations()';

% ~~~~~~~~~~~~~~~~~~~~ Other ~~~~~~~~~~~~~~~~~~~~ %
Geology.Other.Earth.Mass = 'Compute_Mantle_Variables.m';
Geology.Other.Core.Mass = 'Compute_Mantle_Variables.m';
