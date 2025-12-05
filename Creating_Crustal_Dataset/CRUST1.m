global baseDir;
baseDir = pwd;
addpath(fullfile(baseDir, "Creating_Crustal_Dataset"));
dir = fullfile(baseDir, "Creating_Crustal_Dataset","CRUST1.0");
% ---------- Load Raw Data ---------- %
crust_bound = readmatrix(fullfile(dir, "crust1.bnds.txt")) .* 1e3; % Unit: m
crust_rho = readmatrix(fullfile(dir, "crust1.rho.txt")) .* 1e3; % Unit: kg/m^3
crust_vp = readmatrix(fullfile(dir,"crust1.vp.txt")); % Unit: km/s
crust_vs = readmatrix(fullfile(dir, "crust1.vs.txt")); % Unit: km/s

thickness = crust_bound(:, 1:end - 1) - crust_bound(:, 2:end); % water, Ice, s1, s2, s3, UC, MC, LC
depth = - (crust_bound(:, 2:end) + thickness(:, :)/2); % Center of the layer

Original_Crust_Dataset_Path = 'D:\Geo-nu\GEONU-main\InputFiles\LithosphereModels\CRUST1_Data.mat';
load(Original_Crust_Dataset_Path);

% ---------- Problems ---------- %
% Pro 1: Some of the data (e.g. depth, density, Vp, and Vs) are swapped.
% Test 1: Most of grids in s1 are lower than grids in s3
test = s1.depth >= s3.depth;
fprintf('[Test1] Numers of yes: %d\n', nnz(test));

% Test 2: most of grids in s1 have larger density than grids in s3
test = s1.rho - crust_rho(:, 3);
fprintf('[Test2] s1: Numers of nonzeros: %d\n', nnz(test));
test = s3.rho - crust_rho(:, 5);
fprintf('[Test2] s3: Numers of nonzeros: %d\n', nnz(test));

test = s1.rho - crust_rho(:, 5);
fprintf('[Test2] s1: Numers of nonzeros: %d\n', nnz(test));
test = s3.rho - crust_rho(:, 3);
fprintf('[Test2] s3: Numers of nonzeros: %d\n', nnz(test));

% Test 3: Same to Vp, Vs and thickness
test = s1.Vp - crust_vp(:, 3);
fprintf('[Test3] s1: Numers of nonzeros: %d\n', nnz(test));
test = s3.Vp - crust_vp(:, 5);
fprintf('[Test3] s3: Numers of nonzeros: %d\n', nnz(test));

test = s1.Vp - crust_vp(:, 5);
fprintf('[Test3] s1: Numers of nonzeros: %d\n', nnz(test));
test = s3.Vp - crust_vp(:, 3);
fprintf('[Test3] s3: Numers of nonzeros: %d\n', nnz(test));

test = s1.Vs - crust_vs(:, 3);
fprintf('[Test3] s1: Numers of nonzeros: %d\n', nnz(test));
test = s3.Vs - crust_vs(:, 5);
fprintf('[Test3] s3: Numers of nonzeros: %d\n', nnz(test));

test = s1.Vs - crust_vs(:, 5);
fprintf('[Test3] s1: Numers of nonzeros: %d\n', nnz(test));
test = s3.Vs - crust_vs(:, 3);
fprintf('[Test3] s3: Numers of nonzeros: %d\n', nnz(test));

% Pro 2: A few of grids in each layer have different thickness compared to the original data
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC'};
water_index = 2;
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    test = eval([layer, '.thick']) - thickness(:, water_index + ii1);
    fprintf('[Problem 2] %s: Numers of nonzeros: %d\n', layer, nnz(test));
end
clear water_index ii1 layer test;

% ---------- Creat New Dataset from CRUST1.0 ---------- %
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
start_index = 2;
for ii1 = 1 : length(layers)
    layer = layers{ii1};
    if strcmp(layer, 'LM') == 0
        eval([layer, '.depth = depth(:, start_index + ii1)']);
        eval([layer, '.thick = thickness(:, start_index + ii1)']);
    end
    eval([layer, '.rho = crust_rho(:, start_index + ii1)']);
    eval([layer, '.Vp = crust_vp(:, start_index + ii1)']);
    eval([layer, '.Vs = crust_vs(:, start_index + ii1)']);
end

Crust1.rho(:, 3 : end) = crust_rho;
Crust1.Vp(:, 3 : end) = crust_vp;
Crust1.Vs(:, 3 : end) = crust_vs;
Crust1.lonlat = Crust1.latlon;
Crust1 = rmfield(Crust1, 'latlon');

% % ---------- Save ---------- %
save("Modified_CRUST1_Data.mat", 's1', 's2', 's3', 'UC', 'MC', 'LC', 'LM', 'Crust1');