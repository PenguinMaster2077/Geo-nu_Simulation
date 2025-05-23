% ~~~~~~~~~~~~~~~~~~~~ Each Layer ~~~~~~~~~~~~~~~~~~~~ %
Output.Lithosphere.Mass.(name_layer).Total = sum(total_mass, 1)';
Output.Lithosphere.Mass.(name_layer).U = sum(mass_u, 1)';
Output.Lithosphere.Mass.(name_layer).Th = sum(mass_th, 1)';
Output.Lithosphere.Geonu_Spectrum.(name_layer).Total = SPECTRUM_U + SPECTRUM_TH;
Output.Lithosphere.Geonu_Spectrum.(name_layer).U238 = SPECTRUM_U;
Output.Lithosphere.Geonu_Spectrum.(name_layer).Th232 = SPECTRUM_TH;
Output.Lithosphere.Geonu_Signal.(name_layer).Total = sum(SPECTRUM_U + SPECTRUM_TH, 2);
Output.Lithosphere.Geonu_Signal.(name_layer).U238 = sum(SPECTRUM_U, 2);
Output.Lithosphere.Geonu_Signal.(name_layer).Th232 = sum(SPECTRUM_TH, 2);
% % Clear Variables % %
SPECTRUM_U = 0 .* SPECTRUM_U;
SPECTRUM_TH = 0 .* SPECTRUM_TH;

% ~~~~~~~~~~~~~~~~~~~~ LM and Total ~~~~~~~~~~~~~~~~~~~~ %
if strcmp(name_layer, 'LM')
    layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
    template = 0 .* Output.Lithosphere.Mass.s1.Total;
    Output.Lithosphere.Mass.Total.Total = template;
    Output.Lithosphere.Mass.Total.U = template;
    Output.Lithosphere.Mass.Total.Th = template;
    Output.Lithosphere.Geonu_Signal.Total.Total = template;
    Output.Lithosphere.Geonu_Signal.Total.U238 = template;
    Output.Lithosphere.Geonu_Signal.Total.Th232 = template;
    template = 0 .* Output.Lithosphere.Geonu_Signal.s1.Total;
    Output.Lithosphere.Geonu_Spectrum.Total.Total = template;
    Output.Lithosphere.Geonu_Spectrum.Total.U238 = template;
    Output.Lithosphere.Geonu_Spectrum.Total.Th232 = template;
    % % Add up all layers % %
    for ii1 = 1 : length(layers)
        layer = layers{ii1};
        Output.Lithosphere.Mass.Total.Total = Output.Lithosphere.Mass.Total.Total + Output.Lithosphere.Mass.(layer).Total;
        Output.Lithosphere.Mass.Total.U = Output.Lithosphere.Mass.Total.U + Output.Lithosphere.Mass.(layer).U;
        Output.Lithosphere.Mass.Total.Th = Output.Lithosphere.Mass.Total.Th + Output.Lithosphere.Mass.(layer).Th;
        
        Output.Lithosphere.Geonu_Signal.Total.U238 = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.(layer).U238;
        Output.Lithosphere.Geonu_Signal.Total.Th232 = Output.Lithosphere.Geonu_Signal.Total.Th232 + Output.Lithosphere.Geonu_Signal.(layer).Th232;

        Output.Lithosphere.Geonu_Spectrum.Total.U238 = Output.Lithosphere.Geonu_Spectrum.Total.U238 + Output.Lithosphere.Geonu_Spectrum.(layer).U238;
        Output.Lithosphere.Geonu_Spectrum.Total.Th232 = Output.Lithosphere.Geonu_Spectrum.Total.Th232 + Output.Lithosphere.Geonu_Spectrum.(layer).Th232;
    end
    Output.Lithosphere.Geonu_Signal.Total.Total = Output.Lithosphere.Geonu_Signal.Total.U238 + Output.Lithosphere.Geonu_Signal.Total.Th232;
    Output.Lithosphere.Geonu_Spectrum.Total.Total = Output.Lithosphere.Geonu_Spectrum.Total.U238 + Output.Lithosphere.Geonu_Spectrum.Total.Th232;
    clear template layers layer;
    
end