%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Clear_Template_Variables.m
% Description     : Clear variables after computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-09-30
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Complete: Mantle\n');

clear layer_part;
clear LAB lonlat surface_radius PREM;
clear detector Sig_Res_U238 Sig_Res_Th232;
clear energy p1 p2 p3 m21 m31 m32;
clear array_for_mass array_for_abundance array_for_signal;
clear len;
clear MASS_ROCK_DM MASS_ROCK_EM MASS_U_DM MASS_TH_DM MASS_U_EM MASS_TH_EM;
clear SIGNAL_U_DM SIGNAL_TH_DM SIGNAL_U_EM SIGNAL_TH_EM;
