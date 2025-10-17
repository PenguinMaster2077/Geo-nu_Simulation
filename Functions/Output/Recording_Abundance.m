%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Recording_Abundance.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - abundance   : g/g
%
% Created On      : 2025-10-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(layer_part, 'Lithosphere')
    fprintf('%s: Recording Abundance\n', name_layer);

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
    Output.Lithosphere.Abundance.(name_layer).U = Output.Lithosphere.Mass.(name_layer).U ./ Output.Lithosphere.Mass.(name_layer).Rock;
    Output.Lithosphere.Abundance.(name_layer).U238 = Output.Lithosphere.Mass.(name_layer).U238 ./ Output.Lithosphere.Mass.(name_layer).Rock;
    Output.Lithosphere.Abundance.(name_layer).U235 = Output.Lithosphere.Mass.(name_layer).U235 ./ Output.Lithosphere.Mass.(name_layer).Rock;
    Output.Lithosphere.Abundance.(name_layer).Th = Output.Lithosphere.Mass.(name_layer).Th ./ Output.Lithosphere.Mass.(name_layer).Rock;
    
    % ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
    if strcmp(name_layer, 'LM')
        Output.Lithosphere.Abundance.Total.U = Output.Lithosphere.Mass.Total.U ./ Output.Lithosphere.Mass.Total.Rock;
        Output.Lithosphere.Abundance.Total.U238 = Output.Lithosphere.Mass.Total.U238 ./ Output.Lithosphere.Mass.Total.Rock;
        Output.Lithosphere.Abundance.Total.U235 = Output.Lithosphere.Mass.Total.U235 ./ Output.Lithosphere.Mass.Total.Rock;
        Output.Lithosphere.Abundance.Total.Th = Output.Lithosphere.Mass.Total.Th ./ Output.Lithosphere.Mass.Total.Rock;
    end
elseif strcmp(layer_part, 'Mantle')
    Output.Mantle.Abundance.DM.U = Output.Mantle.Mass.DM.U ./ Output.Mantle.Mass.DM.Rock;
    Output.Mantle.Abundance.DM.U238 = Output.Mantle.Mass.DM.U238 ./ Output.Mantle.Mass.DM.Rock;
    Output.Mantle.Abundance.DM.U235 = Output.Mantle.Mass.DM.U235 ./ Output.Mantle.Mass.DM.Rock;
    Output.Mantle.Abundance.DM.Th = Output.Mantle.Mass.DM.Th ./ Output.Mantle.Mass.DM.Rock;

    Output.Mantle.Abundance.EM.U = Output.Mantle.Mass.EM.U ./ Output.Mantle.Mass.EM.Rock;
    Output.Mantle.Abundance.EM.U238 = Output.Mantle.Mass.EM.U238 ./ Output.Mantle.Mass.EM.Rock;
    Output.Mantle.Abundance.EM.U235 = Output.Mantle.Mass.EM.U235 ./ Output.Mantle.Mass.EM.Rock;
    Output.Mantle.Abundance.EM.Th = Output.Mantle.Mass.EM.Th ./ Output.Mantle.Mass.EM.Rock;

    Output.Mantle.Abundance.Total.U = Output.Mantle.Mass.Total.U ./ Output.Mantle.Mass.Total.Rock;
    Output.Mantle.Abundance.Total.U238 = Output.Mantle.Mass.Total.U238 ./ Output.Mantle.Mass.Total.Rock;
    Output.Mantle.Abundance.Total.U235 = Output.Mantle.Mass.Total.U235 ./ Output.Mantle.Mass.Total.Rock;
    Output.Mantle.Abundance.Total.Th = Output.Mantle.Mass.Total.Th ./ Output.Mantle.Mass.Total.Rock;
end