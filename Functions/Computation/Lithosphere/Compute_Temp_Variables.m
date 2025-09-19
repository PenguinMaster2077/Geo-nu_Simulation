%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Temp_Variables.m
% Description     : Define variables used in computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2024-11-09
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Compute Temp Variables for Lithsophere ~~~~~~~~~~~~~~~~~~~~ %
fprintf('Start to process: %s\n', name_layer);
template = zeros(len, iteration);
if strcmp(name_layer, 's1')
    PRESSURE = template;
end
clear template;

% ~~~~~~~~~~~~~~~~~~~~ General Variables ~~~~~~~~~~~~~~~~~~~~ %
cor_thick = Geology.Lithosphere.Model.Correlation.(name_layer).Thickness; % Column vector %
cor_vp = Geology.Lithosphere.Model.Correlation.(name_layer).Vp; % Column vector %
thick = Geology.Lithosphere.Model.Data.(name_layer).thick; % 64800 * 1 %
depth = Geology.Lithosphere.Model.Data.(name_layer).depth; % 64800 * 1 %
density = Geology.Lithosphere.Model.Data.(name_layer).rho; % 64800 * 1 %
cor_abund = Geology.Lithosphere.Model.Correlation.(name_layer).Abundance; % Column vector %
abund_U = Geology.Lithosphere.Model.Abundance.(name_layer).U; % 64800 * 3 %
abund_Th = Geology.Lithosphere.Model.Abundance.(name_layer).Th; % 64800 * 3 %
abund_K = Geology.Lithosphere.Model.Abundance.(name_layer).K; % 64800 * 3 %

% ~~~~~~~~~~~~~~~~~~~~ MC + Huang ~~~~~~~~~~~~~~~~~~~~ %
if strcmp(name_layer, 'MC') && strcmp(name_deepcrust, 'Huang')
    cor_end = Geology.Lithosphere.Model.Correlation.(name_layer).DeepCrust.End.Vp; % Column vector %

    crust_vp = Geology.Lithosphere.Model.Data.(name_layer).Vp;
    name_method = Geology.Lithosphere.Model.Method.Deep_Crust;
    felsic_U = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.U; % Column vector %
    felsic_Th = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.Th; % Column vector %
    felsic_K = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Felsic.K; % Column vector %
    mafic_U = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.U; % Column vector %
    mafic_Th = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.Th; % Column vector %
    mafic_K = Geology.Lithosphere.Model.DeepCrust.Amphibolite.Mafic.K; % Column vector %
    K_Ratio = Physics.Elements.Abundance.Mass.K40;
% ~~~~~~~~~~~~~~~~~~~~ MC + Bivariate ~~~~~~~~~~~~~~~~~~~~ %
elseif strcmp(name_layer, 'MC') && strcmp(name_deepcrust, 'Bivariate')
    cor_biv_sio2 = Geology.Lithosphere.Model.Correlation.MC.DeepCrust.Bivar.SiO2;
    cor_biv_abund = Geology.Lithosphere.Model.Correlation.MC.DeepCrust.Bivar.Abundance;
    
    crust_vp = Geology.Lithosphere.Model.Data.(name_layer).Vp;
    name_method = Geology.Lithosphere.Model.Method.Deep_Crust;
    center_vp = Geology.Lithosphere.Model.DeepCrust.Bivart.seis.amp.center.Vp;
    am_u = Geology.Lithosphere.Model.DeepCrust.Bivart.amp.U.fit.param;
    am_th = Geology.Lithosphere.Model.DeepCrust.Bivart.amp.Th.fit.param;
    am_k20 = Geology.Lithosphere.Model.DeepCrust.Bivart.amp.K2O.fit.param;
    k_k20 = Physics.Constants.Others.K_K2O;
% ~~~~~~~~~~~~~~~~~~~~ LC + Huang ~~~~~~~~~~~~~~~~~~~~ %
elseif strcmp(name_layer, 'LC') && strcmp(name_deepcrust, 'Huang')
    cor_end = Geology.Lithosphere.Model.Correlation.(name_layer).DeepCrust.End.Vp; % Column vector %

    crust_vp = Geology.Lithosphere.Model.Data.(name_layer).Vp;
    name_method = Geology.Lithosphere.Model.Method.Deep_Crust;
    felsic_U = Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.U; % Column vector %
    felsic_Th = Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.Th; % Column vector %
    felsic_K = Geology.Lithosphere.Model.DeepCrust.Granulite.Felsic.K; % Column vector %
    mafic_U = Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.U; % Column vector %
    mafic_Th = Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.Th; % Column vector %
    mafic_K = Geology.Lithosphere.Model.DeepCrust.Granulite.Mafic.K; % Column vector %
    K_Ratio = Physics.Elements.Abundance.Mass.K40;
% ~~~~~~~~~~~~~~~~~~~~ LC + Bivarit ~~~~~~~~~~~~~~~~~~~~ %
elseif strcmp(name_layer, 'LC') && strcmp(name_deepcrust, 'Bivariate')
    cor_biv_sio2 = Geology.Lithosphere.Model.Correlation.LC.DeepCrust.Bivar.SiO2;
    cor_biv_abund = Geology.Lithosphere.Model.Correlation.LC.DeepCrust.Bivar.Abundance;
    
    crust_vp = Geology.Lithosphere.Model.Data.(name_layer).Vp;
    name_method = Geology.Lithosphere.Model.Method.Deep_Crust;
    center_vp = Geology.Lithosphere.Model.DeepCrust.Bivart.seis.gran.center.Vp;
    gr_u = Geology.Lithosphere.Model.DeepCrust.Bivart.gran.U.fit.param;
    gr_th = Geology.Lithosphere.Model.DeepCrust.Bivart.gran.Th.fit.param;
    gr_k20 = Geology.Lithosphere.Model.DeepCrust.Bivart.gran.K2O.fit.param;
    k_k20 = Physics.Constants.Others.K_K2O;
% ~~~~~~~~~~~~~~~~~~~~ LM ~~~~~~~~~~~~~~~~~~~~ %
elseif strcmp(name_layer, 'LM')
    moho = Geology.Lithosphere.Model.GeoPhys.moho;
end

