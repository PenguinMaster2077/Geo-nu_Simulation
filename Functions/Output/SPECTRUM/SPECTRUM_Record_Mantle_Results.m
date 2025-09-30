%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Record_Mantle_Results.m
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
fprintf('Start to record: Mantle\n');
% run(fullfile(baseDir, "Functions", "Output", "Recording_Signal_Rate.m"));
% ~~~~~~~~~~~~~~~~~~~~ Spectrum ~~~~~~~~~~~~~~~~~~~~ %
Output.Mantle.Geonu_Spectrum.Depleted.U238 = SPECTRUM_U_DM;
Output.Mantle.Geonu_Spectrum.Depleted.Th232 = SPECTRUM_TH_DM;
Output.Mantle.Geonu_Spectrum.Depleted.Total = Output.Mantle.Geonu_Spectrum.Depleted.U238 + Output.Mantle.Geonu_Spectrum.Depleted.Th232;

Output.Mantle.Geonu_Spectrum.Enriched.U238 = SPECTRUM_U_EM;
Output.Mantle.Geonu_Spectrum.Enriched.Th232 = SPECTRUM_TH_EM;
Output.Mantle.Geonu_Spectrum.Enriched.Total = Output.Mantle.Geonu_Spectrum.Enriched.U238 + Output.Mantle.Geonu_Spectrum.Enriched.Th232;

Output.Mantle.Geonu_Spectrum.Total.U238 = Output.Mantle.Geonu_Spectrum.Depleted.U238 + Output.Mantle.Geonu_Spectrum.Enriched.U238;
Output.Mantle.Geonu_Spectrum.Total.Th232 = Output.Mantle.Geonu_Spectrum.Depleted.Th232 + Output.Mantle.Geonu_Spectrum.Enriched.Th232;
Output.Mantle.Geonu_Spectrum.Total.Total = Output.Mantle.Geonu_Spectrum.Total.U238 + Output.Mantle.Geonu_Spectrum.Total.Th232;
