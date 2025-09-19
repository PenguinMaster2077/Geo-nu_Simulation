%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : LITE_Record_Mantle_Results.m
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
% Created On      : 2025-03-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to record: Mantle\n');
% ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ %
Output.Mantle.Geonu_Signal.Depleted.U238 = sum(SIGNAL_U_DM, 1)';
Output.Mantle.Geonu_Signal.Depleted.Th232 = sum(SIGNAL_TH_DM, 1)';
Output.Mantle.Geonu_Signal.Depleted.Total = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Depleted.Th232;

Output.Mantle.Geonu_Signal.Enriched.U238 = sum(SIGNAL_U_EM, 1)';
Output.Mantle.Geonu_Signal.Enriched.Th232 = sum(SIGNAL_TH_EM, 1)';
Output.Mantle.Geonu_Signal.Enriched.Total = Output.Mantle.Geonu_Signal.Enriched.U238 + Output.Mantle.Geonu_Signal.Enriched.Th232;

Output.Mantle.Geonu_Signal.Total.U238 = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Enriched.U238;
Output.Mantle.Geonu_Signal.Total.Th232 = Output.Mantle.Geonu_Signal.Depleted.Th232 + Output.Mantle.Geonu_Signal.Enriched.Th232;
Output.Mantle.Geonu_Signal.Total.Total = Output.Mantle.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.Th232;