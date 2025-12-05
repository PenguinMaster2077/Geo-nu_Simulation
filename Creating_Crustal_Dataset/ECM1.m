global baseDir;
baseDir = pwd;
addpath(fullfile(baseDir, "Creating_Crustal_Dataset"));
dir = fullfile(baseDir, "Creating_Crustal_Dataset","LITHO1.0");
% ---------- Load Raw Data ---------- %
Original_Crust_Dataset_Path = 'D:\Geo-nu\GEONU-main\InputFiles\LithosphereModels\ECM1_Data.mat';
load(Original_Crust_Dataset_Path);

% ---------- Problems ---------- %
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC'};
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    n1 = eval(['nnz(', layer, '.rho);']);
    fprintf('%s: Num of nonzero in density: %f\n', layer, n1);
    n1 = eval(['nnz(', layer, '.thick);']);
    fprintf('%s: Num of nonzero in thickness: %f\n', layer, n1);
    n1 = eval(['nnz(', layer, '.Vp);']);
    fprintf('%s: Num of nonzero in Vp: %f\n', layer, n1);
    n1 = eval(['nnz(', layer, '.Vs);']);
    fprintf('%s: Num of nonzero in Vs: %f\n\n', layer, n1);
end