function Physics = Load_Oscillation_Parameters(Physics)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Load_Oscillation_Parameters.m
% Description     : Load oscillation parameters
%
% Original Author : Main code in old GEONU
% Modified by     : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Modified
%
% Input Parameters:
%   - Physics     : Physics data structure
%
% Output Parameters:
%   - Physics     : Physics data structure
%
% Physical Units:
%   - delta m square  : eV^2
%
% Created On      : 2024-11-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ~~~~~~~~~~~~~~~~~~~~ Load Oscillation Parameters ~~~~~~~~~~~~~~~~~~~~ %
Constant = Physics.Oscillation.Constant;
% % Constant == 0: randomly generate oscillation parameters % %
% % Constant == 1: use mean values form PDG % %
% From Table 14.7 in https://pdg.lbl.gov/2024/reviews/rpp2024-rev-neutrino-mixing.pdf

% % ~~~~~~~~~~~~~~~~~~~~ Input Parameters ~~~~~~~~~~~~~~~~~~~~ % %
% % Mixing angles % %
Physics.Oscillation.Parameters.sin_theta12_square = 1e-1 * 3.07;
Physics.Oscillation.Parameters.sin_theta13_square = 1e-2 * 2.16;
Physics.Oscillation.Parameters.sin_theta23_square = 1e-1 * 5.72;

% % Mass % %
Physics.Oscillation.Parameters.delta_m21_square = 1e-5 * 7.50; % Unit: eV^2
Physics.Oscillation.Parameters.delta_m31_square = 1e-3 * 2.526; % Unit: eV^2
Physics.Oscillation.Parameters.delta_m32_square = 1e-3 * 2.451; % Unit: eV^2

% % ~~~~~~~~~~~~~~~~~~~~ Computation Parameters ~~~~~~~~~~~~~~~~~~~~ %
% cos^2(A) = 1 - sin^2(A)
Physics.Oscillation.Parameters.cos_theta12_square = 1 - Physics.Oscillation.Parameters.sin_theta12_square;
Physics.Oscillation.Parameters.cos_theta13_square = 1 - Physics.Oscillation.Parameters.sin_theta13_square;
Physics.Oscillation.Parameters.cos_theta23_square = 1 - Physics.Oscillation.Parameters.sin_theta23_square;

% sin^2(2A) = 4 sin^2(A) cos^2(A)
Physics.Oscillation.Parameters.sin_2theta12_square = 4 * Physics.Oscillation.Parameters.sin_theta12_square * Physics.Oscillation.Parameters.cos_theta12_square;
Physics.Oscillation.Parameters.cos_2theta12_square = 1 - Physics.Oscillation.Parameters.sin_2theta12_square;

Physics.Oscillation.Parameters.sin_2theta13_square = 4 * Physics.Oscillation.Parameters.sin_theta13_square * Physics.Oscillation.Parameters.cos_theta13_square;
Physics.Oscillation.Parameters.cos_2theta13_square = 1 - Physics.Oscillation.Parameters.sin_2theta13_square;

Physics.Oscillation.Parameters.sin_2theta23_square = 4 * Physics.Oscillation.Parameters.sin_theta23_square * Physics.Oscillation.Parameters.cos_theta23_square;
Physics.Oscillation.Parameters.cos_2theta23_square = 1 - Physics.Oscillation.Parameters.sin_2theta23_square;

% Coefficients for Pee
sin_2theta12_square = Physics.Oscillation.Parameters.sin_2theta12_square;
cos_theta13_square = Physics.Oscillation.Parameters.cos_theta13_square;
sin_2theta13_square = Physics.Oscillation.Parameters.sin_2theta13_square;
cos_theta12_square = Physics.Oscillation.Parameters.cos_theta12_square;
sin_theta12_square = Physics.Oscillation.Parameters.sin_theta12_square;
%%%%%%%%%%%%%%%%% Survival Probability %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pee = 1 - sin^2(2\theta_12)cos^4(theta_13)sin^2(1.27m_12^2L/E)
% - sin^2(2\theta_13)cos^2(theta_12)sin^2(1.27m_13^2L/E)
% - sin^2(2\theta_13)sin^2(\theta_12)sin^2(1.27m_23^2L/E)
% = 1 + p1 * sin^2(1.27m_12^2L/E) + p2 * sin^2(1.27m_13^2L/E) + p3 * sin^2(1.27m_23^2L/E)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Physics.Oscillation.Coefficients.p1 = - sin_2theta12_square * cos_theta13_square^2;
Physics.Oscillation.Coefficients.p2 = - sin_2theta13_square * cos_theta12_square;
Physics.Oscillation.Coefficients.p3 = - sin_2theta13_square * sin_theta12_square;
clear sin_2theta12_square cos_theta13_square sin_2theta13_square cos_theta12_square sin_theta12_square;

% ~~~~~~~~~~~~~~~~~~~~ Output Message ~~~~~~~~~~~~~~~~~~~~ %
% disp('[Physics::Load_Oscillation_Parameters] Oscillation parameters is complete');

end