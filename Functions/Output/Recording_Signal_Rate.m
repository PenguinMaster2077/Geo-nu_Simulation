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
    
    % ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
    if strcmp(name_layer, 'LM')
        layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
        template = 0 .* Output.Lithosphere.Geonu_Signal.s1.Total;
        Output.Lithosphere.Geonu_Signal.Total.Total = template;
        Output.Lithosphere.Geonu_Signal.Total.U238 = template;
        Output.Lithosphere.Geonu_Signal.Total.Th232 = template;
        % % Add up all layers % %
        for ii1 = 1 : length(layers)
            layer = layers{ii1};       
            Output.Lithosphere.Geonu_Signal.Total.U238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.(layer).U238;
            Output.Lithosphere.Geonu_Signal.Total.Th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Th232;
        end
        Output.Lithosphere.Geonu_Signal.Total.Total = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.Total.Th232;
        clear template layers layer;
    end
elseif strcmp(layer_part, 'Mantle')
    fprintf('Mantle: Recording Signal Rate\n');
    Output.Mantle.Geonu_Signal.Depleted.U238 = sum(SIGNAL_U_DM, 1)';
    Output.Mantle.Geonu_Signal.Depleted.Th232 = sum(SIGNAL_TH_DM, 1)';
    Output.Mantle.Geonu_Signal.Depleted.Total = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Depleted.Th232;
    
    Output.Mantle.Geonu_Signal.Enriched.U238 = sum(SIGNAL_U_EM, 1)';
    Output.Mantle.Geonu_Signal.Enriched.Th232 = sum(SIGNAL_TH_EM, 1)';
    Output.Mantle.Geonu_Signal.Enriched.Total = Output.Mantle.Geonu_Signal.Enriched.U238 + Output.Mantle.Geonu_Signal.Enriched.Th232;
    
    Output.Mantle.Geonu_Signal.Total.U238 = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Enriched.U238;
    Output.Mantle.Geonu_Signal.Total.Th232 = Output.Mantle.Geonu_Signal.Depleted.Th232 + Output.Mantle.Geonu_Signal.Enriched.Th232;
    Output.Mantle.Geonu_Signal.Total.Total = Output.Mantle.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.Th232;
end
