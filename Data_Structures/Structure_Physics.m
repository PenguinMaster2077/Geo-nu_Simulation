%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Structure_Physics.m
% Description     : Define data structure of Physics
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Physical Units  :
%   - Delta m square       : eV^2
%   - Half-life            : s
%   - Decay Rate           : 1/s
%   - Mass                 : amu
%   - Energy               : MeV
%   - Spectrum             : 1/MeV
%   - IBD Cross Section    : cm^2
%   - Signal Response      : m^2 kg^{-1} MeV^{-1}
%   - Flux Response        : m^2 kg^{-1}
%   - Heat Power per Mass  : W/kg
%   - Radius               : m
%   - Depth                : m
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Oscillation ~~~~~~~~~~~~~~~~~~~~ %
% % Oscillation.Constant % %
Physics.Oscillation.Constant = 1; % Bool %

% % Oscillation.Parameters % %
Physics.Oscillation.Parameters.sin_theta12_square = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Parameters.cos_theta12_square = 'Load_Oscillation_Parameters()';

Physics.Oscillation.Parameters.sin_theta13_square = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Parameters.cos_theta13_square = 'Load_Oscillation_Parameters()';

Physics.Oscillation.Parameters.sin_theta23_square = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Parameters.cos_theta23_square = 'Load_Oscillation_Parameters()';
% sin^2(2A) = 4 sin^2(A) cos^2(A) %
Physics.Oscillation.Parameters.sin_2theta12_square = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Parameters.cos_2theta12_square = 'Load_Oscillation_Parameters()';

Physics.Oscillation.Parameters.sin_2theta13_square = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Parameters.cos_2theta13_square = 'Load_Oscillation_Parameters()';

Physics.Oscillation.Parameters.sin_2theta23_square = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Parameters.cos_2theta23_square = 'Load_Oscillation_Parameters()';

Physics.Oscillation.Parameters.delta_m21_square = 'Load_Oscillation_Parameters()'; % Unit: eV^2 %
Physics.Oscillation.Parameters.delta_m31_square = 'Load_Oscillation_Parameters()'; % Unit: eV^2 %
Physics.Oscillation.Parameters.delta_m32_square = 'Load_Oscillation_Parameters()'; % Unit: eV^2 %

% % Oscillation.Coefficients % %
Physics.Oscillation.Coefficients.p1 = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Coefficients.p2 = 'Load_Oscillation_Parameters()';
Physics.Oscillation.Coefficients.p3 = 'Load_Oscillation_Parameters()';

% ~~~~~~~~~~~~~~~~~~~~ Elements ~~~~~~~~~~~~~~~~~~~~ %
% % Elements.Halflife % %
% % % From 10.1088/1674-1137/abddae % % %
Physics.Elements.Halflife.U238 = 4.463e9 * 365 * 86400; % Unit: s %
Physics.Elements.Halflife.U235 = 0.704e9 * 365 * 86400; % Unit: s %
Physics.Elements.Halflife.Th232 = 14.0e9 * 365 * 86400; % Unit: s %
Physics.Elements.Halflife.K40 = 1.248e9 * 365 * 86400; % Unit: s %

% % Elements.Decay_Constant % %
Physics.Elements.Decay_Constant.U238 = log(2) / Physics.Elements.Halflife.U238; % Unit: 1/s %
Physics.Elements.Decay_Constant.U235 = log(2) / Physics.Elements.Halflife.U235; % Unit: 1/s %
Physics.Elements.Decay_Constant.Th232 = log(2) / Physics.Elements.Halflife.Th232; % Unit: 1/s %
Physics.Elements.Decay_Constant.K40 = log(2) / Physics.Elements.Halflife.K40; % Unit: 1/s %

% % Elements.Mass % %
% % % From 10.1088/1674-1137/abddaf % % %
Physics.Elements.Mass.U238 = 238.0507869; % Unit: amu %
Physics.Elements.Mass.U235 = 235.0439281; % Unit: amu %
Physics.Elements.Mass.Th232 = 232.0380536; % Unit: amu %
Physics.Elements.Mass.K39 = 38.963706485; % Unit: amu %
Physics.Elements.Mass.K40 = 39.96399817; % Unit: amu %
Physics.Elements.Mass.K41 = 40.961825256; % Unit: amu %

% % Elements.Abundance % %
% % % Abundance.Mole % % %
Physics.Elements.Abundance.Mole.U238 = 0.993;
Physics.Elements.Abundance.Mole.U235 = 1 - Physics.Elements.Abundance.Mole.U238;
Physics.Elements.Abundance.Mole.Th232 = 1;
Physics.Elements.Abundance.Mole.K39 = 0.01 * 93.258144;
Physics.Elements.Abundance.Mole.K40 = 0.01 * 0.0117;
Physics.Elements.Abundance.Mole.K41 = 0.01 * 6.730156;

% % % Abundance.Mass % % %
Physics.Elements.Abundance.Mass.U238 = Compute_Relative_Abundance_Mass(Physics, 'U238');
Physics.Elements.Abundance.Mass.U235 = Compute_Relative_Abundance_Mass(Physics, 'U235');
Physics.Elements.Abundance.Mass.Th232 = Compute_Relative_Abundance_Mass(Physics, 'Th232');
Physics.Elements.Abundance.Mass.K40 = Compute_Relative_Abundance_Mass(Physics, 'K40');

% % Elements.Spectrum % %
% % % Spectrum.Energy % % %
Physics.Elements.Spectrum.Energy.Binwidth = 0.1; % Unit: MeV %
Physics.Elements.Spectrum.Energy.Bin_Centers = 0; % Unit: MeV %
Physics.Elements.Spectrum.Energy.Length = 0;

% % % Spectrum.dn_dE % % %
Physics.Elements.Spectrum.Method = 'Enomoto';
Physics.Elements.Spectrum.dn_dE.U238 = 'Load_Geonu_Specturm()'; % Unit: 1/MeV %
Physics.Elements.Spectrum.dn_dE.U235 = 'Load_Geonu_Specturm()'; % Unit: 1/MeV %
Physics.Elements.Spectrum.dn_dE.Th232 = 'Load_Geonu_Specturm()'; % Unit: 1/MeV %
Physics.Elements.Spectrum.dn_dE.K40 = 'Load_Geonu_Specturm()'; % Unit: 1/MeV %

% % % Spectrum.Total_Number % % %
Physics.Elements.Spectrum.Total_Number.U238 = 'Load_Geonu_Specturm()';
Physics.Elements.Spectrum.Total_Number.U235 = 'Load_Geonu_Specturm()';
Physics.Elements.Spectrum.Total_Number.Th232 = 'Load_Geonu_Specturm()';
Physics.Elements.Spectrum.Total_Number.K40 = 'Load_Geonu_Specturm()';

% % Elements.Signal_Response % %
Physics.Elements.Signal_Response.U238 = 'Compute_Geonu_Response()';
Physics.Elements.Signal_Response.U235 = 'Compute_Geonu_Response()';
Physics.Elements.Signal_Response.Th232 = 'Compute_Geonu_Response()';
Physics.Elements.Signal_Response.K40 = 'Compute_Geonu_Response()';

% % Elements.Flux_Response % %
Physics.Elements.Flux_Response.U238 = 'Compute_Geonu_Response()';
Physics.Elements.Flux_Response.U235 = 'Compute_Geonu_Response()';
Physics.Elements.Flux_Response.Th232 = 'Compute_Geonu_Response()';
Physics.Elements.Flux_Response.K40 = 'Compute_Geonu_Response()';

% % Elements.Heat_Power % %
% % % From S. T. Dye: https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2012RG000400 % % % 
Physics.Elements.Heat_Power.U = 98.5 * 1e-6; % Unit: W/kg. Calculate by i abundance %
Physics.Elements.Heat_Power.U238 = 95.13 * 1e-6; % Unit: W/kg %
Physics.Elements.Heat_Power.U235 = 568.47 * 1e-6; % Unit: W/kg %
Physics.Elements.Heat_Power.Th232 = 26.28 * 1e-6; % Unit: W/kg %
Physics.Elements.Heat_Power.K = 3.33 * 1e-3 * 1e-6; % Unit: W/kg. Calculate by mole abundance %
Physics.Elements.Heat_Power.K40 = 28.47 * 1e-6; % Unit: W/kg %

% % Elements.Geonu_Flux % %
% % % From S. T. Dye: https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2012RG000400 % % %
Physics.Elements.Geonu_Flux.U = 74.6 * 1e6; % Unit: 1/(s kg). Calculate by mole abundance %
Physics.Elements.Geonu_Flux.U238 = 74.6 * 1e6; % Unit: 1/(s kg) %
Physics.Elements.Geonu_Flux.U235 = 319.9 * 1e6; % Unit: 1/(s kg) %
Physics.Elements.Geonu_Flux.Th232 = 16.2 * 1e6; % Unit: 1/(s kg) %
Physics.Elements.Geonu_Flux.K = 27.1 * 1e-3 * 1e6; % Unit: 1/(s kg). Calculate by mole abundance %
Physics.Elements.Geonu_Flux.K40 = 231.2 * 1e6; % Unit: 1/(s kg) %

% ~~~~~~~~~~~~~~~~~~~  Cross_Section ~~~~~~~~~~~~~~~~~~~~ %
Physics.Cross_Section.Model = '2022';
Physics.Cross_Section.Energy = 'Compute_Cross_Section()';
Physics.Cross_Section.IBD = 'Compute_Cross_Section()';

% ~~~~~~~~~~~~~~~~~~~ Constants ~~~~~~~~~~~~~~~~~~~~ %
% % Constants.Unit_Conversion % %
% % % From Wiki % % %
Physics.Constants.Unit_Conversion.cm_m = 1e-2;
Physics.Constants.Unit_Conversion.cm2_m2 = 1e-4;
Physics.Constants.Unit_Conversion.cm3_m3 = 1e-6;
Physics.Constants.Unit_Conversion.g_kg = 1e-3;
Physics.Constants.Unit_Conversion.mus_s = 1e-6;
Physics.Constants.Unit_Conversion.amu_kg = 1.66053906892e-27;
% % Constants.Others % %
% % % From Wiki % % %
Physics.Constants.Others.Avogadro = 6.02214076e23;
Physics.Constants.Others.K_K2O = (2 * 39.0983) / (2 * 39.0983 + 15.999); % Mass ratio of K in K2O; use it in Deep Crust %

% ~~~~~~~~~~~~~~~~~~~ Detector ~~~~~~~~~~~~~~~~~~~~ %
Physics.Detector.Index = 'Input';
Physics.Detector.Name = 'Load_Detector()';
Physics.Detector.Longitude = 'Load_Detector()'; % Unit: degree %
Physics.Detector.Latitude = 'Load_Detector()'; % Unit: degree %
Physics.Detector.Radius = 'Load_Detector()'; % Unit: m %
Physics.Detector.Depth = 'Load_Detector()'; % Unit: m %
Physics.Detector.Selection_Efficiency = 'Load_Detector()';
Physics.Detector.Proton_Number = 'Load_Detector()';
Physics.Detector.Clostest_Cell = [0, 0]; % Unit: degree %

% ~~~~~~~~~~~~~~~~~~~  Load Physics ~~~~~~~~~~~~~~~~~~~~ %
Physics = Load_Oscillation_Parameters(Physics);
Physics = Load_Geonu_Spectrum(Physics);
Physics = Load_IBD_Cross_Section(Physics);
Physics = Compute_Geonu_Response(Physics);

% ~~~~~~~~~~~~~~~~~~~~ Output message ~~~~~~~~~~~~~~~~~~~~ %
% disp('[Constants_Physics] Physics data structure is complete');