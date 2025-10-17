version = Plot.Compute_Version;
% ---------- Global Computation ----- %
if strcmp('GLOBAL', version) == 1
    file_path = fullfile(baseDir, "Output",Plot.Code_Version, file_name);
    pic_dir = fullfile(baseDir, "Pics", Plot.Code_Version);
    % ~~~~~ Signal Rate Distribution ~~~~~ %
    if Plot.Signal
        Plot_One_Experiment_Signal_Rate(file_path, pic_dir, Plot);
    end
    % ~~~~~ Radiogenic Heat Power ~~~~~ %
    if Plot.Heat
        Plot_One_Experiment_Heat_Power(file_path, pic_dir, Plot);
    end
    % ~~~~~ Clear Variables ~~~~~ %
    clear file_path pic_dir;

% ---------- Local Computation ---------- %
elseif strcmp('LOCAL', version) == 1
    pic_dir = fullfile(baseDir, "Pics");
    fprintf('Loading Crust Info: %s\n', crust_file_path);
    load(crust_file_path);
    fprintf('Loading GP Info: %s\n', file_path);
    load(file_path);
    fprintf('Performing MC Sampling\n');
    run(fullfile(baseDir, "Scripts", "Plot_Perform_MC_Sampling.m"));
end

% ---------- Analysis: Two Spectra ---------- %
if strcmp('TWO_SPECTRA', Plot.Analysis)
    pic_dir = fullfile(baseDir, "Pics");
    Plot_Two_Spectra(LiXin_path, Enomoto_path, pic_dir, Plot);
    clear pic_dir;
end

% ---------- Clear Variables ---------- %
clear version;