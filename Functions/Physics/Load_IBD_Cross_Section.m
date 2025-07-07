function Physics = Load_IBD_Cross_Section(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Load_IBD_Cross_Section.m
% Description     : Load IBD cross section
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
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
%   - energy        : MeV
%   - cross section : cm^2
%
% Created On      : 2025-05-26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~ % %
model = Physics.Cross_Section.Model;
global baseDir;
IBD_Cross_Section = load(fullfile(baseDir, "Input_Files", "IBD_Cross_Section.mat"));
energies = Physics.Elements.Spectrum.Energy.Bin_Centers;
ibd_energies = IBD_Cross_Section.IBD_Cross_Section(:, 1);
if strcmp(model, 'Approximation')
    ibd = IBD_Cross_Section.IBD_Cross_Section(:, 2);
elseif strcmp(model, '1999')
    ibd = IBD_Cross_Section.IBD_Cross_Section(:, 3);
elseif strcmp(model, '2003')
    ibd = IBD_Cross_Section.IBD_Cross_Section(:, 4);
elseif strcmp(model, '2022')
    ibd = IBD_Cross_Section.IBD_Cross_Section(:, 5);
end
% % ~~~~~~~~~~~~~~~~~~~~ Extract IBD Cross Section by Energy ~~~~~~~~~~~~~~~~~~~~ % %
ibd_selected = zeros(size(energies));
for i = 1:length(energies)
    idx = find(abs(ibd_energies - energies(i)) < 1e-8, 1);
    if isempty(idx)
        error("Energy %.6f not found in IBD energy grid.", energies(i));
    end
    ibd_selected(i) = ibd(idx);
end
% % ~~~~~~~~~~~~~~~~~~~~ Save ~~~~~~~~~~~~~~~~~~~~ % %
Physics.Cross_Section.Energy = energies;
Physics.Cross_Section.IBD = ibd_selected;
Physics = Compute_Geonu_Response(Physics);

end