function Plot_One_Experiment_Heat_Power(file_path, pic_dir, Plot)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : Plot_One_Experiment_Heat_Power.m
% Description     : Get statistical results
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - file_path   : Path to file
%
% Physical Units:
%   - Heat Power  : TW
%
% Created On      : 2025-04-08
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Res = load(file_path);
[~, name, ~] = fileparts(file_path);

% ~~~~~~~~~~~~~~~~~~~~ Radiogenic Power ~~~~~~~~~~~~~~~~~~~~ %
heat_lith = Res.Output.Lithosphere.Heat_Power.Total.Total .* 1e-12; % Unit: TW %
heat_mantle = Res.Output.Mantle.Heat_Power.Total.Total .* 1e-12; % Unit: TW %
heat_total = heat_lith + heat_mantle; % Unit: TW %
heat_mantle = heat_mantle(heat_mantle ~= 0);  % Drop 0 values %
heat_total = heat_total(heat_total ~= 0); % Drop 0 values %

% % ~~~~~~~~~~~~~~~~~~~~ Lithosphere ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(heat_lith(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(heat_lith, 'BinWidth', 0.5);
title("Radiogenic Power Distribution for Lithosphere");
xlabel('Radiogenic Power U+Th (TW)');
ylabel('Entries');
xlim([0, 50]);
xticks(0:2:50);
grid on;
parameter_tex = sprintf('Radiogenic Power\n %.2f_{-%.2f}^{+%.2f} TW', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 30;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
if Plot.Save
    pic_path = fullfile(pic_dir, sprintf('Heat_Power_Lithosphere_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Heat_Power] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ Mantle ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(heat_mantle(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(heat_mantle, 'BinWidth', 0.5);
title("Radiogenic Power Distribution for Mantle");
xlabel('Radiogenic Power U+Th (TW)');
ylabel('Entries');
xlim([0, 50]);
xticks(0:2:50);
grid on;
parameter_tex = sprintf('Radiogenic Power\n %.2f_{-%.2f}^{+%.2f} TW', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 30;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
if Plot.Save
    pic_path = fullfile(pic_dir, sprintf('Heat_Power_Mantle_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Heat_Power] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ Total ~~~~~~~~~~~~~~~~~~~~ % %
pd = fitdist(heat_total(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(heat_total, 'BinWidth', 0.5);
title("Radiogenic Power Distribution for Total");
xlabel('Radiogenic Power U+Th (TW)');
ylabel('Entries');
xlim([0, 50]);
xticks(0:2:50); 
grid on;
parameter_tex = sprintf('Radiogenic Power\n %.2f_{-%.2f}^{+%.2f} TW', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 30;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
if Plot.Save
    pic_path = fullfile(pic_dir, sprintf('Heat_Power_Total_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Heat_Power] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ U ~~~~~~~~~~~~~~~~~~~~ % %
u = Res.Output.Lithosphere.Heat_Power.Total.U + Res.Output.Mantle.Heat_Power.Total.U;
u = u .* 1e-12; % Unit: TW %
pd = fitdist(u(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(u, 'BinWidth', 0.5);
title("Radiogenic Power Distribution for U");
xlabel('Radiogenic Power (TW)');
ylabel('Entries');
xlim([0, 50]);
xticks(0:2:50);
grid on;
parameter_tex = sprintf('Radiogenic Power\n %.2f_{-%.2f}^{+%.2f} TW', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 30;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
if Plot.Save
    pic_path = fullfile(pic_dir, sprintf('Heat_Power_238U_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Heat_Power] Figure saved to: %s\n', pic_path);
end

% % ~~~~~~~~~~~~~~~~~~~~ 232Th ~~~~~~~~~~~~~~~~~~~~ % %
th = Res.Output.Lithosphere.Heat_Power.Total.Th + Res.Output.Mantle.Heat_Power.Total.Th;
th = th .* 1e-12; % Unit: TW %
pd = fitdist(th(:, 1), 'Normal');
mean_value = pd.mu;
sigma = pd.sigma;
figure;
histogram(th, 'BinWidth', 0.5);
title("Radiogenic Power Distribution for Th");
xlabel('Radiogenic Power (TW)');
ylabel('Entries');
xlim([0, 50]);
xticks(0:2:50);
grid on;
parameter_tex = sprintf('Radiogenic Power\n %.2f_{-%.2f}^{+%.2f} TW', mean_value, sigma, sigma);
y_lim = ylim;
x_pos = 30;
y_pos = y_lim(2) * 0.8;
text(x_pos, y_pos, parameter_tex, 'FontSize', 12, 'BackgroundColor', 'white', 'EdgeColor', 'black');
if Plot.Save
    pic_path = fullfile(pic_dir, sprintf('Heat_Power_232Th_%s.jpg', name));
    print(pic_path, '-djpeg', '-r500');
    fprintf('[Plot_One_Experiment_Heat_Power] Figure saved to: %s\n', pic_path);
end

end