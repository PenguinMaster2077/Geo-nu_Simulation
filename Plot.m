global baseDir;
baseDir = pwd;
addpath(fullfile(baseDir, "Functions", "Plot"));
addpath(fullfile(baseDir, "Functions", "Plot", "GridScan"));
addpath(fullfile(baseDir, "Functions", "Plot", "APPLICATION"));
addpath(fullfile(baseDir, "Functions", "Plot", "SPECTRUM"));
if ~exist(fullfile(baseDir, "Pics"), 'dir')
    mkdir(fullfile(baseDir, "Pics"));
end

% ~~~~~~~~~~~~~~~~~~~~ Plot One Experiment ~~~~~~~~~~~~~~~~~~~~ %
% files = {"./Output/LITE/Hawaii_4000_Crust1_Huang_Enomoto_2025-04-26_19-23-37.mat";...
    % "./Output/LITE/SNO+_4000_Crust1_Huang_Enomoto_4.5_2025-04-16_09-44-43.mat";...
%     "./Output/LITE/SNO+_4000_Crust1_Huang_Yufeng_3.5_2025-04-16_09-54-13.mat";...
%     "./Output/LITE/SNO+_4000_Crust1_Huang_Yufeng_4.5_2025-04-16_09-49-03.mat";...
    % };
files = {"./Output/LITE/SNO+_5_Crust1_Huang_Enomoto_2025-07-07_18-37-02.mat"};
for ii1 = 1 : length(files)
    file = files{ii1};
    Plot_One_Experiment_Signal_Rate(file);
end
% clear files ii1 file;

% ~~~~~~~~~~~~~~~~~~~~ Plot All Experiments ~~~~~~~~~~~~~~~~~~~~ %
% Items = {"SNO+", "./Output/SNO+_4000_Crust1_Huang_2025-03-24_16-48-00.mat";...
%     "KamLAND", "./Output/KamLAND_4000_Crust1_Huang_2025-03-24_16-53-06.mat";...
%     "Borexino", "./Output/Borexino_4000_Crust1_Huang_2025-03-24_16-57-32.mat";...
%     "JUNO", "./Output/JUNO_4000_Crust1_Huang_2025-03-24_17-01-56.mat";...
%     "JNE", "./Output/JNE_4000_Crust1_Huang_2025-03-24_17-06-30.mat"};
% 
% Plot_All_Experiments(Items);

% ~~~~~~~~~~~~~~~~~~~~ Grid Scan ~~~~~~~~~~~~~~~~~~~~ %
% best_file_path = "./Output/GridScan/SNO+_4000_Crust1_Huang_7.41e-05_0.303_2025-03-28_17-08-34.mat";
% data_dir = "./Output/GridScan";
% out_pic_path = "./Pics/GRIDSCAN/Grid Scan Geonu Signal V2.jpg";
% GRIDSCAN_Final_Plot(data_dir, best_file_path, out_pic_path);

% ~~~~~~~~~~~~~~~~~~~~ Heat Power ~~~~~~~~~~~~~~~~~~~~ %
% file_path = "./Output/ADVANCE/SNO+_4000_Crust1_Huang_2025-04-10_17-12-46.mat";
% Plot_One_Experiment_Heat_Power(file_path);
% Plot_One_Experiment_Signal(file_path);

% ~~~~~~~~~~~~~~~~~~~~ Signal Rate vs Distance ~~~~~~~~~~~~~~~~~~~~ %
% file_path = "./Output/APPLICATION/Fluxes_Distance_SNO+_100_Crust1_Huang_2025-04-14_11-27-41.mat";
% index = 80;
% Plot_Signal_Rate_Distance(index, file_path);

% ~~~~~~~~~~~~~~~~~~~~ Two Spectra ~~~~~~~~~~~~~~~~~~~~ %
% yufeng_path = "./Output/LITE/SNO+_4000_Crust1_Huang_Yufeng_4.5_2025-04-17_20-42-43.mat";
% enomoto_path = "./Output/LITE/SNO+_4000_Crust1_Huang_Enomoto_4.5_2025-04-18_15-41-06.mat";
% yufeng_path = "./Output/LITE/SNO+_4000_Crust1_Huang_Yufeng_3.5_2025-04-17_18-37-59.mat";
% enomoto_path = "./Output/LITE/SNO+_4000_Crust1_Huang_Enomoto_3.5_2025-04-18_15-45-47.mat";
% APPLICATION_Plot_Two_Signal_Rate_Distribution(yufeng_path, enomoto_path);

