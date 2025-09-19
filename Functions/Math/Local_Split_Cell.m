function [sub_longitude, sub_latitude, sub_depth, lon_sub_interval, lat_sub_interval, thick_sub_interval] = Local_Split_Cell(center_lon, center_lat, center_depth, surface_radius, large_size, small_size)
arc = pi / 180;
radius = surface_radius - center_depth;
m_per_lat = radius * arc;
m_per_lon = radius * arc * cosd(center_lat);
lat_interval = large_size / m_per_lat;
lon_interval = large_size / m_per_lon;
% ~~~~~~~~~~~~~~~~~~~~ Longitude ~~~~~~~~~~~~~~~~~~~~ %
lon_sub_interval = lon_interval / round(large_size / small_size);
sub_longitude = center_lon - (lon_interval / 2) + (lon_sub_interval / 2) : lon_sub_interval : center_lon + (lon_interval / 2) - (lon_sub_interval / 2);
clear lon_interval;

% ~~~~~~~~~~~~~~~~~~~~ Latitude ~~~~~~~~~~~~~~~~~~~~ %
lat_sub_interval = lat_interval / round(large_size / small_size);
sub_latitude = center_lat - (lat_interval / 2) + (lat_sub_interval / 2) : lat_sub_interval : center_lat + (lat_interval / 2) - (lat_sub_interval / 2);

% ~~~~~~~~~~~~~~~~~~~~ Depth ~~~~~~~~~~~~~~~~~~~~ %
thick_sub_interval = 100 / small_size;
sub_depth = center_depth - 50 + thick_sub_interval/2 : thick_sub_interval : center_depth + 50 - thick_sub_interval / 2;

% ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ %
[sub_latitude, sub_longitude, sub_depth] = meshgrid(sub_latitude, sub_longitude, sub_depth);
sub_longitude = sub_longitude(:);
sub_latitude = sub_latitude(:);
sub_depth = sub_depth(:);

end