% -------------------- Crust -------------------- %
disp("Loading UC ...");
file_path = "E:\Data\Geology\H14\Upper_crust\uc_xyzg_GEO.txt";
fid = fopen(file_path, 'r');
raw = fread(fid, Inf, '*char')';  
fclose(fid);
Upper_Crust = sscanf(raw, '%f %f %f %f', [4 Inf])';
Upper_Crust = flipud(Upper_Crust);
Upper_Crust(:, 6) = 0;

disp("Loading MC ...");
file_path = "E:\Data\Geology\H14\Middle_crust\mc_xyzg_GEO.txt";
fid = fopen(file_path, 'r');
raw = fread(fid, Inf, '*char')';  
fclose(fid);
Middle_Crust = sscanf(raw, '%f %f %f %f', [4 Inf])';
Middle_Crust = flipud(Middle_Crust);
Middle_Crust(:, 6) = 0;

disp("Loading LC ...");
file_path = "E:\Data\Geology\H14\Lower_crust\lc12_xyzg_GEO.txt";
fid = fopen(file_path, 'r');
raw = fread(fid, Inf, '*char')';  
fclose(fid);
Lower_Crust = sscanf(raw, '%f %f %f %f', [5 Inf])';
Lower_Crust = flipud(Lower_Crust);

disp("Loading complete!")
clear file_path fid raw;

% % ---------- Compute center depth and half-thickness ---------- % %
    lat = Upper_Crust(:, 1);
    Upper_Crust(:, 1) = Upper_Crust(:, 2);
    Upper_Crust(:, 2) = lat;
    type_rock = Upper_Crust(:, 4);
    Upper_Crust(:, 3) = Upper_Crust(:, 3) + 50; % Unit: m
    Upper_Crust(:, 4) = 50; % Unit: m
    Upper_Crust(:, 5) = type_rock;
    Upper_Crust = sortrows(Upper_Crust, 3, 'descend');
    clear lat type_rock;

    lat = Middle_Crust(:, 1);
    Middle_Crust(:, 1) = Middle_Crust(:, 2);
    Middle_Crust(:, 2) = lat;
    type_rock = Middle_Crust(:, 4);
    Middle_Crust(:, 3) = Middle_Crust(:, 3) + 50; % Unit: m
    Middle_Crust(:, 4) = 50; % Unit: m
    Middle_Crust(:, 5) = type_rock;
    Middle_Crust = sortrows(Middle_Crust, 3, 'descend');
    clear lat type_rock;
    
    lat = Lower_Crust(:, 1);
    Lower_Crust(:, 1) = Lower_Crust(:, 2);
    Lower_Crust(:, 2) = lat;
    type_rock = Lower_Crust(:, 4);
    vp = Lower_Crust(:, 5);
    Lower_Crust(:, 3) = Lower_Crust(:, 3) + 50; % Unit: m
    Lower_Crust(:, 4) = 50; % Unit: m
    Lower_Crust(:, 5) = type_rock;
    Lower_Crust(:, 6) = vp;
    Lower_Crust = sortrows(Lower_Crust, 3, 'descend');
    clear lat type_rock vp;

Crust = [Upper_Crust; Middle_Crust; Lower_Crust];
Crust = sortrows(Crust, 3, 'descend');

clear lookup;