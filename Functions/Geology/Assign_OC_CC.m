function Geology = Assign_OC_CC(Geology)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Assign_OC_CC.m
% Description     : Assign OC and CC type
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

% % ~~~~~~~~~~~~~~~~~~~~ Define Temp Variables ~~~~~~~~~~~~~~~~~~~~ % %
model_name = Geology.Lithosphere.Model.Name;
GeoPhys = Geology.Lithosphere.Model.GeoPhys;
len = length(GeoPhys.type);
geophys_type_value = 0;
OC_types = 0;
len_types = 0;
Logical.OC = zeros(len, 1);
Logical.CC = zeros(len, 1);

% % ~~~~~~~~~~~~~~~~~~~~ Start Assigning OC and CC ~~~~~~~~~~~~~~~~~~~~ % %
% % % ~~~~~~~~~~~~~~~~~~~~ Crust 1 ~~~~~~~~~~~~~~~~~~~~ % % %
if strcmp(model_name, 'Crust1')
    % % Temp Variables % %
    OC_types = [26,27,28,31,36];
    len_types = length(OC_types);
    % % Find OC % %
    for i = 1: len
        geophys_type_value = GeoPhys.type(i, 3);
        for j = 1: len_types
            if geophys_type_value == OC_types(j)
                Logical.OC(i) = true;
                break;
            end
        end
    end
    % % Find CC % %
    Logical.CC = ~Logical.OC;

% % % ~~~~~~~~~~~~~~~~~~~~ Crust 2 ~~~~~~~~~~~~~~~~~~~~ % % %
elseif strcmp(model_name, 'Crust2')
    % % Temp Variables % %
    OC_types = {'A0';'A1';'A2';'A3';'A4';'A5';'A6';'A7';'A8';'A9';'AA';'AB';...
        'AC';'BO';'B1';'B2';'B3';'B4';'B5';'B6';'B7';'B8';'B9';'BA';'BB';'BC';'BD'}; 
    len_types = length(OC_types);
    % % Find OC % %
    for i = 1: len
        geophys_type_value = GeoPhys.type(i, 1);
        for j = 1: len_types
            if strcmp(geophys_type_value, OC_types(j))
                Logical.OC(i) = true;
                break;
            end
        end
    end
    % % Find CC % %
    Logical.CC = ~Logical.OC;

% % % ~~~~~~~~~~~~~~~~~~~~ Litho1 and ECM1 ~~~~~~~~~~~~~~~~~~~~% % %
elseif strcmp(model_name, 'Litho1') || strcmp(model_name, 'ECM1')
    Logical.OC = Geology.Lithosphere.Model.Data.oc;
    Logical.CC = Geology.Lithosphere.Model.Data.cc;
end

% ~~~~~~~~~~~~~~~~~~~~ Record ~~~~~~~~~~~~~~~~~~~~ %
Geology.Lithosphere.Model.Logical.OC = Logical.OC;
Geology.Lithosphere.Model.Logical.CC = Logical.CC;

% ~~~~~~~~~~~~~~~~~~~~ Output Message ~~~~~~~~~~~~~~~~~~~~ %
disp('[Geology::Assign_OC_CC] Logical OC and CC are complete');

end

