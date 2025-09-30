%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Recording_Mass.m
% Description     : Record results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units:
%   - mass        : kg
%
% Created On      : 2025-09-30
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(layer_part, 'Lithosphere')
    fprintf('%s: Recording Mass\n', name_layer);

    % ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
    Output.Lithosphere.Mass.(name_layer).Rock = sum(MASS_ROCK, 1)';
    Output.Lithosphere.Mass.(name_layer).U = sum(MASS_U, 1)';
    Output.Lithosphere.Mass.(name_layer).Th = sum(MASS_TH, 1)';
    
    % ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
    if strcmp(name_layer, 'LM')
        layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
        template = 0 .* Output.Lithosphere.Mass.s1.Rock;
        Output.Lithosphere.Mass.Total.Rock = template;
        Output.Lithosphere.Mass.Total.U = template;
        Output.Lithosphere.Mass.Total.Th = template;
        % % Add up all layers % %
        for ii1 = 1 : length(layers)
            layer = layers{ii1};
            Output.Lithosphere.Mass.Total.Rock = Output.Lithosphere.Mass.Total.Rock + Output.Lithosphere.Mass.(layer).Rock;
            Output.Lithosphere.Mass.Total.U = Output.Lithosphere.Mass.Total.U + Output.Lithosphere.Mass.(layer).U;
            Output.Lithosphere.Mass.Total.Th = Output.Lithosphere.Mass.Total.Th + Output.Lithosphere.Mass.(layer).Th;
        end
        clear template layers layer;
    end
elseif strcmp(layer_part, 'Mantle')
    disp('TBD\n');
end