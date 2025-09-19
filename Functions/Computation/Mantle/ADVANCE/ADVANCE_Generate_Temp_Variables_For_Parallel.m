%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Generate_Temp_Variables_for_Parallel.m
% Description     : Define variables used in computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Temp Variables ~~~~~~~~~~~~~~~~~~~~ %
GeoPhys = Geology.Lithosphere.Model.GeoPhys;
LAB = GeoPhys.LAB;
lonlat = GeoPhys.lonlat; % 64800 * 2; log : lat %
surface_radius = GeoPhys.r;
PREM = Geology.Mantle.PREM;
detector = Physics.Detector;
detector.Radius = GeoPhys.r(1) - detector.Depth;
clear GeoPhys;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
Sig_Res_U238 = Physics.Elements.Signal_Response.U238;
Sig_Res_Th232 = Physics.Elements.Signal_Response.Th232;
energy = Physics.Cross_Section.Energy;
p1 = Physics.Oscillation.Coefficients.p1;
p2 = Physics.Oscillation.Coefficients.p2;
p3 = Physics.Oscillation.Coefficients.p3;
m21 = Physics.Oscillation.Parameters.delta_m21_square;
m31 = Physics.Oscillation.Parameters.delta_m31_square;
m32 = Physics.Oscillation.Parameters.delta_m32_square;
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
Abundance = Geology.Mantle.Abundance;
array_for_abundance = {Abundance.Depleted.U, Abundance.Depleted.Th, Abundance.Enriched.U, Abundance.Enriched.Th};
array_for_signal = {Sig_Res_U238, Sig_Res_Th232, energy, p1, p2, p3, m21, m31, m32};
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ %
Flux_Res_U238 = Physics.Elements.Flux_Response.U238;
Flux_Res_Th232 = Physics.Elements.Flux_Response.Th232;

array_for_flux = {Flux_Res_U238, Flux_Res_Th232};

clear Abundance;