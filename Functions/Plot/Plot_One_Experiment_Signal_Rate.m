function Plot_One_Experiment_Signal_Rate(File_path, Pic_dir, Plot)

Res = load(File_path);

[~, name, ~] = fileparts(File_path);

sig_lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
sig_mantle = Res.Output.Mantle.Geonu_Signal.Total.Total;
sig_total = sig_lith + sig_mantle;
sig_mantle = sig_mantle(sig_mantle ~= 0); % Drop 0 values %
sig_total = sig_total(sig_total ~= 0); % Drop 0 values %

% % ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ % %
data = 0 .* sig_lith;
res_mean = 0;
perror = 0;
nerror = 0;
if strcmp(Plot.Signal_Fit, 'Normal') || strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    data = sig_lith(:, 1);
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    data = log(sig_lith(:, 1));
end
pd = fitdist(data, 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(sig_lith, 'BinWidth', 1);
title("Geonu Signal Distribution for Lithosphere");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
if strcmp(Plot.Signal_Fit, 'Normal')
    res_mean = mean_value;
    perror = sigma;
    nerror = sigma;
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    res_mean = exp(mean_value);
    perror = exp(mean_value + sigma) - exp(mean_value);
    nerror = exp(mean_value) - exp(mean_value - sigma);
elseif strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    res_mean = mean(data);
    perror = std(data);
    nerror = std(data);
end
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', res_mean, perror, nerror);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
if Plot.Save
    pic_path = fullfile(Pic_dir, sprintf('Geonu_Signals_Lithosphere_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Signal_Rate] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ % %
if strcmp(Plot.Signal_Fit, 'Normal') || strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    data = sig_mantle(:, 1);
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    data = log(sig_mantle(:, 1));
end
pd = fitdist(data, 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(sig_mantle, 'BinWidth', 1);
title("Geonu Signal Distribution for Mantle");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
if strcmp(Plot.Signal_Fit, 'Normal')
    res_mean = mean_value;
    perror = sigma;
    nerror = sigma;
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    res_mean = exp(mean_value);
    perror = exp(mean_value + sigma) - exp(mean_value);
    nerror = exp(mean_value) - exp(mean_value - sigma);
elseif strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    res_mean = mean(data);
    perror = std(data);
    nerror = std(data);
end
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', res_mean, perror, nerror);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');

if Plot.Save
    pic_path = fullfile(Pic_dir, sprintf('Geonu_Signals_Lithosphere_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Signal_Rate] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ Total ~~~~~~~~~~~~~~~~~~~~ % %
if strcmp(Plot.Signal_Fit, 'Normal') || strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    data = sig_total(:, 1);
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    data = log(sig_total(:, 1));
end
pd = fitdist(data, 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(sig_total, 'BinWidth', 1);
title("Geonu Signal Distribution for Earth");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
if strcmp(Plot.Signal_Fit, 'Normal')
    res_mean = mean_value;
    perror = sigma;
    nerror = sigma;
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    res_mean = exp(mean_value);
    perror = exp(mean_value + sigma) - exp(mean_value);
    nerror = exp(mean_value) - exp(mean_value - sigma);
elseif strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    res_mean = mean(data);
    perror = std(data);
    nerror = std(data);
end
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', res_mean, perror, nerror);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
if Plot.Save
    pic_path = fullfile(Pic_dir, sprintf('Geonu_Signals_Total_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Signal_Rate] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ 238U ~~~~~~~~~~~~~~~~~~~~ % %
u238 = Res.Output.Lithosphere.Geonu_Signal.Total.U238 + Res.Output.Mantle.Geonu_Signal.Total.U238;
if strcmp(Plot.Signal_Fit, 'Normal') || strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    data = u238(:, 1);
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    data = log(u238(:, 1));
end
pd = fitdist(data, 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(u238, 'BinWidth', 1);
title("Geonu Signal Distribution for 238U");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
if strcmp(Plot.Signal_Fit, 'Normal')
    res_mean = mean_value;
    perror = sigma;
    nerror = sigma;
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    res_mean = exp(mean_value);
    perror = exp(mean_value + sigma) - exp(mean_value);
    nerror = exp(mean_value) - exp(mean_value - sigma);
elseif strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    res_mean = mean(data);
    perror = std(data);
    nerror = std(data);
end
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', res_mean, perror, nerror);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
if Plot.Save
    pic_path = fullfile(Pic_dir, sprintf('Geonu_Signals_238U_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Signal_Rate] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ 232Th ~~~~~~~~~~~~~~~~~~~~ % %
th232 = Res.Output.Lithosphere.Geonu_Signal.Total.Th232 + Res.Output.Mantle.Geonu_Signal.Total.Th232;
if strcmp(Plot.Signal_Fit, 'Normal') || strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    data = th232(:, 1);
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    data = log(th232(:, 1));
end
pd = fitdist(data, 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(th232, 'BinWidth', 1);
title("Geonu Signal Distribution for 232Th");
xlabel('Geonu Signal (TNU)');
ylabel('Entries');
xlim([0, 100]);
xticks(0:5:100);
grid on;
if strcmp(Plot.Signal_Fit, 'Normal')
    res_mean = mean_value;
    perror = sigma;
    nerror = sigma;
elseif strcmp(Plot.Signal_Fit, 'Log-Normal')
    res_mean = exp(mean_value);
    perror = exp(mean_value + sigma) - exp(mean_value);
    nerror = exp(mean_value) - exp(mean_value - sigma);
elseif strcmp(Plot.Signal_Fit, 'Mean&Deviation')
    res_mean = mean(data);
    perror = std(data);
    nerror = std(data);
end
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', res_mean, perror, nerror);
y_lim = ylim;
x_pos = 60;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
% text(X-value, Y_value) %
if Plot.Save
    pic_path = fullfile(Pic_dir, sprintf('Geonu_Signals_232Th_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Signal_Rate] Figure saved to: %s\n', pic_path);
end

end