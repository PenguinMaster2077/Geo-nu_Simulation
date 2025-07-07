function GRIDSCAN_Final_Plot(data_dir, best_file_path, out_pic_path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name       : GRIDSCAN_Final_Plot.m
% Description     : Plot grid scan of oscillation parameter
%
% Original Author : Shuai Ouyang
% Institution     : Shandong University, CN
% Classification  : Original
%
% Input Parameters:
%   - data_dir       : Path to the data directory
%   - best_file_path : Path to file that record best values
%   - out_pic_path   : Path to output pictures
%
% Created On      : 2025-03-30
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ~~~~~~~~~~~~~~~~~~~~ Load Data ~~~~~~~~~~~~~~~~~~~~ % %
    % best_file_path = "./Output/GridScan/SNO+_4000_Crust1_Huang_7.41e-05_0.303_2025-03-28_17-08-34.mat";
    best_res = GRIDSCAN_Get_Value(best_file_path);
    clear best_file_path;
    
    % data_dir = "./Output/GridScan";
    files = dir(fullfile(data_dir, "*.mat"));
    file_paths = fullfile(data_dir, {files.name});
    clear data_dir files;
    res = zeros(length(file_paths), 5);
    len = length(file_paths(1, :));
    for ii1 = 1 : len
        if mod(ii1, 10) == 0 || ii1 == len
            fprintf('[GRIDSCAN_Final_Plot] Loading: %.2f%%\n', (1.0 * ii1/len) * 100);
        end
        file_path = file_paths(1, ii1);
        res(ii1, 1: 4) = GRIDSCAN_Get_Value(file_path);
        res(ii1, 5) = (res(ii1, 3) - best_res(1, 3)) / best_res(1, 3);
    end
    
    clear ii1 file_path;
    
% % ~~~~~~~~~~~~~~~~~~~~ Generate Mesh ~~~~~~~~~~~~~~~~~~~~ % %
    x = res(:, 1);
    y = res(:, 2);
    z = res(:, 5);
    z = 100 .* z;
    [Xq, Yq] = meshgrid(unique(x), unique(y));
    Zq = griddata(x, y, z, Xq, Yq, 'cubic');
    
% % ~~~~~~~~~~~~~~~~~~~~ Figure Size ~~~~~~~~~~~~~~~~~~~~ % %
    figure;
    set(gcf, 'Position', [0, 0, 1200, 800]); % [left-edge, top-edge, x-pixel, y-pixel] %
    
% % ~~~~~~~~~~~~~~~~~~~~ Color Plot ~~~~~~~~~~~~~~~~~~~~ % %
    pcolor(Xq, Yq, Zq);
    shading interp;
    colorbar; % Legend of color %
    
% % ~~~~~~~~~~~~~~~~~~~~ Best Point ~~~~~~~~~~~~~~~~~~~~ % %
    hold on;
    plot(best_res(1,1), best_res(1, 2), 'p', 'MarkerSize', 12, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');
    
% % ~~~~~~~~~~~~~~~~~~~~ Contour ~~~~~~~~~~~~~~~~~~~~ % %
    for ii1 = 0 : 20
        z_level = 0.1 * ii1;  % 👈 因为Zq现在是百分比，步长变为0.1%
        if z_level == 0
            [C, h] = contour(Xq, Yq, Zq, [z_level z_level], '--r', 'LineWidth', 1.5);
        else
            [C1, h1] = contour(Xq, Yq, Zq, [z_level z_level], '--k', 'LineWidth', 1.5);
            [C2, h2] = contour(Xq, Yq, Zq, [-z_level -z_level], '--k', 'LineWidth', 1.5);
            clabel(C1, h1, 'Fontsize', 10, 'Color', 'k', 'FontWeight', 'bold');
            clabel(C2, h2, 'Fontsize', 10, 'Color', 'k', 'FontWeight', 'bold');
        end
    end
    
% % ~~~~~~~~~~~~~~~~~~~~ Ticks ~~~~~~~~~~~~~~~~~~~~ % %
    xticks(linspace(min(x), max(x), 32));
    yticks(linspace(min(y), max(y), 16));
    ax = gca;
    ax.XMinorTick = 'on';
    ax.YMinorTick = 'on';
    ax.TickLength = [0.02, 0.02];
    ax.TickDir = 'in';
    ax.LineWidth = 1.2;
    ax.Layer = 'top';
    
% % ~~~~~~~~~~~~~~~~~~~~ Axis and Title ~~~~~~~~~~~~~~~~~~~~ % %
    xlabel('$\Delta m_{21}^2$', 'Interpreter', 'latex');
    ylabel('$\sin^2 \theta_{12}$', 'Interpreter', 'latex');
    title('Grid Scan: Relative Change from Best-Fit $(\Delta m_{21}^2, \sin^2 \theta_{12})$', 'Interpreter', 'latex');
    
    hold off;

% % ~~~~~~~~~~~~~~~~~~~~ Save Figure ~~~~~~~~~~~~~~~~~~~~ % %
    % print('./Pics/GRIDSCAN/Grid scan of Geonu Signal.jpg', '-djpeg', '-r500');
    print(out_pic_path, '-djpeg', '-r500');

end