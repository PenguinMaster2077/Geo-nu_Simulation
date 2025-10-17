function Plot_One_Experiment_Signal_Rate(File_path, Pic_dir, Plot)

Res = load(File_path);

[~, name, ~] = fileparts(File_path);

sig_lith = Res.Output.Lithosphere.Geonu_Signal.Total.Total;
sig_mantle = Res.Output.Mantle.Geonu_Signal.Total.Total;
sig_total = sig_lith + sig_mantle;
sig_mantle = sig_mantle(sig_mantle ~= 0); % Drop 0 values %
sig_total = sig_total(sig_total ~= 0); % Drop 0 values %

% % ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(sig_lith(:, 1), 'Normal');
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
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
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
pd = fitdist(sig_mantle(:, 1), 'Normal');
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
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
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
pd = fitdist(sig_total(:, 1), 'Normal');
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
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
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
pd = fitdist(u238(:, 1), 'Normal');
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
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
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
pd = fitdist(th232(:, 1), 'Normal');
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
parameter_tex = sprintf('Geonu Signal\n %.2f_{-%.2f}^{+%.2f} TNU', mean_value, sigma, sigma);
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