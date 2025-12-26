%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Recording_Radiogenic_Heat_Power.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - Power       : W
%
% Created On      : 2025-10-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(layer_part, 'Lithosphere')
    fprintf('%s: Recording Radiogenic Heat Power\n', name_layer);
    % ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
    hp_u = Physics.Elements.Heat_Power.U;
    hp_u238 = Physics.Elements.Heat_Power.U238;
    hp_u235 = Physics.Elements.Heat_Power.U235;
    hp_th232 = Physics.Elements.Heat_Power.Th232;
    Output.Lithosphere.Heat_Power.(name_layer).U = Output.Lithosphere.Mass.(name_layer).U .* hp_u;
    Output.Lithosphere.Heat_Power.(name_layer).U238 = Output.Lithosphere.Mass.(name_layer).U238 .* hp_u238;
    Output.Lithosphere.Heat_Power.(name_layer).U235 = Output.Lithosphere.Mass.(name_layer).U235 .* hp_u235;
    Output.Lithosphere.Heat_Power.(name_layer).Th = Output.Lithosphere.Mass.(name_layer).Th .* hp_th232;
    Output.Lithosphere.Heat_Power.(name_layer).Total = Output.Lithosphere.Heat_Power.(name_layer).U + Output.Lithosphere.Heat_Power.(name_layer).Th;

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer: Near-Field ~~~~~~~~~~~~~~~~~~~~ %
    near_index = Geology.Near_Field.Indices;
    Output.Lithosphere.Heat_Power.(name_layer).Near_Field.U = Output.Lithosphere.Mass.(name_layer).Near_Field.U .* hp_u;
    Output.Lithosphere.Heat_Power.(name_layer).Near_Field.U238 = Output.Lithosphere.Mass.(name_layer).Near_Field.U238 .* hp_u238;
    Output.Lithosphere.Heat_Power.(name_layer).Near_Field.U235 = Output.Lithosphere.Mass.(name_layer).Near_Field.U235 .* hp_u235;
    Output.Lithosphere.Heat_Power.(name_layer).Near_Field.Th = Output.Lithosphere.Mass.(name_layer).Near_Field.Th .* hp_th232;
    Output.Lithosphere.Heat_Power.(name_layer).Near_Field.Total = Output.Lithosphere.Heat_Power.(name_layer).Near_Field.U + Output.Lithosphere.Heat_Power.(name_layer).Near_Field.Th;
    
    clear hp_u hp_u238 hp_u235 hp_th232;
    % ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
    if strcmp(name_layer, 'LM')
        layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
        template = 0 .* Output.Lithosphere.Heat_Power.s1.U;
        Output.Lithosphere.Heat_Power.Total.Total = template;
        Output.Lithosphere.Heat_Power.Total.U = template;
        Output.Lithosphere.Heat_Power.Total.U238 = template;
        Output.Lithosphere.Heat_Power.Total.U235 = template;
        Output.Lithosphere.Heat_Power.Total.Th = template;

        Output.Lithosphere.Heat_Power.Total.Near_Field.Total = template;
        Output.Lithosphere.Heat_Power.Total.Near_Field.U = template;
        Output.Lithosphere.Heat_Power.Total.Near_Field.U238 = template;
        Output.Lithosphere.Heat_Power.Total.Near_Field.U235 = template;
        Output.Lithosphere.Heat_Power.Total.Near_Field.Th = template;
        % % Add up all layers % %
        for ii1 = 1 : length(layers)
            layer = layers{ii1};
            Output.Lithosphere.Heat_Power.Total.U = Output.Lithosphere.Heat_Power.Total.U + Output.Lithosphere.Heat_Power.(layer).U;
            Output.Lithosphere.Heat_Power.Total.U238 = Output.Lithosphere.Heat_Power.Total.U238 + Output.Lithosphere.Heat_Power.(layer).U238;
            Output.Lithosphere.Heat_Power.Total.U235 = Output.Lithosphere.Heat_Power.Total.U235 + Output.Lithosphere.Heat_Power.(layer).U235;
            Output.Lithosphere.Heat_Power.Total.Th = Output.Lithosphere.Heat_Power.Total.Th + Output.Lithosphere.Heat_Power.(layer).Th;
            Output.Lithosphere.Heat_Power.Total.Total = Output.Lithosphere.Heat_Power.Total.Total + Output.Lithosphere.Heat_Power.(layer).Total;

            Output.Lithosphere.Heat_Power.Total.Near_Field.U = Output.Lithosphere.Heat_Power.Total.Near_Field.U + Output.Lithosphere.Heat_Power.(layer).Near_Field.U;
            Output.Lithosphere.Heat_Power.Total.Near_Field.U238 = Output.Lithosphere.Heat_Power.Total.Near_Field.U238 + Output.Lithosphere.Heat_Power.(layer).Near_Field.U238;
            Output.Lithosphere.Heat_Power.Total.Near_Field.U235 = Output.Lithosphere.Heat_Power.Total.Near_Field.U235 + Output.Lithosphere.Heat_Power.(layer).Near_Field.U235;
            Output.Lithosphere.Heat_Power.Total.Near_Field.Th = Output.Lithosphere.Heat_Power.Total.Near_Field.Th + Output.Lithosphere.Heat_Power.(layer).Near_Field.Th;
            Output.Lithosphere.Heat_Power.Total.Near_Field.Total = Output.Lithosphere.Heat_Power.Total.Near_Field.Total + Output.Lithosphere.Heat_Power.(layer).Near_Field.Total;
        end
        clear template layers layer near_index;
    end
elseif strcmp(layer_part, 'Mantle')
    fprintf('Mantle: Recording Mass\n');
    hp_u = Physics.Elements.Heat_Power.U;
    hp_u238 = Physics.Elements.Heat_Power.U238;
    hp_u235 = Physics.Elements.Heat_Power.U235;
    hp_th232 = Physics.Elements.Heat_Power.Th232;

    Output.Mantle.Heat_Power.DM.U = hp_u .* Output.Mantle.Mass.DM.U;
    Output.Mantle.Heat_Power.DM.U238 = hp_u238 .* Output.Mantle.Mass.DM.U238;
    Output.Mantle.Heat_Power.DM.U235 = hp_u235 .* Output.Mantle.Mass.DM.U235;
    Output.Mantle.Heat_Power.DM.Th = hp_th232 .* Output.Mantle.Mass.DM.Th;
    Output.Mantle.Heat_Power.DM.Total = Output.Mantle.Heat_Power.DM.U + Output.Mantle.Heat_Power.DM.Th;

    Output.Mantle.Heat_Power.EM.U = hp_u .* Output.Mantle.Mass.EM.U;
    Output.Mantle.Heat_Power.EM.U238 = hp_u238 .* Output.Mantle.Mass.EM.U238;
    Output.Mantle.Heat_Power.EM.U235 = hp_u235 .* Output.Mantle.Mass.EM.U235;
    Output.Mantle.Heat_Power.EM.Th = hp_th232 .* Output.Mantle.Mass.EM.Th;
    Output.Mantle.Heat_Power.EM.Total = Output.Mantle.Heat_Power.EM.U + Output.Mantle.Heat_Power.EM.Th;

    Output.Mantle.Heat_Power.Total.U = Output.Mantle.Heat_Power.DM.U + Output.Mantle.Heat_Power.EM.U;
    Output.Mantle.Heat_Power.Total.U238 = Output.Mantle.Heat_Power.DM.U238 + Output.Mantle.Heat_Power.EM.U238;
    Output.Mantle.Heat_Power.Total.U235 = Output.Mantle.Heat_Power.DM.U235 + Output.Mantle.Heat_Power.EM.U235;
    Output.Mantle.Heat_Power.Total.Th = Output.Mantle.Heat_Power.DM.Th + Output.Mantle.Heat_Power.EM.Th;
    Output.Mantle.Heat_Power.Total.Total = Output.Mantle.Heat_Power.DM.Total + Output.Mantle.Heat_Power.EM.Total;

    clear hp_u hp_u238 hp_u235 hp_th232;
end