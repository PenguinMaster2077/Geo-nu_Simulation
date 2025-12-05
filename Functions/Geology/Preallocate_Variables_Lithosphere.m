function Geology = Preallocate_Variables_Lithosphere(Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Preallocate_Variables_Lithosphere.m
% Description     : Preallocate variables
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Geology     : Geology data structure
%
% Output Parameters:
%   - Geology     : Geology data structure
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Preallocate Variables ~~~~~~~~~~~~~~~~~~~~ %
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
len_layer = length(layers);
template = zeros(length(Geology.Lithosphere.Model.GeoPhys.lonlat), 3);
for i = 1 : len_layer
    layer = layers{i};
    Geology.Lithosphere.Model.Abundance.(layer).U = template;
    Geology.Lithosphere.Model.Abundance.(layer).Th = template;
    Geology.Lithosphere.Model.Abundance.(layer).K = template;
end
clear layers len_layer i layer;
% ~~~~~~~~~~~~~~~~~~~~ Output Message ~~~~~~~~~~~~~~~~~~~~ %
disp('[Geology::Allocate_Variables_Lithosphere] Preallocate variables is complete');

end