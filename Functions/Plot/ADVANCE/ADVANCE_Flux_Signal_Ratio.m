function [sig_mean, sig_error, flux_mean, flux_error, ratio, ratio_error] = ADVANCE_Flux_Signal_Ratio(bool, signals, fluxes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Flux_Signal_Ratio.m
% Description     : Compute mean and error of signal rate and flux and ratio of them
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - bool        : Control the output of messages
%   - signals     : Signal array
%   - fluxes      : Flux array
%
% Output Parameters:
%   - sig_mean    : Mean value of signal rates
%   - sig_error   : Error of signal rates
%   - flux_mean   : Mean value of fluxes
%   - flux_error  : Error of fluxes
%   - ratio       : Mean value of rate over flux
%   - ratio_error : Error of ratio
%
% Created On      : 2025-04-07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ~~~~~~~~~~~~~~~~~~~~ Fit ~~~~~~~~~~~~~~~~~~~~ % %
pd_signal = fitdist(signals, 'Normal');
pd_flux = fitdist(fluxes, 'Normal');
sig_mean = pd_signal.mu;
sig_error = pd_signal.sigma;
flux_mean = pd_flux.mu;
flux_error = pd_flux.sigma;
% % ~~~~~~~~~~~~~~~~~~~~ Ratio ~~~~~~~~~~~~~~~~~~~~ % %
ratio = flux_mean / sig_mean;
ratio_error = ratio * sqrt((flux_error / flux_mean)^2 + (sig_error / sig_mean)^2);
% % ~~~~~~~~~~~~~~~~~~~~ Output ~~~~~~~~~~~~~~~~~~~~ % %
if bool == 1
    fprintf('Signal: %.3f +- %.3f\n',sig_mean, sig_error);
    fprintf('Flux: %.3f +- %.3f\n',flux_mean * 1e-5, flux_error * 1e-5);
    fprintf('Ratio: %.3f +- %.3f\n',ratio * 1e-4, ratio_error * 1e-4);
end

end