function [VOLUME, GP_FACTOR_U238, GP_FACTOR_TH232]  = Local_Compute_GP_Factor(index, detector, array_for_volume, array_for_signal)
% -------------------- Compute Volume -------------------- %
lon_center = array_for_volume{1};
lat_center = array_for_volume{2};
depth_center = array_for_volume{3}; % Unit: m; >0 %
half_thick = array_for_volume{4}; % Unit: m %
surface_radius = array_for_volume{5}; % Unit: m; 6371e3 m %

arc = pi / 180;
radius = surface_radius - depth_center; % Unit: m %
m_per_lon = radius * arc * cosd(lat_center);
m_per_lat = radius * arc;
large_size = 1000; % Unit: m %
lon_interval = large_size / m_per_lon;
lat_interval = large_size / m_per_lat;

% -------------------- Variables for GP Factor -------------------- %
sig_response_u238 = array_for_signal{1}; % Column vector $
sig_response_th232 = array_for_signal{2}; % Column vector $
energy = array_for_signal{3}; % Column vector $
p1 = array_for_signal{4};
p2 = array_for_signal{5};
p3 = array_for_signal{6};
m21 = array_for_signal{7};
m31 = array_for_signal{8};
m32 = array_for_signal{9};

% -------------------- Compute Distance -------------------- %
distance = Compute_Distance(lon_center, lat_center, surface_radius, depth_center, detector); % Unit: m %

VOLUME = Compute_Cell_Volume(lon_center - lon_interval/2, lon_center + lon_interval/2, ...
lat_center - lat_interval/2, lat_center + lat_interval/2, ...
radius - half_thick, radius + half_thick); % Unit: m^3 %

% -------------------- Compute for GP Factor -------------------- %
if distance <= 1e4
    Pee = 0.55;
else
part1 = 1 + p1 .* sin(1.27 * m21 .* bsxfun(@rdivide, distance, energy')) .^2; % cell * Energy %
part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, distance, energy')) .^2; % cell * Energy %
part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, distance, energy')) .^2; % cell * Energy %

Pee = part1 + part2 + part3; % 1 * Energy %
end
% Pee = 0.55; % 1 * Energy %

sig_factor_u238 = sum(VOLUME .* (Pee .* sig_response_u238'), 2); % 1 * 1 %
sig_factor_th232 = sum(VOLUME .* (Pee .* sig_response_th232'), 2); % 1 * 1 %

% Unit: m^5/kg %
GP_FACTOR_U238 = sig_factor_u238  ./ (distance .^ 2); % Unit: m^3/kg %
GP_FACTOR_TH232 = sig_factor_th232 ./ (distance .^2); % Unit: m^3/kg %

end