addpath(fullfile(baseDir, "Functions", "Computation", "Local-Field"));

% ~~~~~~~~~~~~~~~~~~~~ Parallel Computation ~~~~~~~~~~~~~~~~~~~~ %
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "LITE", "LITE_Generate_Temp_Variables_For_Parallel.m"));
% % ~~~~~~~~~~~~~~~~~~~~ Preallocate ~~~~~~~~~~~~~~~~~~~~ % %
indices = idx;
len = length(indices);
temp_pressure = zeros(len, iteration);
MASS_ROCK = zeros(len, iteration);
MASS_U = zeros(len, iteration);
MASS_TH = zeros(len, iteration);
SIGNAL_U238 = zeros(len, iteration);
SIGNAL_TH232 = zeros(len, iteration);
THICKNESS = zeros(len, iteration);
DEPTH = zeros(len, iteration);
DENSITY = zeros(len, iteration);
ABUNDANCE_U = zeros(len, iteration);
ABUNDANCE_TH = zeros(len, iteration);
% % ~~~~~~~~~~~~~~~~~~~~ 1st layer: s1 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's1';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), 0, depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];
    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index, 3), ...
        abund_K(index, 1), abund_K(index, 2), abund_K(index, 3)};
    [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
        = Get_Geology_Info_From_Global(index, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

% % ~~~~~~~~~~~~~~~~~~~~ 2nd layer: s2 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's2';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), 0, depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index, 3), ...
        abund_K(index, 1), abund_K(index, 2), abund_K(index, 3)};
    [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
        = Get_Geology_Info_From_Global(index, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

% % ~~~~~~~~~~~~~~~~~~~~ 3rd layer: s3 ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 's3';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), 0, depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index, 3), ...
        abund_K(index, 1), abund_K(index, 2), abund_K(index, 3)};
    [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
        = Get_Geology_Info_From_Global(index, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

% % ~~~~~~~~~~~~~~~~~~~~ 4th layer: UC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'UC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), 0, depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];

    cor_array = {cor_thick, cor_vp, cor_abund};
    array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index, 3), ...
        abund_K(index, 1), abund_K(index, 2), abund_K(index, 3)};
    [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
        = Get_Geology_Info_From_Global(index, iteration, name_model, name_layer,...
        PRESSURE(ii1, :), detector, cor_array, ...
        array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
end
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

% % ~~~~~~~~~~~~~~~~~~~~ 5th layer: MC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'MC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), 0, depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];
    if OC(index) == 1
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index, 3), ...
        abund_K(index, 1), abund_K(index, 2), abund_K(index, 3)};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'MC_OC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Huang')
        cor_array = {cor_thick, cor_vp, cor_end};
        array_for_abundance = {crust_vp(index, 1), name_method,...
            felsic_U, felsic_Th, felsic_K,...
            mafic_U, mafic_Th, mafic_K, K_Ratio};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'MC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Bivariate')
        cor_array = {cor_thick, cor_vp, cor_biv_sio2, cor_biv_abund};
        array_for_abundance = {crust_vp(index, 1), name_method,...
            center_vp, am_u, am_th, am_k20, k_k20};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'MC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    end
end
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

% % ~~~~~~~~~~~~~~~~~~~~ 6th layer: LC ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'LC';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), 0, depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];
    if OC(index) == 1
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index, 3), ...
        abund_K(index, 1), abund_K(index, 2), abund_K(index, 3)};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :), PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'LC_OC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Huang')
        cor_array = {cor_thick, cor_vp, cor_end};
        array_for_abundance = {crust_vp(index, 1), name_method,...
            felsic_U, felsic_Th, felsic_K,...
            mafic_U, mafic_Th, mafic_K, K_Ratio};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'LC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    elseif strcmp(name_deepcrust, 'Bivariate')
        cor_array = {cor_thick, cor_vp, cor_biv_sio2, cor_biv_abund};
        array_for_abundance = {crust_vp(index, 1), name_method,...
            center_vp, gr_u, gr_th, gr_k20, k_k20};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'LC_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    end
end
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

% % ~~~~~~~~~~~~~~~~~~~~ 7th layer: LM ~~~~~~~~~~~~~~~~~~~~ % %
name_layer = 'LM';
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "Compute_Temp_Variables.m"));
for ii1 = 1 : len
    index = indices(ii1);
    array_for_radius = [thick(index, 1), moho(index, 1), depth(index, 1), surface_radius(index, 1)];
    array_for_mass = [density(index, 1), lonlat(index, 1), lonlat(index, 2)];
    if OC(index) == 1
        % Return zero results for LC_OC %
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'LM_OC', PRESSURE(ii1, :), detector, 0, 0, 0, 0, array_for_signal);
    else
        cor_array = {cor_thick, cor_vp, cor_abund};
        array_for_abundance = {abund_U(index, 1), abund_U(index, 2), abund_U(index, 3),...
        abund_Th(index, 1), abund_Th(index, 2), abund_Th(index,3),...
        abund_K(index, 1), abund_K(index, 2), abund_K(index,3)};
        [THICKNESS(ii1, :), DEPTH(ii1, :), DENSITY(ii1, :), ABUNDANCE_U(ii1, :), ABUNDANCE_TH(ii1, :),...
        MASS_ROCK(ii1, :), MASS_U(ii1, :), MASS_TH(ii1, :), SIGNAL_U238(ii1, :), SIGNAL_TH232(ii1, :),...
        PRESSURE(ii1, :)] ...
            = Get_Geology_Info_From_Global(index, iteration, name_model, 'LM_CC',...
            PRESSURE(ii1, :), detector, cor_array, ...
            array_for_radius, array_for_mass, array_for_abundance, array_for_signal);
    end
end
clear index indices;
Combination.(name_layer).Thickness = THICKNESS;
Combination.(name_layer).Depth = DEPTH;
Combination.(name_layer).Top_Depth = Combination.(name_layer).Depth - Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Bottom_Depth = Combination.(name_layer).Depth + Combination.(name_layer).Thickness ./ 2;
Combination.(name_layer).Density = DENSITY;
Combination.Global.Mass.(name_layer).Rock = MASS_ROCK;
Combination.Global.Mass.(name_layer).U = MASS_U;
Combination.Global.Mass.(name_layer).U238 = MASS_U .* Physics.Elements.Abundance.Mass.U238;
Combination.Global.Mass.(name_layer).U235 = MASS_U .* Physics.Elements.Abundance.Mass.U235;
Combination.Global.Mass.(name_layer).Th = MASS_TH;

Combination.Global.Geonu_Signal.(name_layer).U238 = sum(SIGNAL_U238, 1);
Combination.Global.Geonu_Signal.(name_layer).Th232 = sum(SIGNAL_TH232, 1);
Combination.Global.Geonu_Signal.(name_layer).Total = Combination.Global.Geonu_Signal.(name_layer).U238 + Combination.Global.Geonu_Signal.(name_layer).Th232;
Combination.(name_layer).Abundance.U = ABUNDANCE_U;
Combination.(name_layer).Abundance.U238 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U238;
Combination.(name_layer).Abundance.U235 = ABUNDANCE_U .* Physics.Elements.Abundance.Mass.U235;
Combination.(name_layer).Abundance.Th = ABUNDANCE_TH;

Combination.Global.Mass.Total.Rock = 0.* Combination.Global.Mass.s1.Rock;
Combination.Global.Mass.Total.U = 0.* Combination.Global.Mass.s1.U;
Combination.Global.Mass.Total.U238 = 0.* Combination.Global.Mass.s1.U238;
Combination.Global.Mass.Total.U235 = 0.* Combination.Global.Mass.s1.U235;
Combination.Global.Mass.Total.Th = 0.* Combination.Global.Mass.s1.Th;

Combination.Global.Geonu_Signal.Total.U238 = 0.* Combination.Global.Geonu_Signal.s1.U238;
Combination.Global.Geonu_Signal.Total.Th232 = 0.* Combination.Global.Geonu_Signal.s1.Th232;
Combination.Global.Geonu_Signal.Total.Total = 0.* Combination.Global.Geonu_Signal.s1.Total;
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    Combination.Global.Mass.Total.Rock = Combination.Global.Mass.Total.Rock + Combination.Global.Mass.(layer).Rock;
    Combination.Global.Mass.Total.U = Combination.Global.Mass.Total.U + Combination.Global.Mass.(layer).U;
    Combination.Global.Mass.Total.U238 = Combination.Global.Mass.Total.U238 + Combination.Global.Mass.(layer).U238;
    Combination.Global.Mass.Total.U235 = Combination.Global.Mass.Total.U235 + Combination.Global.Mass.(layer).U235;
    Combination.Global.Mass.Total.Th = Combination.Global.Mass.Total.Th + Combination.Global.Mass.(layer).Th;

    Combination.Global.Geonu_Signal.Total.U238 = Combination.Global.Geonu_Signal.Total.U238 + Combination.Global.Geonu_Signal.(layer).U238;
    Combination.Global.Geonu_Signal.Total.Th232 = Combination.Global.Geonu_Signal.Total.Th232 + Combination.Global.Geonu_Signal.(layer).Th232;
    Combination.Global.Geonu_Signal.Total.Total = Combination.Global.Geonu_Signal.Total.Total + Combination.Global.Geonu_Signal.(layer).Total;
end
run(fullfile(baseDir, "Functions", "Computation", "Lithosphere", "LITE", "LITE_Clear_Template_Variables.m"));
clear THICKNESS DEPTH DENSITY ABUNDANCE_U ABUNDANCE_TH;