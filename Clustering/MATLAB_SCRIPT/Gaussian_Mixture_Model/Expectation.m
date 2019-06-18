% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% 
% Expectation
%
function [ Post_Prob, log_likelihood ] = Expectation(data, Old_Cluster_mean, Cluster_cov, Prior_prob)

No_of_Cluster = size(Old_Cluster_mean,1);

   
for j = 1 : No_of_Cluster
        
    Numerator(:,j) = Prior_prob(j) * P_D_F_v1(data, Old_Cluster_mean(j,:), Cluster_cov{j});
    
end

Post_Prob = Numerator ./ sum(Numerator,2);

Post_Prob(isnan(Post_Prob))=0; %just to avoid NaN

temp = log(sum(Numerator,2));
temp(isnan(temp)) = eps; %just to avoid NaN
temp(isinf(temp)) = eps; %just to avoid Inf

log_likelihood = sum(temp);

end

