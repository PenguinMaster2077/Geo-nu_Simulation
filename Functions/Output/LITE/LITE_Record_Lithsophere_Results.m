%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : LITE_Record_Lithosphere_Results.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - mass          : kg
%   - signal rate   : TNU
%
% Created On      : 2025-03-18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to record: %s\n', name_layer);
% ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
Output.Lithosphere.Mass.(name_layer).Total = sum(total_mass, 1)';
Output.Lithosphere.Mass.(name_layer).U = sum(mass_u, 1)';
Output.Lithosphere.Mass.(name_layer).Th = sum(mass_th, 1)';

Output.Lithosphere.Geonu_Signal.(name_layer).Total = sum(signal_u + signal_th, 1)';
Output.Lithosphere.Geonu_Signal.(name_layer).U238 = sum(signal_u, 1)';
Output.Lithosphere.Geonu_Signal.(name_layer).Th232 = sum(signal_th, 1)';

% ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
if strcmp(name_layer, 'LM')
    layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
    template = 0 .* Output.Lithosphere.Mass.s1.Total;
    Output.Lithosphere.Mass.Total.Total = template;
    Output.Lithosphere.Mass.Total.U = template;
    Output.Lithosphere.Mass.Total.Th = template;
    Output.Lithosphere.Geonu_Signal.Total.Total = template;
    Output.Lithosphere.Geonu_Signal.Total.U238 = template;
    Output.Lithosphere.Geonu_Signal.Total.Th232 = template;
    % % Add up all layers % %
    for ii1 = 1 : length(layers)
        layer = layers{ii1};
        Output.Lithosphere.Mass.Total.Total = Output.Lithosphere.Mass.Total.Total + Output.Lithosphere.Mass.(layer).Total;
        Output.Lithosphere.Mass.Total.U = Output.Lithosphere.Mass.Total.U + Output.Lithosphere.Mass.(layer).U;
        Output.Lithosphere.Mass.Total.Th = Output.Lithosphere.Mass.Total.Th + Output.Lithosphere.Mass.(layer).Th;
        
        Output.Lithosphere.Geonu_Signal.Total.U238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.(layer).U238;
        Output.Lithosphere.Geonu_Signal.Total.Th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Th232;
    end
    Output.Lithosphere.Geonu_Signal.Total.Total = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.Total.Th232;
    clear template layers layer;
    
end