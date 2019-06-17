% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% QDC_Init initialize the class mean, class covariance and class prior prob.
%
function [class_mean_Init, class_covar_Init, prior_Init] = QDC_Init(data, Labels)

No_of_class = length(unique(Labels));

class_mean_Init = zeros(No_of_class, size(data,2));
class_covar_Init = cell(1,No_of_class);

for i = 1:No_of_class
        class_ind = find(Labels == i-1);
        class_mean_Init(i,:) = mean(data(class_ind,:),1);
        class_covar = cov(data(class_ind,:)); 
        class_covar_Init{i} = class_covar; % separate covariance matrix for each class
end


[counts,~] = hist(Labels,unique(Labels));
prior_Init = counts./sum(counts);

end
