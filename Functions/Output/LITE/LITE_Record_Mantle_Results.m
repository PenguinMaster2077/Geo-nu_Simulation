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

run(fullfile(baseDir, "Functions", "Output", "Recording_Mass.m"));
run(fullfile(baseDir, "Functions", "Output", "Recording_Signal_Rate.m"));
run(fullfile(baseDir, "Functions", "Output", "Recording_Abundance.m"));
run(fullfile(baseDir, "Functions", "Output", "Recording_Radiogenic_Heat_Power.m"));