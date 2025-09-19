%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Clear_Template_Variables.m
% Description     : Clear variables after computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Complete: Mantle\n');

clear LAB lonlat surface_radius PREM;
clear detector Sig_Res_U238 Sig_Res_Th232 Flux_Res_U238 Flux_Res_Th232;
clear energy p1 p2 p3 m21 m31 m32;
clear array_for_abundance array_for_signal array_for_flux;
clear len;
clear mass_u_dm mass_th_dm mass_u_em mass_th_em;
clear signal_u_dm signal_th_dm signal_u_em signal_th_em;
clear flux_u_dm flux_th_dm flux_u_em flux_th_em;
