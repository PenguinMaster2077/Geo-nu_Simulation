function [MANTLE_MASS, GEOFACTOR_U, GEOFACTOR_TH] = APPLICATION_Compute_Mantle_Cell_Toy_Model(index, detector, ...
    thickness, array_for_radius, array_for_mass, array_for_signal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : APPLICATION_Compute_Mantle_Cell_Toy_Model.m
% Description     : Compute interests
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - index                 : Index of the grid cell
%   - detector              : Informaiton of the detector
%   - cor_array             : Structure of correlation coefficients
%   - array_for_radius      : Variables used for radius calculation
%   - array_for_mass        : Variables used for mass calculation
%   - array_for_abudance    : Variables used for abudance calculation
%   - array_for_signal      : Variables used for signal rate calculation
%   - array_for_flux        : Variables used for flux calculation
%
% Output Parameters:
%   - MASS_U_DM     (kg)                : Total uranium mass in DM
%   - MASS_TH_DM    (kg)                : Total thorium mass in DM
%   - MASS_U_EM     (kg)                : Total uranium mass in EM
%   - MASS_TH_EM    (kg)                : Total thorium mass in EM
%   - SIGNAL_U_DM   (TNU)               : Signal rate from uranium in DM
%   - SIGNAL_TH_DM  (TNU)               : Signal rate from thorium in DM
%   - SIGNAL_U_EM   (TNU)               : Signal rate from uranium in EM
%   - SIGNAL_TH_EM  (TNU)               : Signal rate from thorium in EM
%   - FLUX_U_DM     (cm^{-2} s^{-1})    : Geonu flux from urainum in DM
%   - FLUX_TH_DM    (cm^{-2} s^{-1})    : Geonu flux from thorium in DM
%   - FLUX_U_EM     (cm^{-2} s^{-1})    : Geonu flux from urainum in EM
%   - FLUX_TH_EM    (cm^{-2} s^{-1})    : Geonu flux from thorium in EM
%
% Physical Units:
%   - radius        : m
%   - mass          : kg
%   - abundance     : g/g
%   - thickness     : m
%   - depth         : m
%   - DENSITY       : kg/m^3
%
% Created On      : 2025-08-06
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~ Depth of all 1 km Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
Upper_Boundary = array_for_radius{1};
CMB = array_for_radius{2};
thick = thickness;
layers_depth = Upper_Boundary + 0.5 * thick : thick : (CMB - 0.5 * thick); % Unit: m, center of each layer %
layers_depth = layers_depth'; % Column vector %
clear Upper_Boundary CMB;

% ~~~~~~~~~~~~~~ Mass of all 1 km Layers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass{1};
lat_center = array_for_mass{2};
surface_radius = array_for_mass{3};
PREM = array_for_mass{4};
for ii2 = 1 : length(layers_depth)
    volume = Compute_Cell_Volume(lon_center - 0.5, lon_center + 0.5, lat_center - 0.5, lat_center + 0.5,...
        surface_radius - layers_depth(ii2, 1) - 0.5 * thick, surface_radius - layers_depth(ii2, 1) + 0.5 * thick); % Unit: m^3 %
    index_density = round(layers_depth(ii2, 1) / 1000) + 1;
    density = PREM(index_density, 3); % Unit: kg/m^3 %
    layers_mass(ii2, :) = volume .* density;
end
clear lon_center lat_center surface_radius PREM;
clear ii2 volume index_density density;

% ~~~~~~~~~~~~~~ Heat Power ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
MANTLE_MASS = sum(layers_mass, 1);

% ~~~~~~~~~~~~~~ Compute G Factor ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
lon_center = array_for_mass{1};
lat_center = array_for_mass{2};
surface_radius = array_for_mass{3};
PREM = array_for_mass{4};

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
len = length(layers_mass);
geonu_signal_factor_u238 = zeros(len, 1);
geonu_signal_factor_th232 = zeros(len, 1);

for ii2 = 1 : length(layers_mass)
    distance = Compute_Distance(lon_center, lat_center, surface_radius, layers_depth(ii2), detector);

    if distance > subcell_limits(5)
        part1 = 1 + p1 .* sin(1.27 * m21 .* bsxfun(@rdivide, distance, energy')) .^2 ; % 1 * Energy %
        part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
        part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, distance, energy')) .^2; % 1 * Energy %
        Pee = part1 + part2 + part3;
        % % Signal % %
        sig_factor_u238 = sum(layers_mass(ii2, 1) .* (sig_response_u238 .* Pee')', 2); % 1 * 1 %
        sig_factor_th232 = sum(layers_mass(ii2, 1) .* (sig_response_th232 .* Pee')', 2); % 1 * 1 %
        unit_geonu_sig_factor_u238 = sig_factor_u238 ./ (distance .^ 2); % 1 * 1 %
        unit_geonu_sig_factor_th232 = sig_factor_th232 ./ (distance .^2); % 1 * 1 %
        geonu_signal_factor_u238(ii2, 1) = sum(unit_geonu_sig_factor_u238, 1);
        geonu_signal_factor_th232(ii2, 1) =  sum(unit_geonu_sig_factor_th232, 1);
        clear sig_factor_u238 sig_factor_th232 unit_geonu_sig_factor_u238 unit_geonu_sig_factor_th232;
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
            = Split_Cell(lon_center, lat_center, layers_depth(ii2, 1), 1, 1, thick, subcell_size, surface_radius);
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
            % % % Signal % % %
            sig_factor_u238 = sum(density .* sub_volumes(ii3, 1) .* (sig_response_u238 .* Pee')', 2); % 1 * 1 %
            sig_factor_th232 = sum(density .* sub_volumes(ii3, 1) .* (sig_response_th232 .* Pee')', 2); % 1 * 1 %
            unit_geonu_sig_factor_u238 = sig_factor_u238 ./ (sub_distance .^ 2); % 1 * 1 %
            unit_geonu_sig_factor_th232 = sig_factor_th232 ./ (sub_distance .^ 2); % 1 * 1 %
            geonu_signal_factor_u238(ii2, 1) = geonu_signal_factor_u238(ii2, 1) + unit_geonu_sig_factor_u238; % 1 * 1 %
            geonu_signal_factor_th232(ii2, 1) = geonu_signal_factor_th232(ii2, 1) + unit_geonu_sig_factor_th232; % 1 * 1 %
            clear sig_factor_u238 sig_factor_th232 unit_geonu_sig_factor_u238 unit_geonu_sig_factor_th232;
        end
    end
end

GEOFACTOR_U = sum(geonu_signal_factor_u238, 1);
GEOFACTOR_TH = sum(geonu_signal_factor_th232, 1);