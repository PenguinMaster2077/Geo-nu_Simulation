%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : SPECTRUM_Clear_Template_Variables.m
% Description     : Clear variables after computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-03-26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Clear_Template_Variables.m"));

clear len;
clear SPECTRUM_U SPECTRUM_TH temp_spectrum_u temp_spectrum_th;