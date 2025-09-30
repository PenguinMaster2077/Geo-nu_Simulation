%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Generate_Temp_Variables_for_Parallel.m
% Description     : Define variables used in computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Generate_Temp_Variables_For_Parallel.m"));

% ~~~~~~~~~~~~~~~~~~~~ Variables for Geonu Flux ~~~~~~~~~~~~~~~~~~~~ %
Flux_Res_U238 = Physics.Elements.Flux_Response.U238;
Flux_Res_Th232 = Physics.Elements.Flux_Response.Th232;

array_for_flux = {Flux_Res_U238, Flux_Res_Th232};
