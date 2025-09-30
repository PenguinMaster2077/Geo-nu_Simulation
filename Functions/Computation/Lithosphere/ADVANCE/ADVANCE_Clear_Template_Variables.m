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
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Clear_Template_Variables.m"));

clear Flux_Res_U238 Flux_Res_Th232;
clear FLUX_U FLUX_TH;
clear array_for_flux;