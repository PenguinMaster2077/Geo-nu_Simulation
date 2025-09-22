version = Plot.Version;
% ---------- Global Computation ----- %
if strcmp('GLOBAL', version) == 1
    file_path = fullfile(baseDir, "Output",Plot.Global_Version, file_name);
    pic_dir = fullfile(baseDir, "Pics", Plot.Global_Version);
    % ~~~~~ Signal Rate Distribution ~~~~~ %
    if Plot.Signal
        Plot_One_Experiment_Signal(file_path, pic_dir);
    end
    % ~~~~~ Radiogenic Heat Power ~~~~~ %
    if Plot.Heat
        Plot_One_Experiment_Heat_Power(file_path, pic_dir);
    end
    % ~~~~~ Clear Variables ~~~~~ %
    clear file_path pic_dir;

% ---------- Local Computation ---------- %
elseif strcmp('LOCAL', version) == 1
    pic_dir = fullfile(baseDir, "Pics");
    load(crust_file_path);
    load(file_path);
    run(fullfile(baseDir, "Scripts", "Plot_Perform_MC_Sampling.m"));
end

% ---------- Clear Variables ---------- %
clear version;