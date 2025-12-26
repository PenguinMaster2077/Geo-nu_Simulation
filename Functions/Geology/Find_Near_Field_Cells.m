function [Geology] = Find_Near_Field_Cells(Geology, Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Find_Near_Field_Cells.m
% Description     : Find index of the grid cell that is close to the detector
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Geology     : Geology data structure
%   - Physics     : Physics data structure
%
% Output Parameters:
%   - Geology     : Geology data structure
%   - Physics     : Physics data structure
%
% Physical Units:
%   - Radius      : m
%   - Distance    : m
%
% Creation Date   : 2025-12-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

near_cell_info = Physics.Detector.Clostest_Cell{1};
longs = near_cell_info(1) + 0.5 : 1 : near_cell_info(1) + 6 -0.5;
lats = near_cell_info(2) + 0.5 : 1 : near_cell_info(2) + 4 - 0.5;
[LONS, LATS] = meshgrid(longs, lats); % lats * longs, i.e. 4 * 6 %
near_cells = horzcat(LONS(:), LATS(:)); % 24 cells %
near_cells_indices = knnsearch(Geology.Lithosphere.Model.GeoPhys.lonlat, near_cells);
near_cells_logic = false(length(Geology.Lithosphere.Model.GeoPhys.lonlat(:, 1)), 1);
near_cells_logic(near_cells_indices) = true;

% Recording
Geology.Near_Field.Method = 'Traditional';
Geology.Near_Field.Indices = near_cells_indices;
Geology.Near_Field.Logic = near_cells_logic;
Geology.Near_Field.Lonlat = Geology.Lithosphere.Model.GeoPhys.lonlat(near_cells_indices, :);

% Clear Variables
clear longs lats LONS LATS 
clear near_cells_info near_cells near_cells_indices near_cells_logic;