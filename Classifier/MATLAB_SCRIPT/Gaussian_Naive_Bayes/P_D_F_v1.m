% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% P_D_F_v1 : Probability Density Function
% 
function [ likelihood ] = P_D_F_v1(sample_points, cluster_mean, cluster_cov)

feature_dimension = size(sample_points,2);

X = bsxfun(@minus, sample_points, cluster_mean);

likelihood = (2 * pi) ^ (- feature_dimension / 2) * det(cluster_cov) ^ (-0.5) * exp(-0.5 * sum(bsxfun(@times, X * inv(cluster_cov), X), 2));

end

