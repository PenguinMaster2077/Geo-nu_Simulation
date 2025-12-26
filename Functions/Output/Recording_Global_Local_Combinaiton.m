% ---------- Local-Field Crust Results ---------- %
fprintf('Processing local-field computation ...\n');
lookup = [
    % density (kg/m^3), uncertainty (kg/m^3), aU (ppm), pos uncer (ppm),
    % neg uncer (ppm), aTh (ppm), pos uncer (ppm), neg uncer (ppm)
    2.73e3, 0.08e3, 0.7e-6, 0.5e-6, 0.3e-6, 3.1e-6, 2.3e-6, 1.3e-6; % Tonalite/Tonalite gneiss
    2.67e3, 0.02e3, 2.8e-6, 1.4e-6, 0.8e-6, 19.6e-6, 7.1e-6, 5.2e-6; % Granite or granodiorite
    2.96e3, 0.03e3, 0.8e-6, 0.5e-6, 0.3e-6, 3.5e-6, 2.8e-6, 1.6e-6; % Middle crust
    2.73e3, 0.08e3, 2.6e-6, 0.4e-6, 0.4e-6, 5.1e-6, 6.0e-6, 2.8e-6; % Central gneiss belt
    2.8e3, 0.1e3, 2.3e-6, 0.2e-6, 0.1e-6, 10.7e-6, 0.4e-6, 0.4e-6; % Sudbury igneous complex
    0, 0, 0, 0, 0, 0, 0, 0; % ?
    2.84e3, 0.14e3, 0.4e-6, 0.3e-6, 0.1e-6, 1.5e-6, 0.9e-6, 0.5e-6; % (Meta) volcanics rocks
    2.69e3, 0.04e3, 4.2e-6, 2.9e-6, 1.7e-6, 11.1e-6, 8.2e-6, 4.8e-6; % Huronian supergroup
    2.62e3, 0.19e3, 2.5e-6, 2.0e-6, 1.1e-6, 4.4e-6, 1.6e-6, 1.2e-6; % Palezoic sedimentary rocks
    3.08e3, 0.06e3, 0.2e-6, 0.2e-6, 0.1e-6, 1.4e-6, 1.8e-6, 0.7e-6; % Lower crust – upper layer
    3.08e3, 0.06e3, 0.2e-6, 0.2e-6, 0.1e-6, 1.4e-6, 1.8e-6, 0.7e-6; % Lower crust – lower layer
];

rock_type = Crust(:, 5);
unique_rock_type = unique(rock_type);
iteration = 100000;
% ---------- Final Data Structure ---------- %
Results.Local_Crust.Density_Abundance_Table = lookup;
Results.Local_Crust.Rock_Indices = zeros(length(unique_rock_type), 1);
Results.Local_Crust.Correlation.Abundance = zeros(length(unique_rock_type), iteration);
Results.Local_Crust.Correlation.Density = zeros(length(unique_rock_type), iteration);

SIGNAL_U238 = zeros(length(unique_rock_type), iteration);
SIGNAL_TH232 = zeros(length(unique_rock_type), iteration);
MASS_ROCK = zeros(length(unique_rock_type), iteration);
MASS_U = zeros(length(unique_rock_type), iteration);
MASS_U238 = zeros(length(unique_rock_type), iteration);
MASS_U235 = zeros(length(unique_rock_type), iteration);
MASS_TH = zeros(length(unique_rock_type), iteration);

for index = 1 : length(unique_rock_type)
    type = unique_rock_type(index, 1);
    idx = find(Crust(:, 5) == type);
    rock_density = lookup(type, 1);
    rock_density_error = lookup(type, 2);
    aU = lookup(type, 3);
    aU_Perror = lookup(type, 4);
    aU_Nerror = lookup(type, 5);

    aTh232 = lookup(type, 6);
    aTh232_Perror = lookup(type, 7);
    aTh232_Nerror = lookup(type, 8);
    gp_u238 = sum(Local_Res.Result.GP.U238(idx, 1));
    gp_th232 = sum(Local_Res.Result.GP.Th232(idx, 1));
    volumes = sum(Local_Res.Result.Volume(idx, 1));
    
    % ----- Signal Rate ---- %
    temp_u238 = 0;
    temp_th232 = 0;

    correlation_density_table = Generate_Random_Standard_Normal(iteration);
    correlation_abundance_table = Generate_Random_Standard_Normal(iteration);

    temp_density = Generate_Random_Normal(rock_density, rock_density_error, 0, correlation_density_table);
    temp_au = Generate_Random_Log_Normal(aU, aU_Perror, aU_Nerror, 0, correlation_abundance_table);
    temp_au238 = temp_au .* Physics.Elements.Abundance.Mass.U238;
    temp_au235 = temp_au .* Physics.Elements.Abundance.Mass.U235;
    temp_ath232 = Generate_Random_Log_Normal(aTh232, aTh232_Perror, aTh232_Nerror, 0, correlation_abundance_table);

    temp_u238 = temp_u238 + temp_density .* temp_au238 .* gp_u238;
    temp_th232 = temp_th232 + temp_density .* temp_ath232 .* gp_th232;

    SIGNAL_U238(index, :) = temp_u238;
    SIGNAL_TH232(index, :) = temp_th232;

    % ----- Mass ----- %
    MASS_ROCK(index, :) = temp_density .* volumes;
    MASS_U(index, :) = temp_density .* volumes .* temp_au;
    MASS_U238(index, :) = temp_density .* volumes .* temp_au238;
    MASS_U235(index, :) = temp_density .* volumes .* temp_au235;
    MASS_TH(index, :) = temp_density .* volumes .* temp_ath232;

    % ----- Recording ----- %
    Results.Local_Crust.Rock_Indices(index, 1) = type;
    Results.Local_Crust.Correlation.Density(index, :) = correlation_density_table; % Iteration * Rock type %
    Results.Local_Crust.Correlation.Abundance(index, :) = correlation_abundance_table; % Iteration * Rock type %
end
clear lookup rock_type unique_rock_type iteration;
clear index type idx;
clear rock_density rock_density_error aU aU_Perror aU_Nerror aTh232 aTh232_Perror aTh232_Nerror;
clear gp_u238 gp_th232 volumes;
clear temp_u238 temp_th232 correlation_density_table correlation_abundance_table;
clear temp_density temp_au temp_au238 temp_au235 temp_ath232;

% ---------- Recording Mass ---------- %
fprintf('Recording local-field crust mass ...\n');
Results.Local_Crust.Mass.Rock = MASS_ROCK;
Results.Local_Crust.Mass.U = MASS_U;
Results.Local_Crust.Mass.U238 = MASS_U238;
Results.Local_Crust.Mass.U235 = MASS_U235;
Results.Local_Crust.Mass.Th = MASS_TH;
clear MASS_ROCK MASS_U MASS_U238 MASS_U235 MASS_TH;

% ---------- Recording Radiogenic Heat Power ---------- %
fprintf('Recording local-field crust radiogenic heat power ...\n');
Results.Local_Crust.Heat_Power.U = Results.Local_Crust.Mass.U .* Physics.Elements.Heat_Power.U;
Results.Local_Crust.Heat_Power.U238 = Results.Local_Crust.Mass.U238 .* Physics.Elements.Heat_Power.U238;
Results.Local_Crust.Heat_Power.U235 = Results.Local_Crust.Mass.U235 .* Physics.Elements.Heat_Power.U235;
Results.Local_Crust.Heat_Power.Th = Results.Local_Crust.Mass.Th .* Physics.Elements.Heat_Power.Th232;

Results.Local_Crust.Heat_Power.MC.U = Results.Local_Crust.Heat_Power.U(3, :);
Results.Local_Crust.Heat_Power.MC.U238 = Results.Local_Crust.Heat_Power.U238(3, :);
Results.Local_Crust.Heat_Power.MC.U235 = Results.Local_Crust.Heat_Power.U235(3, :);
Results.Local_Crust.Heat_Power.MC.Th = Results.Local_Crust.Heat_Power.Th(3, :);
Results.Local_Crust.Heat_Power.MC.Total = Results.Local_Crust.Heat_Power.MC.U + Results.Local_Crust.Heat_Power.MC.Th;

Results.Local_Crust.Heat_Power.UC.U = sum(Results.Local_Crust.Heat_Power.U(1:8, :), 1) - Results.Local_Crust.Heat_Power.U(3, :);
Results.Local_Crust.Heat_Power.UC.U238 = sum(Results.Local_Crust.Heat_Power.U238(1:8, :), 1) - Results.Local_Crust.Heat_Power.U238(3, :);
Results.Local_Crust.Heat_Power.UC.U235 = sum(Results.Local_Crust.Heat_Power.U235(1:8, :), 1) - Results.Local_Crust.Heat_Power.U235(3, :);
Results.Local_Crust.Heat_Power.UC.Th = sum(Results.Local_Crust.Heat_Power.Th(1:8, :), 1) - Results.Local_Crust.Heat_Power.Th(3, :);
Results.Local_Crust.Heat_Power.UC.Total = Results.Local_Crust.Heat_Power.UC.U + Results.Local_Crust.Heat_Power.UC.Th;

Results.Local_Crust.Heat_Power.LC.U = sum(Results.Local_Crust.Heat_Power.U(end - 1 : end, :), 1);
Results.Local_Crust.Heat_Power.LC.U238 = sum(Results.Local_Crust.Heat_Power.U238(end - 1 : end, :), 1);
Results.Local_Crust.Heat_Power.LC.U235 = sum(Results.Local_Crust.Heat_Power.U235(end - 1 : end, :), 1);
Results.Local_Crust.Heat_Power.LC.Th = sum(Results.Local_Crust.Heat_Power.Th(end - 1 : end, :), 1);
Results.Local_Crust.Heat_Power.LC.Total = Results.Local_Crust.Heat_Power.LC.U + Results.Local_Crust.Heat_Power.LC.Th;

Results.Local_Crust.Heat_Power.Total.U = Results.Local_Crust.Heat_Power.UC.U + Results.Local_Crust.Heat_Power.MC.U + Results.Local_Crust.Heat_Power.LC.U;
Results.Local_Crust.Heat_Power.Total.U238 = Results.Local_Crust.Heat_Power.UC.U238 + Results.Local_Crust.Heat_Power.MC.U238 + Results.Local_Crust.Heat_Power.LC.U238;
Results.Local_Crust.Heat_Power.Total.U235 = Results.Local_Crust.Heat_Power.UC.U235 + Results.Local_Crust.Heat_Power.MC.U235 + Results.Local_Crust.Heat_Power.LC.U235;
Results.Local_Crust.Heat_Power.Total.Th = Results.Local_Crust.Heat_Power.UC.Th + Results.Local_Crust.Heat_Power.MC.Th + Results.Local_Crust.Heat_Power.LC.Th;
Results.Local_Crust.Heat_Power.Total.Total = Results.Local_Crust.Heat_Power.UC.Total + Results.Local_Crust.Heat_Power.MC.Total + Results.Local_Crust.Heat_Power.LC.Total;

% ---------- Signal Rate ---------- %
fprintf('Recording local-field crust signal rate ...\n');
Results.Local_Crust.Geonu_Signal.U238 = SIGNAL_U238;
Results.Local_Crust.Geonu_Signal.Th232 = SIGNAL_TH232;
clear SIGNAL_U238 SIGNAL_TH232;

Results.Local_Crust.Geonu_Signal.MC.U238 = Results.Local_Crust.Geonu_Signal.U238(3, :);
Results.Local_Crust.Geonu_Signal.MC.Th232 = Results.Local_Crust.Geonu_Signal.Th232(3, :);
Results.Local_Crust.Geonu_Signal.MC.Total = Results.Local_Crust.Geonu_Signal.MC.U238 + Results.Local_Crust.Geonu_Signal.MC.Th232;

Results.Local_Crust.Geonu_Signal.UC.U238 = sum(Results.Local_Crust.Geonu_Signal.U238(1:8, :), 1) - Results.Local_Crust.Geonu_Signal.U238(3, :);
Results.Local_Crust.Geonu_Signal.UC.Th232 = sum(Results.Local_Crust.Geonu_Signal.Th232(1:8, :), 1) - Results.Local_Crust.Geonu_Signal.Th232(3, :);
Results.Local_Crust.Geonu_Signal.UC.Total = Results.Local_Crust.Geonu_Signal.UC.U238 + Results.Local_Crust.Geonu_Signal.UC.Th232;

Results.Local_Crust.Geonu_Signal.LC.U238 = sum(Results.Local_Crust.Geonu_Signal.U238(end - 1 : end, :), 1);
Results.Local_Crust.Geonu_Signal.LC.Th232 = sum(Results.Local_Crust.Geonu_Signal.Th232(end - 1 : end, :), 1);
Results.Local_Crust.Geonu_Signal.LC.Total = Results.Local_Crust.Geonu_Signal.LC.U238 + Results.Local_Crust.Geonu_Signal.LC.Th232;

Results.Local_Crust.Geonu_Signal.Total.U238 = Results.Local_Crust.Geonu_Signal.UC.U238 + Results.Local_Crust.Geonu_Signal.MC.U238 + Results.Local_Crust.Geonu_Signal.LC.U238;
Results.Local_Crust.Geonu_Signal.Total.Th232 = Results.Local_Crust.Geonu_Signal.UC.Th232 + Results.Local_Crust.Geonu_Signal.MC.Th232 + Results.Local_Crust.Geonu_Signal.LC.Th232;
Results.Local_Crust.Geonu_Signal.Total.Total = Results.Local_Crust.Geonu_Signal.Total.U238 + Results.Local_Crust.Geonu_Signal.Total.Th232;

% ---------- Far-Field Crust Results ---------- %
fprintf('Recording far-field crust mass, signal rate and radiogenic heat power ...\n');
% Results.Far_Crust.Mass.s1.Rock = Output.Lithosphere.Mass.s1.Rock - Combination.Mass.Rock(:, 1);
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
len_layers = length(layers);
for iLayer = 1 : len_layers
    layer = layers{iLayer};
    if strcmp('LM', layer)
       target = 'Mantle';
    else
       target = 'Far_Crust';
    end

    % ----- Mass ----- %
    mass_fields = {'Rock', 'U', 'U238', 'U235', 'Th'};
    for iField = 1 : length(mass_fields)
        filed = mass_fields{iField};
        Results.(target).Mass.(layer).(filed) = Output.Lithosphere.Mass.(layer).(filed) - Combination.Mass.(filed)(iLayer, :)';
    end
    clear iField mass_fields filed;

    % ----- Signal Rate ----- %
    signal_fileds = {'Total', 'U238', 'Th232'};
    for iField = 1 : length(signal_fileds)
        field = signal_fileds{iField};
        if strcmp('Total', field)
            Results.(target).Geonu_Signal.(layer).(field) = Output.Lithosphere.Geonu_Signal.(layer).(field) - Combination.Geonu_Signal.Total_Each_Layer(iLayer, :)';
        else
            Results.(target).Geonu_Signal.(layer).(field) = Output.Lithosphere.Geonu_Signal.(layer).(field) - Combination.Geonu_Signal.(field)(iLayer, :)';
        end
    end
    clear signal_fileds iField field;

    % ----- Radiogenic Heat Power ----- %
    heat_fields = {'Total', 'U', 'U238', 'U235', 'Th'};
    for iField = 1 : length(heat_fields)
        field = heat_fields{iField};
        if strcmp('Total', field)
            Results.(target).Heat_Power.(layer).(field) = Output.Lithosphere.Heat_Power.(layer).(field) - Combination.Heat_Power.Total_Each_Layer(iLayer, :)';
        else
            Results.(target).Heat_Power.(layer).(field) = Output.Lithosphere.Heat_Power.(layer).(field) - Combination.Heat_Power.(field)(iLayer, :)';
        end
    end
    clear heat_fields field iField target;
end

% ----- Far-Crust: Add up Mass ----- %
layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC'};
mass_fields = {'Rock', 'U', 'U238', 'U235', 'Th'};
for iField = 1 : length(mass_fields)
    field = mass_fields{iField};
    for iLayer = 1 : length(layers)
        layer = layers{iLayer};
        if iLayer == 1
            Results.Far_Crust.Mass.Total.(field) = 0 .* Results.Far_Crust.Mass.s1.(field);
        end
        Results.Far_Crust.Mass.Total.(field) = Results.Far_Crust.Mass.Total.(field) + Results.Far_Crust.Mass.(layer).(field);
    end
end
clear mass_fields iField field;

% ----- Far-Crust: Add up Signal Rate ----- %
signal_fields = {'Total','U238', 'Th232'};
for iField = 1 : length(signal_fields)
    field = signal_fields{iField};
    for iLayer = 1 : length(layers)
        layer = layers{iLayer};
        if iLayer == 1
            Results.Far_Crust.Geonu_Signal.Total.(field) = 0 .* Results.Far_Crust.Geonu_Signal.s1.(field);
        end
        Results.Far_Crust.Geonu_Signal.Total.(field) = Results.Far_Crust.Geonu_Signal.Total.(field) + Results.Far_Crust.Geonu_Signal.(layer).(field);
    end
end
clear signal_fields iField field;

% ----- Far-Crust: Add up Radiogenic Heat Power ----- %
heat_fields = {'Total', 'U', 'U238', 'U235', 'Th'};
for iField = 1 : length(heat_fields)
    field = heat_fields{iField};
    for iLayer = 1 : length(layers)
        layer = layers{iLayer};
        if iLayer == 1
            Results.Far_Crust.Heat_Power.Total.(field) = 0 .* Results.Far_Crust.Heat_Power.s1.(field);
        end
        Results.Far_Crust.Heat_Power.Total.(field) = Results.Far_Crust.Heat_Power.Total.(field) + Results.Far_Crust.Heat_Power.(layer).(field);
    end
end
clear heat_fields iField iLayer layer;

% ---------- Mantle Results ---------- %
fprintf('Recording mantle crust mass, signal rate and radiogenic heat power ...\n');
layers = {'DM', 'EM'};
len_layers = length(layers);
for iLayer = 1 : len_layers
    layer = layers{iLayer};

    % ----- Mass ----- %
    mass_field = {'Rock', 'U', 'U238', 'U235', 'Th'};
    for iField = 1 : length(mass_field)
        field = mass_field{iField};
        Results.Mantle.Mass.(layer).(field) = Output.Mantle.Mass.(layer).(field);
    end
    clear mass_field iField field;

    % ----- Signal Rate ----- %
    signal_fields = {'Total', 'U238', 'Th232'};
    for iField = 1 : length(signal_fields)
        field = signal_fields{iField};
        Results.Mantle.Geonu_Signal.(layer).(field) = Output.Mantle.Geonu_Signal.(layer).(field);
    end
    clear signal_fields iField field;

    % ----- Radiogenic Heat Power ----- %
    heat_fields = {'Total', 'U', 'U238', 'U235', 'Th'};
    for iField = 1 : length(heat_fields)
        field = heat_fields{iField};
        Results.Mantle.Heat_Power.(layer).(field) = Output.Mantle.Heat_Power.(layer).(field);
    end
end

layers = {'LM', 'DM', 'EM'};

% ----- Add up Mass ----- %
mass_fields = {'Rock', 'U', 'U238', 'U235', 'Th'};
for iField = 1 : length(mass_fields)
    field = mass_fields{iField};
    for iLayer = 1 : length(layers)
        layer = layers{iLayer};
        if iLayer == 1
            Results.Mantle.Mass.Total.(field) = 0.* Results.Mantle.Mass.LM.(field);
        end
        Results.Mantle.Mass.Total.(field) = Results.Mantle.Mass.Total.(field) + Results.Mantle.Mass.(layer).(field);
    end
end
clear mass_fields iField field iLayer layer;

% ----- Add up Signal Rate ----- %
signal_fields = {'Total', 'U238', 'Th232'};
for iField = 1 : length(signal_fields)
    field = signal_fields{iField};
    for iLayer = 1 : length(layers)
        layer = layers{iLayer};
        if iLayer == 1
            Results.Mantle.Geonu_Signal.Total.(field) = 0 .* Results.Mantle.Geonu_Signal.LM.(field);
        end
        Results.Mantle.Geonu_Signal.Total.(field) = Results.Mantle.Geonu_Signal.Total.(field) + Results.Mantle.Geonu_Signal.(layer).(field);
    end
end
clear signal_fields iField field iLayer layer;

% ----- Add up Radiogenic Heat Power ----- %
heat_fields = {'Total', 'U', 'U238', 'U235', 'Th'};
for iField = 1 : length(heat_fields)
    field = heat_fields{iField};
    for iLayer = 1 : length(layers)
        layer = layers{iLayer};
        if iLayer == 1
            Results.Mantle.Heat_Power.Total.(field) = 0 .* Results.Mantle.Heat_Power.LM.(field);
        end
        Results.Mantle.Heat_Power.Total.(field) = Results.Mantle.Heat_Power.Total.(field) + Results.Mantle.Heat_Power.(layer).(field);
    end
end
clear heat_fields iField field iLayer layer;
clear layers len_layers;