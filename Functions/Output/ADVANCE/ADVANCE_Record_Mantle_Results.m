%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Record_Mantle_Results.m
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
%   - heat power    : TW
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to recording: Mantle\n');
% ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ %
% % ~~~~~~~~~~~~~~~~~~~~ Signal ~~~~~~~~~~~~~~~~~~~~ % %
Output.Mantle.Geonu_Signal.Depleted.U238 = sum(signal_u_dm, 1)';
Output.Mantle.Geonu_Signal.Depleted.Th232 = sum(signal_th_dm, 1)';
Output.Mantle.Geonu_Signal.Depleted.Total = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Depleted.Th232;

Output.Mantle.Geonu_Signal.Enriched.U238 = sum(signal_u_em, 1)';
Output.Mantle.Geonu_Signal.Enriched.Th232 = sum(signal_th_em, 1)';
Output.Mantle.Geonu_Signal.Enriched.Total = Output.Mantle.Geonu_Signal.Enriched.U238 + Output.Mantle.Geonu_Signal.Enriched.Th232;

Output.Mantle.Geonu_Signal.Total.U238 = Output.Mantle.Geonu_Signal.Depleted.U238 + Output.Mantle.Geonu_Signal.Enriched.U238;
Output.Mantle.Geonu_Signal.Total.Th232 = Output.Mantle.Geonu_Signal.Depleted.Th232 + Output.Mantle.Geonu_Signal.Enriched.Th232;
Output.Mantle.Geonu_Signal.Total.Total = Output.Mantle.Geonu_Signal.Total.U238 + Output.Mantle.Geonu_Signal.Total.Th232;

% % ~~~~~~~~~~~~~~~~~~~~ Flux ~~~~~~~~~~~~~~~~~~~~ % %
Output.Mantle.Geonu_Flux.Depleted.U238 = sum(flux_u_dm, 1)';
Output.Mantle.Geonu_Flux.Depleted.Th232 = sum(flux_th_dm, 1)';
Output.Mantle.Geonu_Flux.Depleted.Total = Output.Mantle.Geonu_Flux.Depleted.U238 + Output.Mantle.Geonu_Flux.Depleted.Th232;

Output.Mantle.Geonu_Flux.Enriched.U238 = sum(flux_u_em, 1)';
Output.Mantle.Geonu_Flux.Enriched.Th232 = sum(flux_th_em, 1)';
Output.Mantle.Geonu_Flux.Enriched.Total = Output.Mantle.Geonu_Flux.Enriched.U238 + Output.Mantle.Geonu_Flux.Enriched.Th232;

Output.Mantle.Geonu_Flux.Total.U238 = Output.Mantle.Geonu_Flux.Depleted.U238 + Output.Mantle.Geonu_Flux.Enriched.U238;
Output.Mantle.Geonu_Flux.Total.Th232 = Output.Mantle.Geonu_Flux.Depleted.Th232 + Output.Mantle.Geonu_Flux.Enriched.Th232;
Output.Mantle.Geonu_Flux.Total.Total = Output.Mantle.Geonu_Flux.Total.U238 + Output.Mantle.Geonu_Flux.Total.Th232;

% % ~~~~~~~~~~~~~~~~~~~~ Heat Power ~~~~~~~~~~~~~~~~~~~~ % %
% abun_mass_u238 = Physics.Elements.Abundance.Mass.U238;
% abun_mass_th232 = Physics.Elements.Abundance.Mass.Th232;
hp_res_u = Physics.Elements.Heat_Power.U;
hp_res_th = Physics.Elements.Heat_Power.Th232;

Output.Mantle.Heat_Power.Depleted.U = hp_res_u .* sum(mass_u_dm, 1)';
Output.Mantle.Heat_Power.Depleted.Th = hp_res_th .* sum(mass_th_dm, 1)';
Output.Mantle.Heat_Power.Depleted.Total = Output.Mantle.Heat_Power.Depleted.U + Output.Mantle.Heat_Power.Depleted.Th;

Output.Mantle.Heat_Power.Enriched.U = hp_res_u .* sum(mass_u_em, 1)';
Output.Mantle.Heat_Power.Enriched.Th = hp_res_th .* sum(mass_th_em, 1)';
Output.Mantle.Heat_Power.Enriched.Total = Output.Mantle.Heat_Power.Enriched.U + Output.Mantle.Heat_Power.Enriched.Th;

Output.Mantle.Heat_Power.Total.U = Output.Mantle.Heat_Power.Depleted.U + Output.Mantle.Heat_Power.Depleted.Th;
Output.Mantle.Heat_Power.Total.Th = Output.Mantle.Heat_Power.Depleted.Th + Output.Mantle.Heat_Power.Enriched.Th;
Output.Mantle.Heat_Power.Total.Total = Output.Mantle.Heat_Power.Total.U + Output.Mantle.Heat_Power.Total.Th;

clear abun_mass_u238 abun_mass_th232 hp_res_u hp_res_th;