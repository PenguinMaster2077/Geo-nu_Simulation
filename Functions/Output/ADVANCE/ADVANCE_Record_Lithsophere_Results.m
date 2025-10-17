%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Record_Lithosphere_Results.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - mass          : kg
%   - signal rate   : TNU
%   - geonu flux    : cm^{-2} s^{-1}
%   - heat power    : W
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to record: %s\n', name_layer);

run(fullfile(baseDir, "Functions", "Output", "Recording_Mass.m"));
run(fullfile(baseDir, "Functions", "Output", "Recording_Signal_Rate.m"));
run(fullfile(baseDir, "Functions", "Output", "Recording_Radiogenic_Heat_Power.m"));

% ~~~~~~~~~~~~~~~~~~~~ ADVANCE ~~~~~~~~~~~~~~~~~~~~ %
Output.Lithosphere.Geonu_Flux.(name_layer).U238 = sum(FLUX_U, 1)';
Output.Lithosphere.Geonu_Flux.(name_layer).Th232 = sum(FLUX_TH, 1)';
Output.Lithosphere.Geonu_Flux.(name_layer).Total = Output.Lithosphere.Geonu_Flux.(name_layer).U238 + Output.Lithosphere.Geonu_Flux.(name_layer).Th232;

% ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
if strcmp(name_layer, 'LM')
    layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
    template = 0 .* Output.Lithosphere.Geonu_Flux.s1.Total;
    Output.Lithosphere.Geonu_Flux.Total.Total = template;
    Output.Lithosphere.Geonu_Flux.Total.U238 = template;
    Output.Lithosphere.Geonu_Flux.Total.Th232 = template;

    % % Add up all layers % %
    for ii1 = 1 : length(layers)
        layer = layers{ii1};
        Output.Lithosphere.Geonu_Flux.Total.U238 = Output.Lithosphere.Geonu_Flux.Total.U238 + Output.Lithosphere.Geonu_Flux.(layer).U238;
        Output.Lithosphere.Geonu_Flux.Total.Th232 = Output.Lithosphere.Geonu_Flux.Total.Th232 + Output.Lithosphere.Geonu_Flux.(layer).Th232;

    end
    Output.Lithosphere.Geonu_Flux.Total.Total = Output.Lithosphere.Geonu_Flux.Total.U238 + Output.Lithosphere.Geonu_Flux.Total.Th232;
    clear template layers layer;
    
end