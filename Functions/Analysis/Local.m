% ---------- UC ---------- %
names = {'Tonalite/Tonalite gneiss', 'Granite or granodiorite', 'Central gneiss belt',...
    'Sudbury igneous complex', '(Meta) volcanic rocks', 'Huronian supergroup',...
    'Palezoic sedimentary rock'};
indices = {1, 2, 4, 5, 6, 7, 8};
len_layers = length(indices);
for ii1 = 1 : len_layers
    index = indices{ii1};
    data = Local_Crust.Geonu_Signal.U238(:, index);
    pd = fitdist(log(data), 'Normal');
    fit_mean = pd.mu;
    fit_sigma = pd.sigma;
    res_mean = exp(fit_mean);
    res_perror = exp(fit_mean + fit_sigma) - exp(fit_mean);
    res_nerror = exp(fit_mean) - exp(fit_mean - fit_sigma);
    fprintf('%s: %.2f + %.2f \n', string(ii1), fit_mean, fit_sigma);
    fprintf('%s: %.2f + %.2f - %.2f TNU\n', string(ii1), res_mean, res_perror, res_nerror);
end
% ---------- MC ---------- %
% ---------- Total ---------- %