% ---------- BSE ---------- %
Geology.BSE.Correlation = 0 .* Geology.BSE.Correlation;
% ---------- Lithosphere ---------- %
% template = 0 .* Geology.Lithosphere.Model.Correlation.s1.Abundance;
% layers = {'s1', 's2', 's3', 'UC', 'MC', 'LC', 'LM'};
% for ii1 = 1 : length(layers)
%     layer = layers{ii1};
%     Geology.Lithosphere.Model.Correlation.(layer).Abundance = template;
%     Geology.Lithosphere.Model.Correlation.(layer).Thickness = template;
%     Geology.Lithosphere.Model.Correlation.(layer).Vp = template;
%     if strcmp(layer, 'MC') || strcmp(layer, 'LC')
%         Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.End.Abundance = template;
%         Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.End.Vp = template;
%         Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.Bivar.Abundance = template;
%         Geology.Lithosphere.Model.Correlation.(layer).DeepCrust.Bivar.SiO2 = template;
%     end
% end
% clear layers ii1 layer template;
% ---------- Mantle ---------- %
Geology.Mantle.Correlation = 0 .* Geology.Mantle.Correlation;

disp("The correlations have been setted to zero.")