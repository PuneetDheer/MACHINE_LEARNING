% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% Posterier_Prob calculate the probability of Class given the sample point
%
function [ Post_Prob ] = Posterier_Prob(data, class_mean_Init, class_var_Init, Prior_prob)

No_of_Class = size(class_mean_Init,1);

Numerator = zeros(length(data),No_of_Class);

for j = 1 : No_of_Class

    Numerator(:,j) = Prior_prob(j) * P_D_F_v1(data, class_mean_Init(j,:), class_var_Init{j});

end

Post_Prob = Numerator ./ sum(Numerator,2);

end