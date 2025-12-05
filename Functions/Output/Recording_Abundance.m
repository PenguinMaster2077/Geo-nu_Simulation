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
    Output.Mantle.Abundance.DM.U = Geology.Mantle.Abundance.DM.U;
    Output.Mantle.Abundance.DM.U238 = Geology.Mantle.Abundance.DM.U238;
    Output.Mantle.Abundance.DM.U235 = Geology.Mantle.Abundance.DM.U235;
    Output.Mantle.Abundance.DM.Th = Geology.Mantle.Abundance.DM.Th;

    Output.Mantle.Abundance.EM.U = Geology.Mantle.Abundance.EM.U;
    Output.Mantle.Abundance.EM.U238 = Geology.Mantle.Abundance.EM.U238;
    Output.Mantle.Abundance.EM.U235 = Geology.Mantle.Abundance.EM.U235;
    Output.Mantle.Abundance.EM.Th = Geology.Mantle.Abundance.EM.Th;

    Output.Mantle.Abundance.Total.U = Geology.Mantle.Abundance.Total.U;
    Output.Mantle.Abundance.Total.U238 = Geology.Mantle.Abundance.Total.U238;
    Output.Mantle.Abundance.Total.U235 = Geology.Mantle.Abundance.Total.U235;
    Output.Mantle.Abundance.Total.Th = Geology.Mantle.Abundance.Total.Th;
end