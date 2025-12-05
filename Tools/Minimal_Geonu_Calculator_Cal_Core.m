% ~~~~~~~~~~~~~~~~~~~~ Loading data ~~~~~~~~~~~~~~~~~~~~ %
data = readmatrix(Cal.Input_File_Path);
if strcmp(Cal.Data_Format, 'JUNO')
    len_grids = length(data(:, 1));

    lonlat = data(:, 1 : 2);
    half_thick = (data(:, 3) - data(:, 4)) ./ 2;
    depth = -(data(:, 3) + data(:, 4)) ./ 2;
    density_mean = data(:, 5) .* 1e3;

    ppm = 1e-6;
    aU_Mean = data(:, 8) .* ppm;
    aU_NError = data(:, 9) .* ppm;
    aU_PError = data(:, 10) .* ppm;
    
    aTh_Mean = data(:, 11) .* ppm;
    aTh_NError = data(:, 12) .* ppm;
    aTh_PError = data(:, 13) .* ppm;
end

% ~~~~~~~~~~~~~~~~~~~~ Computing ~~~~~~~~~~~~~~~~~~~~ %
% Detector
surface_radius = 6371e3; % Unit: m
detector = Physics.Detector;
detector.Radius = surface_radius - detector.Depth;
% Signal 
Sig_Res_U238 = Physics.Elements.Signal_Response.U238;
Sig_Res_Th232 = Physics.Elements.Signal_Response.Th232;
% Oscillation
energy = Physics.Cross_Section.Energy;
p1 = Physics.Oscillation.Coefficients.p1;
p2 = Physics.Oscillation.Coefficients.p2;
p3 = Physics.Oscillation.Coefficients.p3;
m21 = Physics.Oscillation.Parameters.delta_m21_square;
m31 = Physics.Oscillation.Parameters.delta_m31_square;
m32 = Physics.Oscillation.Parameters.delta_m32_square;
array_for_signal = {Sig_Res_U238, Sig_Res_Th232, energy, p1, p2, p3, m21, m31, m32};

VOLUME = zeros(len_grids, 1);
DISTANCE = zeros(len_grids, 1);
GP_U238 = zeros(len_grids, 1);
GP_TH232 = zeros(len_grids, 1);

% ----- Compute GP Factor ----- %
for iGrid = 1 : len_grids
    array_for_volume = {lonlat(iGrid, 1), lonlat(iGrid, 2), depth(iGrid, 1), half_thick(iGrid, 1), surface_radius, Cal.Longitude_Interval, Cal.Latitude_Interval};
    [DISTANCE(iGrid, 1), VOLUME(iGrid, 1), GP_U238(iGrid, 1), GP_TH232(iGrid, 1)] = Minimal_Geonu_Calculator_GP(iGrid, detector, array_for_volume, array_for_signal);
end
clear iGrid surface_radius detector Sig_Res_U238 Sig_Res_Th232;
clear energy p1 p2 p3 m21 m31 m32 array_for_signal array_for_volume;

% ----- Compute Signal Rate ----- %
if Cal.Is_Sampling
    iteration = Cal.Sampling_Time;
    SIGNAL_U238 = zeros(len_grids, iteration);
    SIGNAL_TH232 = zeros(len_grids, iteration);
    cor_abundance = Generate_Random_Standard_Normal(iteration);
    for iGrid = 1 : len_grids
        if aU_PError(iGrid, 1) == aU_NError(iGrid, 1)
            au = Generate_Random_Normal(aU_Mean(iGrid, 1), aU_PError(iGrid, 1), 0, cor_abundance);
        else
            % TBD
        end

        if aTh_PError(iGrid, 1) == aTh_NError(iGrid, 1)
            ath = Generate_Random_Normal(aTh_Mean(iGrid, 1), aTh_PError(iGrid, 1), 0, cor_abundance);
        else
            % TBD
        end
        
        SIGNAL_U238(iGrid, :) = density_mean(iGrid, 1) .* au .* GP_U238(iGrid, 1);
        SIGNAL_TH232(iGrid, :) = density_mean(iGrid, 1) .* ath .* GP_TH232(iGrid, 1);
    end
    clear iteration cor_abundance;
    clear iGrid au ath;
else
    SIGNAL_U238 = density_mean .* aU_Mean .* GP_U238;
    SIGNAL_TH232 = density_mean .* aTh_Mean .* GP_TH232;
end
    SIGNAL = SIGNAL_U238 + SIGNAL_TH232;
clear density_mean depth half_thick len_grids lonlat;
clear ppm aU_Mean aU_NError aU_PError;
clear aTh_Mean aTh_NError aTh_PError;
clear GP_U238 GP_TH232 VOLUME;
% ~~~~~~~~~~~~~~~~~~~~ Saving ~~~~~~~~~~~~~~~~~~~~ %
if Cal.Saving
    [~, name, ~] = fileparts(Cal.Input_File_Path);
    vars = {'SIGNAL_U238', 'SIGNAL_TH232', 'SIGNAL'};
    items = {'U238', 'Th232', 'Total'};
    for ii1 = 1 : length(items)
        var = vars{ii1};
        item = items{ii1};
        file_name = fullfile(Cal.Output_Dir, sprintf('%s_%s.csv', name, item));
        eval(sprintf('writematrix(%s, file_name);', var));
    end
    clear name vars var items item ii1 file_name;
end
