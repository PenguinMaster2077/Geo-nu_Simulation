%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Recording_Mass.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - mass        : kg
%
% Created On      : 2025-09-30
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(layer_part, 'Lithosphere')
    fprintf('%s: Recording Mass\n', name_layer);

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
    aU238 = Physics.Elements.Abundance.Mass.U238;
    aU235 = Physics.Elements.Abundance.Mass.U235;
    Output.Lithosphere.Mass.(name_layer).Rock = sum(MASS_ROCK, 1)';
    Output.Lithosphere.Mass.(name_layer).U = sum(MASS_U, 1)';
    Output.Lithosphere.Mass.(name_layer).U238 = sum(MASS_U .* aU238, 1)';
    Output.Lithosphere.Mass.(name_layer).U235 = sum(MASS_U .* aU235, 1)';
    Output.Lithosphere.Mass.(name_layer).Th = sum(MASS_TH, 1)';
    clear aU238 aU235;

    % ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
    if strcmp(name_layer, 'LM')
        layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
        template = 0 .* Output.Lithosphere.Mass.s1.Rock;
        Output.Lithosphere.Mass.Total.Rock = template;
        Output.Lithosphere.Mass.Total.U = template;
        Output.Lithosphere.Mass.Total.U238 = template;
        Output.Lithosphere.Mass.Total.U235 = template;
        Output.Lithosphere.Mass.Total.Th = template;
        % % Add up all layers % %
        for ii1 = 1 : length(layers)
            layer = layers{ii1};
            Output.Lithosphere.Mass.Total.Rock = Output.Lithosphere.Mass.Total.Rock + Output.Lithosphere.Mass.(layer).Rock;
            Output.Lithosphere.Mass.Total.U = Output.Lithosphere.Mass.Total.U + Output.Lithosphere.Mass.(layer).U;
            Output.Lithosphere.Mass.Total.U238 = Output.Lithosphere.Mass.Total.U238 + Output.Lithosphere.Mass.(layer).U238;
            Output.Lithosphere.Mass.Total.U235 = Output.Lithosphere.Mass.Total.U235 + Output.Lithosphere.Mass.(layer).U235;
            Output.Lithosphere.Mass.Total.Th = Output.Lithosphere.Mass.Total.Th + Output.Lithosphere.Mass.(layer).Th;
        end
        clear template layers layer;
    end
elseif strcmp(layer_part, 'Mantle')
    fprintf('Mantle: Recording Mass\n');

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
    aU238 = Physics.Elements.Abundance.Mass.U238;
    aU235 = Physics.Elements.Abundance.Mass.U235;
    Output.Mantle.Mass.DM.Rock = Geology.Mantle.Mass.DM.Rock;
    Output.Mantle.Mass.DM.U = sum(MASS_U_DM, 1)';
    Output.Mantle.Mass.DM.U238 = sum(MASS_U_DM .* aU238, 1)';
    Output.Mantle.Mass.DM.U235 = sum(MASS_U_DM .* aU235, 1)';
    Output.Mantle.Mass.DM.Th = sum(MASS_TH_DM, 1)';

    Output.Mantle.Mass.EM.Rock = Geology.Mantle.Mass.EM.Rock;
    Output.Mantle.Mass.EM.U = sum(MASS_U_EM, 1)';
    Output.Mantle.Mass.EM.U238 = sum(MASS_U_EM .* aU238, 1)';
    Output.Mantle.Mass.EM.U235 = sum(MASS_U_EM .* aU235, 1)';
    Output.Mantle.Mass.EM.Th = sum(MASS_TH_EM, 1)';
    
    Output.Mantle.Mass.Total.Rock = Geology.Mantle.Mass.Total.Rock;
    Output.Mantle.Mass.Total.U = Output.Mantle.Mass.DM.U + Output.Mantle.Mass.EM.U;
    Output.Mantle.Mass.Total.U238 = Output.Mantle.Mass.DM.U238 + Output.Mantle.Mass.EM.U238;
    Output.Mantle.Mass.Total.U235 = Output.Mantle.Mass.DM.U235 + Output.Mantle.Mass.EM.U235;
    Output.Mantle.Mass.Total.Th = Output.Mantle.Mass.DM.Th + Output.Mantle.Mass.EM.Th;
    clear aU238 aU235;
end