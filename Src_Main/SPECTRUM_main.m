% % ~~~~~~~~~~~~~~~~~~~~ Parallel Pool ~~~~~~~~~~~~~~~~~~~~ % %
% myCluster = parcluster('local'); % Specify the local cluster
% delete(myCluster.Jobs);          % Delete existing jobs
% delete(gcp('nocreate'));         % Delete existing parallel pool if any
% parpool('local', 5);             % Create a new parallel pool with 5 workers

% ~~~~~~~~~~~~~~~~~~~~ Parallel Computation ~~~~~~~~~~~~~~~~~~~~ %
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Generate_Temp_Variables_For_Parallel.m"));
% % ~~~~~~~~~~~~~~~~~~~~ Preallocate ~~~~~~~~~~~~~~~~~~~~ % %
temp_pressure = zeros(len, iteration);
MASS_ROCK = zeros(len, iteration);
MASS_U = zeros(len, iteration);
MASS_TH = zeros(len, iteration);
len_energy = length(Physics.Cross_Section.Energy);
SPECTRUM_U = zeros(iteration, len_energy);
SPECTRUM_TH = zeros(iteration, len_energy);
temp_spectrum_u = zeros(iteration, len_energy);
temp_spectrum_th = zeros(iteration, len_energy);
% % ~~~~~~~~~~~~~~~~~~~~ 1st layer: s1 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's1';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end

    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)] ...
        = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 2nd layer: s2 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's2';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end

    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
        = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);

    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 3rd layer: s3 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's3';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end

    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
        = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);

    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 4th layer: UC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'UC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end

    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
    [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
        = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);

    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 5th layer: MC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'MC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end

    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    if OC(ii1) == 1
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'MC_OC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    elseif strcmp(name_deepcrust, 'Huang')
        cor_array = {cor_thick, cor_vp, cor_end};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            felsic_U, felsic_Th, felsic_K,...
            mafic_U, mafic_Th, mafic_K, K_Ratio};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'MC_CC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    elseif strcmp(name_deepcrust, 'Bivariate')
        cor_array = {cor_thick, cor_vp, cor_biv_sio2, cor_biv_abund};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            center_vp, am_u, am_th, am_k20, k_k20};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'MC_CC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    end

    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 6th layer: LC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'LC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end
    
    array_for_radius = [thick(ii1, 1), 0, depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    if OC(ii1) == 1
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1, 3), ...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1, 3)};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)] ...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LC_OC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    elseif strcmp(name_deepcrust, 'Huang')
        cor_array = {cor_thick, cor_vp, cor_end};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            felsic_U, felsic_Th, felsic_K,...
            mafic_U, mafic_Th, mafic_K, K_Ratio};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LC_CC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    elseif strcmp(name_deepcrust, 'Bivariate')
        cor_array = {cor_thick, cor_vp, cor_biv_sio2, cor_biv_abund};
        array_for_abundance = {crust_vp(ii1, 1), name_method,...
            center_vp, gr_u, gr_th, gr_k20, k_k20};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LC_CC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    end

    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));

% % ~~~~~~~~~~~~~~~~~~~~ 7th layer: LM ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'LM';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("%s: %d / %d (%.2f%%)\n",name_layer, ii1, len, 100 * ii1 / len);
    end

    array_for_radius = [thick(ii1, 1), moho(ii1, 1), depth(ii1, 1), surface_radius(ii1, 1)];
    array_for_mass = [density(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2)];

    if OC(ii1) == 1
        % Return zero results for LC_OC %
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LM_OC', PRESSURE(ii1, :), 0, 0, 0, 0, detector, array_for_signal);
    else
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(ii1, 1), abund_U(ii1, 2), abund_U(ii1, 3),...
        abund_Th(ii1, 1), abund_Th(ii1, 2), abund_Th(ii1,3),...
        abund_K(ii1, 1), abund_K(ii1, 2), abund_K(ii1,3)};
        [MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), temp_spectrum_u, temp_spectrum_th, PRESSURE(ii1, :)]...
            = SPECTRUM_Compute_Lithosphere_Cell(ii1, iteration, name_model, 'LM_CC',...
            PRESSURE(ii1, :), cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, detector, array_for_signal);
    end

    SPECTRUM_U = SPECTRUM_U + temp_spectrum_u;
    SPECTRUM_TH = SPECTRUM_TH + temp_spectrum_th;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Lithsophere_Results.m"));
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "SPECTRUM", "SPECTRUM_Clear_Template_Variables.m"));

% ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ %  %
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "Compute_Mantle_Variables.m"));
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "Generate_Temp_Variables_For_Parallel.m"));

len = length(lonlat(:, 1));
SPECTRUM_U_DM = zeros(iteration, len_energy);
SPECTRUM_TH_DM = zeros(iteration, len_energy);
SPECTRUM_U_EM = zeros(iteration, len_energy);
SPECTRUM_TH_EM = zeros(iteration, len_energy);
temp_spectrum_u_dm = zeros(iteration, len_energy);
temp_spectrum_th_dm = zeros(iteration, len_energy);
temp_spectrum_u_em = zeros(iteration, len_energy);
temp_spectrum_th_em = zeros(iteration, len_energy);
for ii1 = 1 : length(lonlat(:, 1))
    if mod(ii1, 5000) == 0 || ii1 == len
        fprintf("Mantle: %d / %d (%.2f%%)\n", ii1, len, 100 * ii1 / len);
    end

    array_for_mass = {LAB(ii1, 1), lonlat(ii1, 1), lonlat(ii1, 2), surface_radius(ii1, 1), PREM};

    [temp_spectrum_u_dm, temp_spectrum_th_dm, temp_spectrum_u_em, temp_spectrum_th_em]...
        = SPECTRUM_Compute_Mantle_Cell(ii1, array_for_mass, array_for_abundance, array_for_signal, detector);

    SPECTRUM_U_DM = SPECTRUM_U_DM + temp_spectrum_u_dm;
    SPECTRUM_TH_DM = SPECTRUM_TH_DM + temp_spectrum_th_dm;
    SPECTRUM_U_EM = SPECTRUM_U_EM + temp_spectrum_u_em;
    SPECTRUM_TH_EM = SPECTRUM_TH_EM + temp_spectrum_th_em;
end
run(fullfile(baseDir, "Functions", "Output", "SPECTRUM", "SPECTRUM_Record_Mantle_Results.m"));
run(fullfile(baseDir, "Functions", "Computation", "Mantle", "SPECTRUM", "SPECTRUM_Clear_Template_Variables.m"));

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
% % Get the current timestamp % %
timestamp = datestr(now, 'yyyy-mm-dd_HH-MM-SS'); % Format: 2024-03-19_14-30-45 %
name_detector = Physics.Detector.Name;
name_lith = Geology.Lithosphere.Model.Name;
name_deep = Geology.Lithosphere.Model.Method.Deep_Crust;
name_spectrum = Physics.Elements.Spectrum.Method;
iteration_str = num2str(iteration);
filename_base = sprintf('%s_%s_%s_%s_%s_%s.mat', name_detector, iteration_str, name_lith, name_deep, name_spectrum, timestamp);
filename = fullfile(baseDir, 'Output', 'SPECTRUM', filename_base);  
save(filename, 'Geology', 'Physics', 'Output', '-v7.3');
clear name_detector name_lith name_detector name_spectrum iteration_str;
clear name_deep iteration filename timestamp;