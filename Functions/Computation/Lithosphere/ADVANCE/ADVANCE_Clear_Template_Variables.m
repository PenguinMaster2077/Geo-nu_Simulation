%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : ADVANCE_Clear_Template_Variables.m
% Description     : Clear variables after computation
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Created On      : 2025-04-03
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear GeoPhys;
clear Sig_Res_U238 Sig_Res_Th232 Flux_Res_U238 Flux_Res_Th232 energy;
clear p1 p2 p3 m21 m31 m32;

clear lonlat surface_radius OC name_model;
clear total_mass mass_u mass_th signal_u signal_th flux_u flux_th;
clear PRESSURE temp_pressure;

clear ii1;
clear abund_U abund_Th abund_K;
clear thick depth density;
clear cor_thick cor_vp cor_abund;
clear moho; % LM %
clear array_for_radius array_for_mass array_for_abundance array_for_signal cor_array;
clear detector;

if strcmp(name_deepcrust, 'Huang')
clear cor_end crust_vp name_method;
clear felsic_U felsic_Th felsic_K;
clear mafic_U mafic_Th mafic_K;
clear K_Ratio;
elseif strcmp(name_deepcrust, 'Bivariate')
clear cor_biv_sio2 cor_biv_abund crust_vp name_method center_vp;
clear am_u am_th am_k20 k_k20;
end

clear name_deepcrust name_layer;
