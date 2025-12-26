function Physics = Compute_Geonu_Response(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Compute_Geonu_Response.m
% Description     : Compute useful variables in signal computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - Physics     : Physics data structure
%
% Output Parameters:
%   - Physics     : Physics data structure
%
% Physical Units:
%   - signal response     : m^2 kg^{-1} MeV^{-1}
%   - flux response       : m^2/kg
%
% Created On      : 2025-03-13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Geonu_Response is a variable to compute geonu signal, which is
% Signals = Rock Mass * Abundance * Geonu_Response * Pee * 1/Distance^2 * Detection Efficiency

% % ~~~~~~~~~~~~~~~~~~~~ Get Variables ~~~~~~~~~~~~~~~~~~~~ % %
am_kg = Physics.Constants.Unit_Conversion.amu_kg;
IBD = Physics.Cross_Section.IBD;
one_year = 365.2425 * 86400;
HPEs = {'U235', 'U238', 'Th232', 'K40'};
% % ~~~~~~~~~~~~~~~~~~~~ Computation ~~~~~~~~~~~~~~~~~~~~ % %
for i = 1 : length(HPEs)
    HPE = HPEs{i};
    half_life = Physics.Elements.Halflife.(HPE);
    atom_mass = Physics.Elements.Mass.(HPE);
    spectrum = Physics.Elements.Spectrum.dn_dE.(HPE);
    mass_abundance = Physics.Elements.Abundance.Mass.(HPE);
    flux_res = (mass_abundance / (atom_mass * am_kg)) * (log(2) / half_life) .* spectrum .* (1/(4 * pi));
    sig_res = flux_res .* IBD  .* (1e-4) .* one_year .* 1e32; % 1e-4 come form 1/cm^2 to 1/m^2 %
    Physics.Elements.Signal_Response.(HPE) = sig_res; % Unit: m^2/(kg MeV) %
    Physics.Elements.Flux_Response.(HPE) = flux_res;
end

% ~~~~~~~~~~~~~~~~~~~~ Output Message ~~~~~~~~~~~~~~~~~~~~ %
% disp('[Physics::Compute_Geonu_Response] Geonu resoponse is complete');

end