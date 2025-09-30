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
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "Clear_Template_Variables.m"));

clear ii1 len_energy;
clear SPECTRUM_U_DM SPECTRUM_U_EM SPECTRUM_TH_DM SPECTRUM_TH_EM;
clear temp_spectrum_u temp_spectrum_u_dm temp_spectrum_u_em;
clear temp_spectrum_th temp_spectrum_th_dm temp_spectrum_th_em;