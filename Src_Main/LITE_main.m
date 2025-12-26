% ~~~~~~~~~~~~~~~~~~~~ Parallel Pool ~~~~~~~~~~~~~~~~~~~~ %
myCluster = parcluster('local'); % Specify the local cluster
delete(myCluster.Jobs);          % Delete existing jobs
delete(gcp('nocreate'));         % Delete existing parallel pool if any
parpool('local', 5);             % Create a new parallel pool with 5 workers

% ~~~~~~~~~~~~~~~~~~~~ Parallel Computation ~~~~~~~~~~~~~~~~~~~~ %
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "LITE", "LITE_Generate_Temp_Variables_For_Parallel.m"));
% % ~~~~~~~~~~~~~~~~~~~~ Preallocate ~~~~~~~~~~~~~~~~~~~~ % %
temp_pressure = zeros(len, iteration);
MASS_ROCK = zeros(len, iteration);
MASS_U = zeros(len, iteration);
MASS_TH = zeros(len, iteration);
SIGNAL_U = zeros(len, iteration);
SIGNAL_TH = zeros(len, iteration);
% % ~~~~~~~~~~~~~~~~~~~~ 1st layer: s1 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's1';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];
    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)] ...
        = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 2nd layer: s2 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's2';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
        = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 3rd layer: s3 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's3';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
        = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 4th layer: UC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'UC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
        = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 5th layer: MC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'MC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];
    if OC(ii1) == 1
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'MC_OC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Huang')
        cor_array = {cor_thick, cor_vp, cor_end};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            felsic_U, felsic_Th, felsic_K,...
            mafic_U, mafic_Th, mafic_K, K_Ratio};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'MC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Bivariate')
        cor_array = {cor_thick, cor_vp, cor_biv_sio2, cor_biv_abund};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            center_vp, am_u, am_th, am_k20, k_k20};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'MC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    end
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 6th layer: LC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'LC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];
    if OC(ii1) == 1
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)] ...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LC_OC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Huang')
        cor_array = {cor_thick, cor_vp, cor_end};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            felsic_U, felsic_Th, felsic_K,...
            mafic_U, mafic_Th, mafic_K, K_Ratio};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Bivariate')
        cor_array = {cor_thick, cor_vp, cor_biv_sio2, cor_biv_abund};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            center_vp, gr_u, gr_th, gr_k20, k_k20};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    end
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 7th layer: LM ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'LM';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
parfor ii1 = 1 : len
    array_for_radius = [thick(ii1, 1), moho(ii1, 1), depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];
    if OC(ii1) == 1
        % Return zero results for LC_OC %
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LM_OC', PRESSURE(ii1, :), detector, 0, 0, 0, 0, array_for_signal);
    else
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1,3),...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1,3)};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U(ii1, :), SIGNAL_TH(ii1, :), PRESSURE(ii1, :)]...
            = LITE_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LM_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    end
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Lithsophere_Results.m"));
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "LITE", "LITE_Clear_Template_Variables.m"));

% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ % %
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "Compute_Mantle_Variables.m"));
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "LITE", "LITE_Generate_Temp_Variables_For_Parallel.m"));
len = length(lonlat(:, 1));
MASS_U_DM = zeros(len, iteration);
MASS_TH_DM = zeros(len, iteration);
MASS_U_EM = zeros(len, iteration);
MASS_TH_EM = zeros(len, iteration);
SIGNAL_U_DM = zeros(len, iteration);
SIGNAL_TH_DM = zeros(len, iteration);
SIGNAL_U_EM = zeros(len, iteration);
SIGNAL_TH_EM = zeros(len, iteration);
parfor ii1 = 1 : length(lonlat(:, 1))
    array_for_mass = {LAB(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2), surface_radius(ii1, 1), PREM};
    [MASS_U_DM(ii1, :), MASS_TH_DM(ii1, :), ...
        MASS_U_EM(ii1, :), MASS_TH_EM(ii1, :),...
        SIGNAL_U_DM(ii1, :), SIGNAL_TH_DM(ii1, :),...
        SIGNAL_U_EM(ii1, :), SIGNAL_TH_EM(ii1, :)]...
        = LITE_Compute_Mantle_Cell(ii1, detector, array_for_mass, array_for_abundance, array_for_signal);
end
run(fullfile(baseDir, "Functions", "Output", "LITE", "LITE_Record_Mantle_Results.m"));
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "LITE", "LITE_Clear_Template_Variables.m"));

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
% Get the current timestamp % %
timestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS'); % Format：2024-03-19_14-30-45 %
name_detector = Physics.Detector.Name;
name_lith = Geology.Lithosphere.Model.Name;
name_deep = Geology.Lithosphere.Model.Method.Deep_Crust;
name_spectrum = Physics.Elements.Spectrum.Method;
name_ibd = Physics.Cross_Section.Model;
iteration_str = num2str(iteration);
filename_base = sprintf('%s_%s_%s_%s_%s_%s_%s.mat', ...
    name_detector, iteration_str, name_lith, name_deep, name_ibd, name_spectrum, timestamp);
filename = fullfile(baseDir, 'Output', 'LITE', filename_base);    % Generate filename
save(filename, 'Geology', 'Physics', 'Output');
clear name_detector name_lith name_detector iteration_str name_spectrum;
clear name_deep iteration filename timestamp;