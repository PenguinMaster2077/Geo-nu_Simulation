function Physics = Load_Geonu_Spectrum(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Load_Geonu_Spectrum.m
% Description     : Load geonu spectrum
%
% Original Author : Main code in old GEONU
% Modified by     : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Modified
%
% Modified by     : Zhihao Xu
% Institution     : Tohoku University, JP
% Classification  : Modified
%
% Input Parameters:
%   - Physics     : Physics data structure
%
% Output Parameters:
%   - Physics     : Physics data structure
%
% Physical Units:
%   - energy      : MeV
%   - spectrum    : 1/MeV
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Load Geonu Spectrum ~~~~~~~~~~~~~~~~~~~~ %
method = Physics.Elements.Spectrum.Method;
global baseDir;
if strcmp(method, 'Enomoto')
    Spectrum = load(fullfile(baseDir, "Input_Files", "Enomoto2007_AntineutrinoSpectrum.mat"));
    name = 'enomoto';
elseif strcmp(method, 'Yufeng')
    Spectrum = load(fullfile(baseDir, "Input_Files", "Yufeng2024_AntineutrinoSpectrum.mat"));
    name = 'Yufeng';
end

% % ~~~~~~~~~~~~~~~~~~~~ Set Energy Bins ~~~~~~~~~~~~~~~~~~~~ % %
binwidth = 0.1; % Unit: MeV %
Physics.Elements.Spectrum.Energy.Binwidth = binwidth; % Unit: MeV %
Physics.Elements.Spectrum.Energy.Bin_Centers = (0 + 0.5 * binwidth:binwidth:3.5)'; % Unit: MeV %

% % ~~~~~~~~~~~~~~~~~~~~ Process Spectrum ~~~~~~~~~~~~~~~~~~~~ % %
% % Define Zero Array % %
template = 0 .* Physics.Elements.Spectrum.Energy.Bin_Centers;
Physics.Elements.Spectrum.dn_dE.U238 = template;
Physics.Elements.Spectrum.dn_dE.U235 = template;
Physics.Elements.Spectrum.dn_dE.Th232 = template;
% Physics.Elements.Spectrum.dn_dE.K40 = template;

% % Resum Spectrum % %
Length = length(Physics.Elements.Spectrum.Energy.Bin_Centers);
Physics.Elements.Spectrum.Energy.Length = Length;
for ii1 = 1:Length
    energy = Physics.Elements.Spectrum.Energy.Bin_Centers(ii1, 1) + 0.5 *binwidth;
    index = find(Spectrum.(name)(:, 2) > energy, 1, 'first') - 1;
    last_index = index - binwidth * 1000 + 1;
    if last_index <= 0
        last_index = 1;
    end
    % % Resum % %
    Physics.Elements.Spectrum.dn_dE.U238(ii1, 1) = sum(Spectrum.(name)(last_index : index, 4)); % Unit: 1/MeV %
    Physics.Elements.Spectrum.dn_dE.U235(ii1, 1) = sum(Spectrum.(name)(last_index : index, 5)); % Unit: 1/MeV %
    Physics.Elements.Spectrum.dn_dE.Th232(ii1, 1) = sum(Spectrum.(name)(last_index : index, 6)); % Unit: 1/MeV %
    % Physics.Elements.Spectrum.dn_dE.K40(ii1, 1) = sum(Spectrum.(name)(last_index : index, 7)); % Unit: 1/MeV %
end

% % ~~~~~~~~~~~~~~~~~~~~ Compute Total Number of Spectrum ~~~~~~~~~~~~~~~~~~~~ % %
Physics.Elements.Spectrum.Total_Number.U238 = sum(Physics.Elements.Spectrum.dn_dE.U238);
Physics.Elements.Spectrum.Total_Number.U235 = sum(Physics.Elements.Spectrum.dn_dE.U235);
Physics.Elements.Spectrum.Total_Number.Th232 = sum(Physics.Elements.Spectrum.dn_dE.Th232);
% Physics.Elements.Spectrum.Total_Number.K40 = sum(Physics.Elements.Spectrum.dn_dE.K40);

% ~~~~~~~~~~~~~~~~~~~~ Output Message ~~~~~~~~~~~~~~~~~~~~ %
% disp('[Physics::Load_Geonu_Spectrum] Geonu spectrum is complete');

end