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
% ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ %
Output.Mantle.Geonu_Spectrum.Depleted.U238 = spectrum_u_dm;
Output.Mantle.Geonu_Spectrum.Depleted.Th232 = spectrum_th_dm;
Output.Mantle.Geonu_Spectrum.Depleted.Total = Output.Mantle.Geonu_Spectrum.Depleted.U238 + Output.Mantle.Geonu_Spectrum.Depleted.Th232;

Output.Mantle.Geonu_Spectrum.Enriched.U238 = spectrum_u_em;
Output.Mantle.Geonu_Spectrum.Enriched.Th232 = spectrum_th_em;
Output.Mantle.Geonu_Spectrum.Enriched.Total = Output.Mantle.Geonu_Spectrum.Enriched.U238 + Output.Mantle.Geonu_Spectrum.Enriched.Th232;

Output.Mantle.Geonu_Spectrum.Total.U238 = Output.Mantle.Geonu_Spectrum.Depleted.U238 + Output.Mantle.Geonu_Spectrum.Enriched.U238;
Output.Mantle.Geonu_Spectrum.Total.Th232 = Output.Mantle.Geonu_Spectrum.Depleted.Th232 + Output.Mantle.Geonu_Spectrum.Enriched.Th232;
Output.Mantle.Geonu_Spectrum.Total.Total = Output.Mantle.Geonu_Spectrum.Total.U238 + Output.Mantle.Geonu_Spectrum.Total.Th232;

Output.Mantle.Geonu_Signal.Depleted.U238 = sum(spectrum_u_dm, 2);
Output.Mantle.Geonu_Signal.Depleted.Th232 = sum(spectrum_th_dm, 2);
Output.Mantle.Geonu_Signal.Depleted.Total = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Depleted.Th232;

Output.Mantle.Geonu_Signal.Enriched.U238 = sum(spectrum_u_em, 2);
Output.Mantle.Geonu_Signal.Enriched.Th232 = sum(spectrum_th_em, 2);
Output.Mantle.Geonu_Signal.Enriched.Total = Output.Mantle.Geonu_Signal.Enriched.U238 + Output.Mantle.Geonu_Signal.Enriched.Th232;

Output.Mantle.Geonu_Signal.Total.U238 = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Enriched.U238;
Output.Mantle.Geonu_Signal.Total.Th232 = Output.Mantle.Geonu_Signal.Depleted.Th232 + Output.Mantle.Geonu_Signal.Enriched.Th232;
Output.Mantle.Geonu_Signal.Total.Total = Output.Mantle.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.Th232;