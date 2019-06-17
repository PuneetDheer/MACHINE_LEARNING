% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% Posterier_Prob calculate the probability of Class given the sample point
%
function [ Post_Prob, dK ] = Posterier_Prob(data, class_mean_Init, class_covar_Init, Prior_prob)

No_of_Class = size(class_mean_Init,1);

Numerator = zeros(length(data),No_of_Class);
A_temp = zeros(length(data),No_of_Class);
B_temp = zeros(length(data),No_of_Class);
dK = zeros(length(data),No_of_Class);

for j = 1 : No_of_Class

    Numerator(:,j) = Prior_prob(j) * P_D_F_v1(data, class_mean_Init(j,:), class_covar_Init{j});

    A_temp(:,j) = (-0.5 * sum(bsxfun(@times,data * inv(class_covar_Init{j}), data),2));

    B_temp(:,j) = sum(bsxfun(@times, data * inv(class_covar_Init{j}), class_mean_Init(j,:)), 2);

    C_temp = (-0.5 * sum(bsxfun(@times,class_mean_Init(j,:) * inv(class_covar_Init{j}) , class_mean_Init(j,:)),2));
    
    dK(:,j) =  A_temp(:,j) + B_temp(:,j) + C_temp + log(Prior_prob(j));

end


Post_Prob = Numerator ./ sum(Numerator,2);

end