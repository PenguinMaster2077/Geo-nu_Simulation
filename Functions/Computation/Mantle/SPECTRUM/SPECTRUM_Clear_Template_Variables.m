%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Clear_Template_Variables.m
% Description     : Clear variables after computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-03-28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Complete: Mantle\n');

clear LAB lonlat surface_radius PREM;
clear detector Sig_Res_U238 Sig_Res_Th232;
clear energy p1 p2 p3 m21 m31 m32;
clear array_for_abundance array_for_signal;
clear len len_energy SPECTRUM_U_DM SPECTRUM_TH_DM SPECTRUM_U_EM SPECTRUM_TH_EM;