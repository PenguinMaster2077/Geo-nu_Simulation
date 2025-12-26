%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Recording_Signal_Rate.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - signal rate : TNU
%
% Created On      : 2025-09-30
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(layer_part, 'Lithosphere')
    fprintf('%s: Recording Signal Rate\n', name_layer);

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
    Output.Lithosphere.Geonu_Signal.(name_layer).Total = sum(SIGNAL_U + SIGNAL_TH, 1)';
    Output.Lithosphere.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U, 1)';
    Output.Lithosphere.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH, 1)';

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer: Near-Field ~~~~~~~~~~~~~~~~~~~~ %
    near_index = Geology.Near_Field.Indices;
    Output.Lithosphere.Geonu_Signal.(name_layer).Near_Field.Total = sum(SIGNAL_U(near_index, :) + SIGNAL_TH(near_index, :), 1)';
    Output.Lithosphere.Geonu_Signal.(name_layer).Near_Field.U238 = sum(SIGNAL_U(near_index, :), 1)';
    Output.Lithosphere.Geonu_Signal.(name_layer).Near_Field.Th232 = sum(SIGNAL_TH(near_index, :), 1)';
    
    % ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
    if strcmp(name_layer, 'LM')
        layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
        template = 0 .* Output.Lithosphere.Geonu_Signal.s1.Total;
        Output.Lithosphere.Geonu_Signal.Total.Total = template;
        Output.Lithosphere.Geonu_Signal.Total.U238 = template;
        Output.Lithosphere.Geonu_Signal.Total.Th232 = template;

        Output.Lithosphere.Geonu_Signal.Total.Near_Field.Total = template;
        Output.Lithosphere.Geonu_Signal.Total.Near_Field.U238 = template;
        Output.Lithosphere.Geonu_Signal.Total.Near_Field.Th232 = template;
        % % Add up all layers % %
        for ii1 = 1 : length(layers)
            layer = layers{ii1};       
            Output.Lithosphere.Geonu_Signal.Total.U238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.(layer).U238;
            Output.Lithosphere.Geonu_Signal.Total.Th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Th232;

            Output.Lithosphere.Geonu_Signal.Total.Near_Field.U238 = Output.Lithosphere.Geonu_Signal.Total.Near_Field.U238 + Output.Lithosphere.Geonu_Signal.(layer).Near_Field.U238;
            Output.Lithosphere.Geonu_Signal.Total.Near_Field.Th232 = Output.Lithosphere.Geonu_Signal.Total.Near_Field.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Near_Field.Th232;
        end
        Output.Lithosphere.Geonu_Signal.Total.Total = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.Total.Th232;
        Output.Lithosphere.Geonu_Signal.Total.Near_Field.Total = Output.Lithosphere.Geonu_Signal.Total.Near_Field.U238 + Output.Lithosphere.Geonu_Signal.Total.Near_Field.Th232;
        clear template layers layer near_index;
    end
elseif strcmp(layer_part, 'Mantle')
    fprintf('Mantle: Recording Signal Rate\n');
    Output.Mantle.Geonu_Signal.DM.U238 = sum(SIGNAL_U_DM, 1)';
    Output.Mantle.Geonu_Signal.DM.Th232 = sum(SIGNAL_TH_DM, 1)';
    Output.Mantle.Geonu_Signal.DM.Total = Output.Mantle.Geonu_Signal.DM.U238 + Output.Mantle.Geonu_Signal.DM.Th232;
    
    Output.Mantle.Geonu_Signal.EM.U238 = sum(SIGNAL_U_EM, 1)';
    Output.Mantle.Geonu_Signal.EM.Th232 = sum(SIGNAL_TH_EM, 1)';
    Output.Mantle.Geonu_Signal.EM.Total = Output.Mantle.Geonu_Signal.EM.U238 + Output.Mantle.Geonu_Signal.EM.Th232;
    
    Output.Mantle.Geonu_Signal.Total.U238 = Output.Mantle.Geonu_Signal.DM.U238 + Output.Mantle.Geonu_Signal.EM.U238;
    Output.Mantle.Geonu_Signal.Total.Th232 = Output.Mantle.Geonu_Signal.DM.Th232 + Output.Mantle.Geonu_Signal.EM.Th232;
    Output.Mantle.Geonu_Signal.Total.Total = Output.Mantle.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.Th232;
end
