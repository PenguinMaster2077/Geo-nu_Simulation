%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : LITE_Generate_Temp_Variables_for_Parallel.m
% Description     : Define variables used in computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Start to process: Lithosphere\n');
% ~~~~~~~~~~~~~~~~~~~~ Temp Variabls ~~~~~~~~~~~~~~~~~~~~ %
len = length(Geology.Lithosphere.Model.GeoPhys.lonlat);
iteration = Geology.Iteration;
GeoPhys = Geology.Lithosphere.Model.GeoPhys;
detector = Physics.Detector;
detector.Radius = GeoPhys.r(1) - detector.Depth;
% % ~~~~~~~~~~~~~~~~~~~~ Signal ~~~~~~~~~~~~~~~~~~~~ % %
Sig_Res_U238 = Physics.Elements.Signal_Response.U238;
Sig_Res_Th232 = Physics.Elements.Signal_Response.Th232;
energy = Physics.Cross_Section.Energy;
p1 = Physics.Oscillation.Coefficients.p1;
p2 = Physics.Oscillation.Coefficients.p2;
p3 = Physics.Oscillation.Coefficients.p3;
m21 = Physics.Oscillation.Parameters.delta_m21_square;
m31 = Physics.Oscillation.Parameters.delta_m31_square;
m32 = Physics.Oscillation.Parameters.delta_m32_square;
array_for_signal = {Sig_Res_U238, Sig_Res_Th232, energy, p1, p2, p3, m21, m31, m32};
% % ~~~~~~~~~~~~~~~~~~~~ Geometry ~~~~~~~~~~~~~~~~~~~~ %
lonlat = GeoPhys.lonlat; % 64800 * 2; log : lat %
surface_radius = GeoPhys.r; % 64800 * 1 %
OC = Geology.Lithosphere.Model.Logical.OC;
name_model = Geology.Lithosphere.Model.Name;
name_deepcrust = Geology.Lithosphere.Model.Method.Deep_Crust;
