function Geology = Load_Lithosphere_Data(Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Load_Lithosphere_Data.m
% Description     : Load lithospheric data
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Modified by     : Zhihao Xu
% Institution     : Tohoku University, JP
% Classification  : Modified
% 
% Input Parameters:
%   - Geology     : Geology data structure
%
% Output Parameters:
%   - Geology     : Geology data structure
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Load Data for Lithosphere ~~~~~~~~~~~~~~~~~~~~ %
% % ~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~ % %
% % Define Temp Variables % %
set_lithosphere_models = {'Litho1','Crust1','Crust2','ECM1'};
model_index = 0;
model_name = 0;
model_data = 0;
global baseDir;

% % Get Name % %
model_index = Geology.Lithosphere.Model.Index;
model_name = set_lithosphere_models{model_index};
Geology.Lithosphere.Model.Name = model_name;

% % Load % %
if strcmp(model_name, 'Litho1')
    model_data = load(fullfile(baseDir, "Input_Files", "LithosphereModels", "LITHO1_Data.mat"));
    Geology.Lithosphere.Model.Data = model_data;
    Geology.Lithosphere.Model.GeoPhys = model_data.Litho1;
elseif strcmp(model_name, 'Crust1')
    model_data = load(fullfile(baseDir, "Input_Files", "LithosphereModels", "CRUST1_Data.mat"));
    Geology.Lithosphere.Model.Data = model_data;
    Geology.Lithosphere.Model.GeoPhys = model_data.Crust1;
elseif strcmp(model_name, 'Crust2')
    model_data = load(fullfile(baseDir, "Input_Files", "LithosphereModels", "CRUST2_Data.mat"));
    Geology.Lithosphere.Model.Data = model_data;
    Geology.Lithosphere.Model.GeoPhys = model_data.Crust2;
elseif strcmp(model_name, 'ECM1')
    model_data = load(fullfile(baseDir, "Input_Files", "LithosphereModels", "ECM1_Data.mat"));
    Geology.Lithosphere.Model.Data = model_data;
    Geology.Lithosphere.Model.GeoPhys = model_data.ECM1;
end
Geology.Lithosphere.Model.GeoPhys.Name = model_name;
Geology.Lithosphere.Model.Data.Bivar = load(fullfile(baseDir, "Input_Files", "BivarData_04042018.mat"));

% % ~~~~~~~~~~~~~~~~~~~~ Assign OC and CC  ~~~~~~~~~~~~~~~~~~~~% %
Geology = Assign_OC_CC(Geology);

% % ~~~~~~~~~~~~~~~~~~~~ Preallocate Variables ~~~~~~~~~~~~~~~~~~~~ % %
Geology = Preallocate_Variables_Lithosphere(Geology);

end