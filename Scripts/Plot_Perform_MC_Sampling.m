tic;

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

% ---------- MC Sampling ---------- %
iteration = Plot.Times;
correlation_table = Generate_Random_Standard_Normal(iteration);
Signal_U238 = zeros(length(lookup), iteration);
Signal_Th232 = zeros(length(lookup), iteration);

for index = 1 : length(lookup)
    idx = find(Crust(:, 5) == index);
    len = length(idx);
    rock_density = lookup(index, 1);
    rock_density_error = lookup(index, 2);
    aU238 = lookup(index, 3);
    aU238_Perror = lookup(index, 4);
    aU238_Nerror = lookup(index, 5);
    aTh232 = lookup(index, 6);
    aTh232_Perror = lookup(index, 7);
    aTh232_Nerror = lookup(index, 8);
    gp_u238 = sum(Result.GP.U238(idx, 1));
    gp_th232 = sum(Result.GP.Th232(idx, 1));
   
    temp_density = Generate_Random_Normal(rock_density, rock_density_error, 0, correlation_table);
    temp_au238 = Generate_Random_Log_Normal(aU238, aU238_Perror, aU238_Nerror, 0, correlation_table);
    temp_ath232 = Generate_Random_Log_Normal(aTh232, aTh232_Perror, aTh232_Nerror, 0, correlation_table);
    
    Signal_U238(index, :) = temp_density .* temp_au238 .* gp_u238;
    Signal_Th232(index, :) = temp_density .* temp_ath232 .* gp_th232;

end
clear index type idx len;
clear rock_density rock_density_error;
clear aU238 aU238_Perror aU238_Nerror;
clear aTh232 aTh232_Perror aTh232_Nerror;
clear gp_u238 gp_th232;
clear temp_density temp_au238 temp_ath232;

% ---------- Rearrange Structure ---------- %
Names = { ...
    1, 'Tonalite/Tonalite gneiss'; ...
    2, 'Granite or granodiorite'; ...
    3, 'Central gneiss belt'; ...
    4, 'Sudbury igneous complex'; ...
    5, '(Meta) Volcanic rocks'; ...
    6, 'Huronian supergroup'; ...
    7, 'Palezoic sedimentary rocks'; ...
    8, 'UC'; ...
    9, 'MC'; ...
    10, 'LC'; ...
    11, 'Total'};
% ~~~~~ Signal: U238 ~~~~~ %
MC = Signal_U238(3, :);
LC = sum(Signal_U238(end - 1 : end, :), 1);
Signal_U238(6, :) = [];
Signal_U238(3, :) = [];
Signal_U238(end-1:end, :) = [];
UC = sum(Signal_U238(:, :), 1);
Signal_U238(end + 1, :) = UC;
Signal_U238(end + 1, :) = MC;
Signal_U238(end + 1, :) = LC;
Signal_U238(end + 1, :) = UC + MC + LC;
clear UC MC LC;

% ~~~~~ Signal: Th232 ~~~~~ %
MC = Signal_Th232(3, :);
LC = sum(Signal_Th232(end - 1 : end, :), 1);
Signal_Th232(6, :) = [];
Signal_Th232(3, :) = [];
Signal_Th232(end-1:end, :) = [];
UC = sum(Signal_Th232(:, :), 1);
Signal_Th232(end + 1, :) = UC;
Signal_Th232(end + 1, :) = MC;
Signal_Th232(end + 1, :) = LC;
Signal_Th232(end + 1, :) = UC + MC + LC;
clear UC MC LC;

% ---------- Plot ---------- %

% ~~~~~ U238 ~~~~~ %
figure('Visible', 'off', 'Units','pixels', 'Position', [100, 100, 1600, 1000]);  % Length and Height in ppx %);
len = length(Signal_U238(:, 1));
for i = 1:len
    subplot(2, 6, i);
    data = log(Signal_U238(i, :));

    % Normalization histogram %
    h = histogram(data, 'Normalization', 'pdf');
    hold on;
    
    % Fit %
    pd = fitdist(data', 'Normal');
    x_values = linspace(min(data), max(data), 200);
    y_values = pdf(pd, x_values);
    plot(x_values, y_values, 'r-', 'LineWidth', 2);
    
    % --- χ²/ndf --- %
    binCounts = h.BinCounts;
    binEdges = h.BinEdges;
    binWidth = binEdges(2) - binEdges(1);
    binCenters = binEdges(1:end-1) + binWidth/2;
    y_obs = binCounts / (sum(binCounts) * binWidth);
    y_fit = pdf(pd, binCenters);
    y_err = sqrt(binCounts) / (sum(binCounts) * binWidth);
    
    % Cut off bins with error = 0
    valid = y_err > 0;
    chi2 = sum(((y_obs(valid) - y_fit(valid)).^2) ./ (y_err(valid).^2));
    ndf = sum(valid) - 2;
    chi2ndf = chi2 / ndf;

    % Labels and Title
    xlabel('Log(Rate)');
    binWidth = h.BinWidth;
    ylabel(sprintf('Probability Density (bin width = %.3f)', binWidth));
    title(sprintf('%s', Names{i, 2}));
    grid on;

    xLimits = xlim;
    yLimits = ylim;
    ylim([yLimits(1), yLimits(2) * 1.3]);

    % Result Info
    if i == 5
        xpos = -2;
    elseif i == 7
        xpos = -0.5;
    else
        xpos = xLimits(2) * 0.9;
    end
    ypos = yLimits(2) * 1.25;
    text(xpos, ypos, ...
        sprintf('\\mu = %.2f, \\sigma = %.2f\nS_{Rate} = %.2f^{+%.2f}_{-%.2f} TNU\n\\chi^2/ndf = %.2f', ...
            pd.mu, pd.sigma, ...
            exp(pd.mu), exp(pd.mu+pd.sigma) - exp(pd.mu), exp(pd.mu) - exp(pd.mu-pd.sigma), ...
            chi2ndf), ...
        'HorizontalAlignment', 'right', ...
        'VerticalAlignment', 'top', ...
        'FontSize', 8, ...
        'BackgroundColor', 'w', ...
        'Interpreter', 'tex');
    hold off;
end
% Title for the whole pic %
t = annotation('textbox', [0, 0.95, 1, 0.05], 'String', ...
    sprintf('U238 Local Signals (%.0e)', iteration), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 14, 'FontWeight', 'bold', ...
    'EdgeColor', 'none');

[~, name, ~] = fileparts(file_path);
pic_path = fullfile(pic_dir, sprintf('Geonu_Signals_238U_Local_%s.jpg', name));
print(pic_path, '-djpeg', '-r500');

% ~~~~~ Th232 ~~~~~ %
figure('Visible', 'off', 'Units','pixels', 'Position', [100, 100, 1600, 1000]);  % Length and Height in ppx %);
len = length(Signal_Th232(:, 1));
for i = 1:len
    subplot(2, 6, i);
    data = log(Signal_Th232(i, :));

    % Normalization histogram %
    h = histogram(data, 'Normalization', 'pdf');
    hold on;
    
    % Fit %
    pd = fitdist(data', 'Normal');
    x_values = linspace(min(data), max(data), 200);
    y_values = pdf(pd, x_values);
    plot(x_values, y_values, 'r-', 'LineWidth', 2);
    
    % --- χ²/ndf --- %
    binCounts = h.BinCounts;
    binEdges = h.BinEdges;
    binWidth = binEdges(2) - binEdges(1);
    binCenters = binEdges(1:end-1) + binWidth/2;
    y_obs = binCounts / (sum(binCounts) * binWidth);
    y_fit = pdf(pd, binCenters);
    y_err = sqrt(binCounts) / (sum(binCounts) * binWidth);
    
    % Cut off bins with error = 0
    valid = y_err > 0;
    chi2 = sum(((y_obs(valid) - y_fit(valid)).^2) ./ (y_err(valid).^2));
    ndf = sum(valid) - 2;
    chi2ndf = chi2 / ndf;

    % Labels and Title
    xlabel('Log(Rate)');
    binWidth = h.BinWidth;
    ylabel(sprintf('Probability Density (bin width = %.3f)', binWidth));
    title(sprintf('%s', Names{i, 2}));
    grid on;

    xLimits = xlim;
    yLimits = ylim;
    ylim([yLimits(1), yLimits(2) * 1.4]);

    % Result Info
    if i == 2
        xpos = -0.3;
    elseif i == 4
        xpos = -1.1;
    elseif i == 5
        xpos = -2.8;
    elseif i == 7
        xpos = -3.7;
    else
        xpos = xLimits(2) * 0.9;
    end
    ypos = yLimits(2) * 1.35;
    text(xpos, ypos, ...
        sprintf('\\mu = %.2f, \\sigma = %.2f\nS_{Rate} = %.2f^{+%.2f}_{-%.2f} TNU\n\\chi^2/ndf = %.2f', ...
            pd.mu, pd.sigma, ...
            exp(pd.mu), exp(pd.mu+pd.sigma) - exp(pd.mu), exp(pd.mu) - exp(pd.mu-pd.sigma), ...
            chi2ndf), ...
        'HorizontalAlignment', 'right', ...
        'VerticalAlignment', 'top', ...
        'FontSize', 8, ...
        'BackgroundColor', 'w', ...
        'Interpreter', 'tex');
    hold off;
end
t = annotation('textbox', [0, 0.95, 1, 0.05], 'String', ...
    sprintf('Th232 Local Signals (%.0e)', iteration), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
    'FontSize', 14, 'FontWeight', 'bold', ...
    'EdgeColor', 'none');

[~, name, ~] = fileparts(file_path);
pic_path = fullfile(pic_dir, sprintf('Geonu_Signals_232Th_Local_%s.jpg', name));
print(pic_path, '-djpeg', '-r500');

% ---------- Clear Variables ---------- %

clear len i;
clear data h pd x_values y_values;
clear binCounts binEdges binWidth binCenters y_obs y_fit y_err;
clear valid chi2 ndf chi2ndf;
clear xLimits yLimits xpos ypos;
clear t name pic_path;

clear iteration lookup Names;
