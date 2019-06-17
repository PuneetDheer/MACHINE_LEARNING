% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% LDC_Init initialize the class mean, common covariance matrix and class prior prob.
%
function [class_mean_Init, common_covar_Init, prior_Init] = LDC_Init(data, Labels)

No_of_class = length(unique(Labels));

class_mean_Init = zeros(No_of_class, size(data,2));
common_covar_Init = zeros(size(data,2));

for i = 1:No_of_class
        class_ind = find(Labels == i-1);
        class_mean_Init(i,:) = mean(data(class_ind,:),1);
        scatter_mat = (length(class_ind)-1) * cov(data(class_ind,:)); % WITHIN SCATTER MATRIX
        common_covar_Init = common_covar_Init + scatter_mat;
end

common_covar_Init = common_covar_Init / (length(data)-No_of_class);

[counts,~] = hist(Labels,unique(Labels));
prior_Init = counts./sum(counts);

end
