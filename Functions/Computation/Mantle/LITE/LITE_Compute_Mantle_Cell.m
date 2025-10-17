function [MASS_U_DM, MASS_TH_DM, MASS_U_EM, MASS_TH_EM, SIGNAL_U_DM, SIGNAL_TH_DM, SIGNAL_U_EM, SIGNAL_TH_EM] = LITE_Compute_Mantle_Cell(index, detector, array_for_mass, array_for_abundance, array_for_signal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : LITE_Compute_Mantle_Cell.m
% Description     : Compute interests
%
% Original Author : mantleGeo() by old GEONU
% Modified by     : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Modified
%
% Input Parameters:
%   - index                 : Index of the grid cell
%   - detector              : Informaiton of the detector
%   - cor_array             : Structure of correlation coefficients
%   - array_for_radius      : Variables used for radius calculation
%   - array_for_mass        : Variables used for mass calculation
%   - array_for_abudance    : Variables used for abudance calculation
%   - array_for_signal      : Variables used for signal rate calculation
%
% Output Parameters:
%   - MASS_U_DM     (kg)                : Mass of uranium in DM
%   - MASS_TH_DM    (kg)                : Mass of thorium in DM
%   - MASS_U_EM     (kg)                : Mass of uranium in EM
%   - MASS_TH_EM    (kg)                : Mass of thorium in EM
%   - SIGNAL_U_DM   (TNU)               : Signal rate from uranium in DM
%   - SIGNAL_TH_DM  (TNU)               : Signal rate from thorium in DM
%   - SIGNAL_U_EM   (TNU)               : Signal rate from uranium in EM
%   - SIGNAL_TH_EM  (TNU)               : Signal rate from thorium in EM
%
% Physical Units:
%   - radius        : m
%   - mass          : kg
%   - abundance     : g/g
%   - thickness     : m
%   - depth         : m
%   - DENSITY       : kg/m^3
%
% Created On      : 2025-03-19
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~ Depth of all 1 km Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
LAB = array_for_mass{1};
CMB_depth = 2891 * 1e3; % Unit: m, Core-Mantle Boundary (CMB) %
layers_depth = LAB + 500 : 1000 : (CMB_depth - 500); % Unit: m, center of each layer %
layers_depth = layers_depth'; % Column vector $
clear CMB_depth;

% ~~~~~~~~~~~~~~ Mass of all 1 km Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass{2};
lat_center = array_for_mass{3};
surface_radius = array_for_mass{4};
PREM = array_for_mass{5};
for ii2 = 1 : length(layers_depth)
    volume = Compute_Cell_Volume(lon_center - 0.5, lon_center + 0.5, lat_center - 0.5, lat_center + 0.5,...
        surface_radius - layers_depth(ii2, 1) - 500, surface_radius - layers_depth(ii2, 1) + 500); % Unit: m^3 %
    index_density = round(layers_depth(ii2, 1) / 1000 + 0.5);
    density = PREM(index_density, 3); % Unit: kg/m^3 %
    layers_mass(ii2, :) = volume .* density;
end
clear lon_center lat_center surface_radius PREM volume index_density density;

% ~~~~~~~~~~~~~~ Thickness of Large Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
thick_mantle = layers_depth(end) + 500 - LAB; % Unit: m, Thickness of all mantle %
THICK_LARGE_LAYERS = [50, 100, 150, 250, 400, 400, 400, 0]; % Unit: km %
THICK_LARGE_LAYERS(end + 1) = 750; % Enriched mantle thickness
THICK_LARGE_LAYERS(end - 1) = thick_mantle/1000 - sum(THICK_LARGE_LAYERS);
THICK_LARGE_LAYERS = THICK_LARGE_LAYERS .* 1000; % Unit: m %
THICK_LARGE_LAYERS = THICK_LARGE_LAYERS'; % Column vector %
clear thick_mantle layers_depth;
% thick records the thickness of all large layers; thick(1: end -1) belong to DM, and thick(end) is EM

% ~~~~~~~~~~~~~~ Depth of Large Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
DEPTH_LARGE_LAYERS = 0 .* THICK_LARGE_LAYERS; % Unit: m; Column vector %
DEPTH_LARGE_LAYERS(1, 1) = THICK_LARGE_LAYERS(1, 1) / 2 + LAB;
for ii2 = 2 : length(THICK_LARGE_LAYERS)
    DEPTH_LARGE_LAYERS(ii2, 1) = THICK_LARGE_LAYERS(ii2, 1)/2 + DEPTH_LARGE_LAYERS(ii2 -1 , 1) + THICK_LARGE_LAYERS(ii2 - 1, 1)/2;
end
clear LAB;

% ~~~~~~~~~~~~~~ Mass of Large Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
temp_index = 1;
MASS_LARGE_LAYERS = 0 .* THICK_LARGE_LAYERS; % Unit: kg; Column vector %
for ii2 = 1 : length(THICK_LARGE_LAYERS)
    MASS_LARGE_LAYERS(ii2, 1) = sum(layers_mass(temp_index : temp_index + THICK_LARGE_LAYERS(ii2)/1000 - 1));
    temp_index = temp_index + THICK_LARGE_LAYERS(ii2)/1000;
end
clear temp_index layers_mass;

% ~~~~~~~~~~~~~~ Geonu Signal of Large Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass{2};
lat_center = array_for_mass{3};
surface_radius = array_for_mass{4};
PREM = array_for_mass{5};

sig_response_u238 = array_for_signal{1};
sig_response_th232 = array_for_signal{2};
energy = array_for_signal{3};
p1 = array_for_signal{4};
p2 = array_for_signal{5};
p3 = array_for_signal{6};
m21 = array_for_signal{7};
m31 = array_for_signal{8};
m32 = array_for_signal{9};

subcell_sizes = [4000, 15000, 25000, 40000, 60000]; % Unit: m %
subcell_limits = [100000,160000,280000,600000,1000000]; % Unit: m %
len = length(THICK_LARGE_LAYERS);
geonu_signal_factor_u238 = zeros(len, 1);
geonu_signal_factor_th232 = zeros(len, 1);
for ii2 = 1 : length(THICK_LARGE_LAYERS)
    distance = Compute_Distance(lon_center, lat_center, surface_radius, DEPTH_LARGE_LAYERS(ii2), detector);

    if distance > subcell_limits(5)
        part1 = 1 + p1 .* sin(1.27 * m21 .* bsxfun(@rdivide, distance, energy')) .^2 ; % 1 * Energy %
        part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
        part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
        Pee = part1 + part2 + part3;
        sig_factor_u238 = sum(MASS_LARGE_LAYERS(ii2, 1) .* (sig_response_u238 .* Pee')', 2); % 1 * 1 %
        sig_factor_th232 = sum(MASS_LARGE_LAYERS(ii2, 1) .* (sig_response_th232 .* Pee')', 2); % 1 * 1 %
        unit_geonu_sig_factor_u238 = sig_factor_u238 ./ (distance .^ 2); % 1 * 1 %
        unit_geonu_sig_factor_th232 = sig_factor_th232 ./ (distance .^2); % 1 * 1 %
        geonu_signal_factor_u238(ii2, 1) = sum(unit_geonu_sig_factor_u238, 1);
        geonu_signal_factor_th232(ii2, 1) =  sum(unit_geonu_sig_factor_th232, 1);
    else
        if distance <= subcell_limits(1)
            subcell_size = subcell_sizes(1);
        elseif distance > subcell_limits(1) && distance <= subcell_limits(2)
            subcell_size = subcell_sizes(2);
        elseif distance > subcell_limits(2) && distance <= subcell_limits(3)
            subcell_size = subcell_sizes(3);
        elseif distance > subcell_limits(3) && distance <= subcell_limits(4)
            subcell_size = subcell_sizes(4);
        elseif distance > subcell_limits(4) && distance <= subcell_limits(5)
            subcell_size = subcell_sizes(5);
        end % end : subcell_size %
% % Split Cell % %
        [sub_lons, sub_lats, sub_depths, lon_sub_interval, lat_sub_interval, thick_sub_interval]...
            = Split_Cell(lon_center, lat_center, DEPTH_LARGE_LAYERS(ii2, 1), 1, 1, THICK_LARGE_LAYERS(ii2, 1), subcell_size, surface_radius);
        sub_volumes = Compute_Cell_Volume(sub_lons - lon_sub_interval/2, sub_lons + lon_sub_interval/2, ...
            sub_lats - lat_sub_interval/2, sub_lats + lat_sub_interval/2, ...
            surface_radius - sub_depths - thick_sub_interval/2, surface_radius - sub_depths + thick_sub_interval/2);
        % Subcell * 1 %
        sub_distances = Compute_Distance(sub_lons, sub_lats, surface_radius, sub_depths, detector);
        % Subcell * 1 %
        for ii3 = 1 : length(sub_lons)
            sub_distance = sub_distances(ii3, 1);
            part1 = 1 + p1 .* sin(1.27 .* m21 .* bsxfun(@rdivide, sub_distance, energy')) .^ 2; % 1 * Energy %
            part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, sub_distance, energy')) .^2; % 1 * Energy %
            part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, sub_distance, energy')) .^2; % 1 * Energy %
            Pee = part1 + part2 + part3;
            density = PREM(round(sub_depths(ii3, 1)/1000), 3); % Unit: kg/m^3
            sig_factor_u238 = sum(density .* sub_volumes(ii3, 1) .* (sig_response_u238 .* Pee')', 2); % 1 * 1 %
            sig_factor_th232 = sum(density .* sub_volumes(ii3, 1) .* (sig_response_th232 .* Pee')', 2); % 1 * 1 %
            unit_geonu_sig_factor_u238 = sig_factor_u238 ./ (sub_distance .^ 2); % 1 * 1 %
            unit_geonu_sig_factor_th232 = sig_factor_th232 ./ (sub_distance .^ 2); % 1 * 1 %
            geonu_signal_factor_u238(ii2, 1) = geonu_signal_factor_u238(ii2, 1) + unit_geonu_sig_factor_u238; % 1 * 1 %
            geonu_signal_factor_th232(ii2, 1) = geonu_signal_factor_th232(ii2, 1) + unit_geonu_sig_factor_th232; % 1 * 1 %
        end
    end
end
dm_au = array_for_abundance{1}; % Iteration * 1 %
dm_ath = array_for_abundance{2}; % Iteration * 1 %
em_au = array_for_abundance{3}; % Iteration * 1 %
em_ath = array_for_abundance{4}; % Iteration * 1 %

% % MASS % %
MASS_U_DM = (dm_au .* sum(MASS_LARGE_LAYERS(1: end - 1, 1), 1))';
MASS_TH_DM = (dm_ath .* sum(MASS_LARGE_LAYERS(1: end - 1, 1), 1))';
MASS_U_EM = (em_au   .* sum(MASS_LARGE_LAYERS(end, 1), 1))';
MASS_TH_EM = (em_ath   .* sum(MASS_LARGE_LAYERS(end, 1), 1))';

% % SIGNAL % %
SIGNAL_U_DM = sum(bsxfun(@times, dm_au, geonu_signal_factor_u238(1 : end - 1, 1)'), 2);
SIGNAL_TH_DM = sum(bsxfun(@times, dm_ath, geonu_signal_factor_th232(1: end - 1 , 1)'), 2);
SIGNAL_U_EM = sum(bsxfun(@times, em_au, geonu_signal_factor_u238(end, 1)'), 2);
SIGNAL_TH_EM = sum(bsxfun(@times, em_ath, geonu_signal_factor_th232(end, 1)'), 2);

end