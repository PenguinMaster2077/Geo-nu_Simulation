% ---------- Random Seed ---------- %
rng(Geology.Random_Seed);

% ---------- Find the indices in Global ---------- %
fprintf('[Combination] Start to process combination ...\n')
unique_lon = sort(unique(Crust(:, 1)));
unique_lat = sort(unique(Crust(:, 2)));
global_lonlat = Geology.Lithosphere.Model.GeoPhys.lonlat;
lat_min = min(unique_lat);
lat_max = max(unique_lat);
lon_min = min(unique_lon);
lon_max = max(unique_lon);
half_dlon = 0.5;
half_dlat = 0.5;
idx = find( (global_lonlat(:,1) + half_dlon) >= lon_min & ...
            (global_lonlat(:,1) - half_dlon) <= lon_max & ...
            (global_lonlat(:,2) + half_dlat) >= lat_min & ...
            (global_lonlat(:,2) - half_dlat) <= lat_max );
clear unique_lon unique_lat lat_min lat_max lon_min lon_max;

% ---------- Create Data Structure for Combination Computation ---------- %
iteration = Geology.Iteration;
len = length(idx);
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
len_layers = length(layers);
template = zeros(len, iteration);
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    Combination.(layer).Thickness = template;
    Combination.(layer).Density = template;
    Combination.(layer).Abundance.U = template;
    Combination.(layer).Abundance.Th = template;
    Combination.(layer).Depth = template;
end
clear template ii1;
Combination.Lonlat = global_lonlat(idx, :);
Combination.Index = idx;
clear ii1 layer;
clear global_lonlat;

% ---------- Fill Combination Strcture ---------- %
run(fullfile(baseDir, "Src_Main", "Get_Near_Field_Geology_Info_From_Global.m"));

% ---------- Compute Signal Rate ---------- %
GP_U238 = Local_Res.Result.GP.U238;
GP_Th232 = Local_Res.Result.GP.Th232;
Volumes = Local_Res.Result.Volume;
MASS_ROCK = zeros(len_layers, iteration);
MASS_U = zeros(len_layers, iteration);
MASS_U238 = zeros(len_layers, iteration);
MASS_U235 = zeros(len_layers, iteration);
MASS_TH = zeros(len_layers, iteration);
SIGNAL_U238 = zeros(len_layers, iteration);
SIGNAL_TH232 = zeros(len_layers, iteration);
for iBulk = 1 : length(idx)
    fprintf('[Combination] Processing Bulk #%d / %d\n', iBulk, length(idx));
    LON = Combination.Lonlat(iBulk, 1);
    LAT = Combination.Lonlat(iBulk, 2);
    inBox = Crust(:, 1) >= (LON - 0.5) & Crust(:, 1) <= (LON + 0.5) & Crust(:, 2) >= (LAT - 0.5) & Crust(:, 2) <= (LAT + 0.5);
    matched_indices = find(inBox);
    matched_cells = Crust(matched_indices, :);
    unique_depth = sort(-unique(matched_cells(:, 3)))'; % Depth table for grids, 1 * NCells %
    len_grid_depth = length(unique_depth);
    volumes = zeros(len_grid_depth, 1); % NCells * 1 %
    gp_factor_u238 = zeros(len_grid_depth, 1);
    gp_factor_th232 = zeros(len_grid_depth, 1);
    clear LON LAT inBox;
    
    % ----- Add up GP Factor by Depth ----% %
    for iDepth = 1 : len_grid_depth
        same_depth = matched_cells(:, 3) == -unique_depth(iDepth);
        idx_same_depth = matched_indices(same_depth);
        volumes(iDepth) = sum(Volumes(idx_same_depth));
        gp_factor_u238(iDepth) = sum(GP_U238(idx_same_depth));
        gp_factor_th232(iDepth) = sum(GP_Th232(idx_same_depth));
    end
    clear iDepth len_grid_depth same_depth idx_same_depth;

    % ----- Generate Depth, Densith, and Abundance Table ---- %
    % All in form of Iteration * Layer %
    for iLayer = 1 : len_layers
        layer = layers{iLayer};
        Bottom_Depth_Table(iLayer, :) = Combination.(layer).Bottom_Depth(iBulk, :); 
        Density_Table(iLayer, :) = Combination.(layer).Density(iBulk, :);
        Abundance_U_Table(iLayer, :) = Combination.(layer).Abundance.U(iBulk, :);
        Abundance_U238_Table(iLayer, :) = Combination.(layer).Abundance.U238(iBulk, :);
        Abundance_U235_Table(iLayer, :) = Combination.(layer).Abundance.U235(iBulk, :);
        Abundance_Th_Table(iLayer, :) = Combination.(layer).Abundance.Th(iBulk, :);
    end
    clear iLayer;

    % ----- Compute Signal Rate ----- %
    for iLayer = 1 : len_layers
        if iLayer == 1
            mask = unique_depth' <= Bottom_Depth_Table(iLayer, :); % NCells * Iteration %
        else
            mask = (unique_depth' > Bottom_Depth_Table(iLayer - 1, :)) & ...
               (unique_depth' <= Bottom_Depth_Table(iLayer, :));
        end
        mass_rock = sum(mask .* volumes, 1) .* Density_Table(iLayer, :);
        mass_u = sum(mask .* volumes, 1) .* Abundance_U_Table(iLayer, :) .* Density_Table(iLayer, :);
        mass_u238 = sum(mask .* volumes, 1) .* Abundance_U238_Table(iLayer, :) .* Density_Table(iLayer, :);
        mass_u235 = sum(mask .* volumes, 1) .* Abundance_U235_Table(iLayer, :) .* Density_Table(iLayer, :);
        mass_th = sum(mask .* volumes, 1) .* Abundance_Th_Table(iLayer, :) .* Density_Table(iLayer, :);
        layer_signal_u238 =  sum(mask .* gp_factor_u238, 1) .* Abundance_U238_Table(iLayer, :) .* Density_Table(iLayer, :);
        layer_signal_th232 = sum(mask .* gp_factor_th232, 1) .* Abundance_Th_Table(iLayer, :) .* Density_Table(iLayer, :);
        
        MASS_ROCK(iLayer, :) = MASS_ROCK(iLayer, :) + mass_rock;
        MASS_U(iLayer, :) = MASS_U(iLayer, :) + mass_u;
        MASS_U238(iLayer, :) = MASS_U238(iLayer, :) + mass_u238;
        MASS_U235(iLayer, :) = MASS_U235(iLayer, :) + mass_u235;
        MASS_TH(iLayer, :) = MASS_TH(iLayer, :) + mass_th;

        SIGNAL_U238(iLayer, :) = SIGNAL_U238(iLayer, :) + layer_signal_u238;
        SIGNAL_TH232(iLayer, :) = SIGNAL_TH232(iLayer, :) + layer_signal_th232;
    end
    clear iLayer mask layer_signal_u238 layer_signal_th232;

end
clear iBulk match matched_indices matched_cells unique_depth len_grid_depth volumes gp_factor_u238 gp_factor_th232;
clear Bottom_Depth_Table Density_Table Abundance_U_Table Abundance_U238_Table Abundance_U235_Table Abundance_Th_Table;
clear mask mass_rock mass_u mass_u238 mass_u235 mass_th layer_signal_u238 layer_signal_th232;
clear GP_U238 GP_Th232 Volumes;
clear layer layers;
clear len len_layers iteration;
clear idx;

% ---------- Recording ---------- %
fprintf('[Combination] Recording mass ...\n');
Combination.Mass.Rock = MASS_ROCK;
Combination.Mass.U = MASS_U;
Combination.Mass.U238 = MASS_U238;
Combination.Mass.U235 = MASS_U235;
Combination.Mass.Th = MASS_TH;
clear MASS_ROCK MASS_U MASS_U238 MASS_U235 MASS_TH;

fprintf('[Combination] Recording signal rate ...\n');
Combination.Geonu_Signal.U238 = SIGNAL_U238;
Combination.Geonu_Signal.Th232 = SIGNAL_TH232;
Combination.Geonu_Signal.Total_Each_Layer = SIGNAL_U238 + SIGNAL_TH232;
Combination.Geonu_Signal.Total = sum(SIGNAL_U238 + SIGNAL_TH232, 1);
clear SIGNAL_U238 SIGNAL_TH232;

fprintf('[Combination] Recording radiogenic heat power ...\n');
Combination.Heat_Power.U = Combination.Mass.U .* Physics.Elements.Heat_Power.U;
Combination.Heat_Power.U238 = Combination.Mass.U .* Physics.Elements.Heat_Power.U238;
Combination.Heat_Power.U235 = Combination.Mass.U .* Physics.Elements.Heat_Power.U235;
Combination.Heat_Power.Th = Combination.Mass.Th .* Physics.Elements.Heat_Power.Th232;
Combination.Heat_Power.Total_Each_Layer = Combination.Heat_Power.U + Combination.Heat_Power.Th;
Combination.Heat_Power.Total = sum(Combination.Heat_Power.U + Combination.Heat_Power.Th, 1);

Combination.Run_Info.Global = global_path;
Combination.Run_Info.Local = local_crust_path;
if exist('local_gp_path', 'var') && ~isempty(local_gp_path)
    Combination.Run_Info.Local_GP = local_gp_path;
end
if exist('local_res_path', 'var') && ~isempty(local_res_path)
    Combination.Run_Info.Local_Res = local_res_path;
end