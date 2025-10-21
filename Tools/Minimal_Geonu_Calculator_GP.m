function [VOLUME, GP_FACTOR_U238, GP_FACTOR_TH232]  = Minimal_Geonu_Calculator_GP(index, detector, array_for_volume, array_for_signal)
% -------------------- Compute Volume -------------------- %
lon_center = array_for_volume{1};
lat_center = array_for_volume{2};
depth_center = array_for_volume{3}; % Unit: m; Z points to the center of the Earth. %
half_thick = array_for_volume{4}; % Unit: m %
surface_radius = array_for_volume{5}; % Unit: m; 6371e3 m %

radius = surface_radius - depth_center; % Unit: m %
lon_interval = array_for_volume{6};
lat_interval = array_for_volume{7};

% -------------------- Variables for GP Factor -------------------- %
sig_response_u238 = array_for_signal{1}; % Column vector %
sig_response_th232 = array_for_signal{2}; % Column vector %
energy = array_for_signal{3}; % Column vector %
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
part1 = 1 + p1 .* sin(1.27 * m21 .* bsxfun(@rdivide, distance, energy')) .^2; % cell * Energy %
part2 = p2 .* sin(1.27 * m31 .* bsxfun(@rdivide, distance, energy')) .^2; % cell * Energy %
part3 = p3 .* sin(1.27 * m32 .* bsxfun(@rdivide, distance, energy')) .^2; % cell * Energy %
Pee = part1 + part2 + part3; % 1 * Energy %

sig_factor_u238 = sum(VOLUME .* (Pee .* sig_response_u238'), 2); % 1 * 1 %
sig_factor_th232 = sum(VOLUME .* (Pee .* sig_response_th232'), 2); % 1 * 1 %

% Unit: m^5/kg %
GP_FACTOR_U238 = sig_factor_u238  ./ (distance .^ 2); % Unit: m^3/kg %
GP_FACTOR_TH232 = sig_factor_th232 ./ (distance .^2); % Unit: m^3/kg %
% end

end