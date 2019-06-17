% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% GNB_Init initialize the class mean, class diagonal variance matrix and class prior prob.
%
function [class_mean_Init, class_var_Init, prior_Init] = GNB_Init(data, Labels)

No_of_class = length(unique(Labels));

class_mean_Init = zeros(No_of_class, size(data,2));
class_var_Init = cell(1,No_of_class);

for i = 1:No_of_class
        class_ind = find(Labels == i-1);
        class_mean_Init(i,:) = mean(data(class_ind,:),1);
        class_var = var(data(class_ind,:),1);
        class_var_Init{i} = diag([class_var]); % diagonal variance matrix
end

[counts,~] = hist(Labels,unique(Labels));
prior_Init = counts./sum(counts);

end
