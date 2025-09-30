%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Record_Lithosphere_Results.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - mass          : kg
%   - signal rate   : TNU
%   - spectrum      : TNU/MeV
%
% Created On      : 2025-03-26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to record: %s\n', name_layer);

run(fullfile(baseDir, "Functions", "Output", "Recording_Mass.m"));
% run(fullfile(baseDir, "Functions", "Output", "Recording_Signal_Rate.m"));

% ~~~~~~~~~~~~~~~~~~~~ Spectrum ~~~~~~~~~~~~~~~~~~~~ %
Output.Lithosphere.Geonu_Spectrum.(name_layer).U238 = SPECTRUM_U;
Output.Lithosphere.Geonu_Spectrum.(name_layer).Th232 = SPECTRUM_TH;
Output.Lithosphere.Geonu_Spectrum.(name_layer).Total = Output.Lithosphere.Geonu_Spectrum.(name_layer).U238 + Output.Lithosphere.Geonu_Spectrum.(name_layer).Th232;

Output.Lithosphere.Geonu_Signal.(name_layer).U238 = sum(SPECTRUM_U, 2);
Output.Lithosphere.Geonu_Signal.(name_layer).Th232 = sum(SPECTRUM_TH, 2);
Output.Lithosphere.Geonu_Signal.(name_layer).Total = Output.Lithosphere.Geonu_Signal.(name_layer).U238 + Output.Lithosphere.Geonu_Signal.(name_layer).Th232;

if strcmp(name_layer, 'LM')
    layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
    template = 0.* Output.Lithosphere.Geonu_Signal.s1.Total;
    Output.Lithosphere.Geonu_Signal.Total.Total = template;
    Output.Lithosphere.Geonu_Signal.Total.U238 = template;
    Output.Lithosphere.Geonu_Signal.Total.Th232 = template;

    template = 0 .* Output.Lithosphere.Geonu_Spectrum.s1.Total;
    Output.Lithosphere.Geonu_Spectrum.Total.Total = template;
    Output.Lithosphere.Geonu_Spectrum.Total.U238 = template;
    Output.Lithosphere.Geonu_Spectrum.Total.Th232 = template;
    % % Add up all layers % %
    for ii1 = 1 : length(layers)
        layer = layers{ii1};
        Output.Lithosphere.Geonu_Signal.Total.U238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.(layer).U238;
        Output.Lithosphere.Geonu_Signal.Total.Th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Th232;

        Output.Lithosphere.Geonu_Spectrum.Total.U238 = Output.Lithosphere.Geonu_Spectrum.Total.U238 + Output.Lithosphere.Geonu_Spectrum.(layer).U238;
        Output.Lithosphere.Geonu_Spectrum.Total.Th232 = Output.Lithosphere.Geonu_Spectrum.Total.Th232 + Output.Lithosphere.Geonu_Spectrum.(layer).Th232;
    end
    Output.Lithosphere.Geonu_Signal.Total.Total = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.Total.Th232;
    Output.Lithosphere.Geonu_Spectrum.Total.Total = Output.Lithosphere.Geonu_Spectrum.Total.U238 + Output.Lithosphere.Geonu_Spectrum.Total.Th232;
    clear template layers layer;
    
end

% Clear for Next Computation %
SPECTRUM_U = SPECTRUM_U .* 0;
SPECTRUM_TH = SPECTRUM_TH .* 0;