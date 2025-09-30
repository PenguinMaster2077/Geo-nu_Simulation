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
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "Clear_Template_Variables.m"));

clear Flux_Res_U238 Flux_Res_Th232;
clear array_for_flux;
clear MASS_U_DM MASS_TH_DM MASS_U_EM MASS_TH_EM;
clear FLUX_U_DM FLUX_TH_DM FLUX_U_EM FLUX_TH_EM;
