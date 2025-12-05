function Geology = Assign_Abundance_Layer(Geology, Name_Layer, abund_U, abund_Th, abund_K)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Assign_Abundance_Layer.m
% Description     : Assign abundance to layers
%
% Adapted from    : Main code in old GEONU
% Adapted by      : Shuai Ouyang
% Institution     : Shandong Univeristy
% Classification  : Adapted
%
% Input Parameters:
%   - Geology     : Geology data structure
%   - Name_Layer  : Name of the layer
%   - abund_U     : Abundance of uranium
%   - abund_Th    : Abundance of thorium
%   - abund_K     : Abundance of potassium
%
% Output Parameters:
%   - Geology     : Geology data structure
%
% Physical Units:
%   - Abundance   : g/g
%
% Creation Date   : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ~~~~~~~~~~~~~~~~~~~~ OC and CC Index ~~~~~~~~~~~~~~~~~~~~ % %
logical_oc = Geology.Lithosphere.Model.Logical.OC;
logical_cc = Geology.Lithosphere.Model.Logical.CC;
layers = {'null'};

% % ~~~~~~~~~~~~~~~~~~~~ OC in UC, MC and LC ~~~~~~~~~~~~~~~~~~~~ % %
if strcmp(Name_Layer, 'OC')
    layers = {'UC', 'MC', 'LC'};
    for i = 1 : length(layers)
        layer = layers{i};
        for j = 1 : length(logical_oc)
            if(logical_oc(j) == true)
                Geology.Lithosphere.Model.Abundance.(layer).U(j, :) = abund_U;
                Geology.Lithosphere.Model.Abundance.(layer).Th(j, :) = abund_Th;
                Geology.Lithosphere.Model.Abundance.(layer).K(j, :) = abund_K;
            end
        end
    end
% % ~~~~~~~~~~~~~~~~~~~~ CC in UC ~~~~~~~~~~~~~~~~~~~~ % %
elseif strcmp(Name_Layer, 'UC_CC')
    for i = 1 : length(logical_cc)
        if(logical_cc(i) == true)
            Geology.Lithosphere.Model.Abundance.UC.U(i, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.UC.Th(i, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.UC.K(i, :) = abund_K;
        end
    end
% % ~~~~~~~~~~~~~~~~~~~~ CC in LM ~~~~~~~~~~~~~~~~~~~~ % %
elseif strcmp(Name_Layer, 'LM_CC')
    for i = 1 : length(logical_cc)
        if(logical_cc(i) == true)
            Geology.Lithosphere.Model.Abundance.LM.U(i, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.LM.Th(i, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.LM.K(i, :) = abund_K;
        end
    end
% % ~~~~~~~~~~~~~~~~~~~~ Sediment ~~~~~~~~~~~~~~~~~~~~ % %
elseif strcmp(Name_Layer, 'Sed')
    layers = {'s1', 's2', 's3'};
    for i = 1 : length(layers)
        layer = layers{i};
        for j = 1 : length(logical_cc)
            Geology.Lithosphere.Model.Abundance.(layer).U(j, :) = abund_U;
            Geology.Lithosphere.Model.Abundance.(layer).Th(j, :) = abund_Th;
            Geology.Lithosphere.Model.Abundance.(layer).K(j, :) = abund_K;
        end
    end
end
clear logical_oc logical_cc layers layer i;

end