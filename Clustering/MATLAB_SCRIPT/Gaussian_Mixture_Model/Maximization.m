% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% 
% Maximization
%
function [ New_cluster_mean, New_cluster_cov, Prior_prob ] = Maximization(data, Post_Prob, Old_Cluster_mean, Cluster_cov, Prior_prob)

No_of_datapoints = size(data,1);

No_of_Cluster = size(Old_Cluster_mean,1);

feature_dimension = size(data,2);

total_prob_across_clusters = sum(Post_Prob,1); 

Prior_prob = total_prob_across_clusters./sum(total_prob_across_clusters); %  the fraction of points allocated to particular cluster


for i = 1 : No_of_Cluster
    
    weighted_sample = zeros(1,feature_dimension);
    
    for j = 1 :  No_of_datapoints
        
        weighted_sample = weighted_sample + Post_Prob(j,i).* data(j,:);
    
    end
    
    New_cluster_mean(i,:) = weighted_sample / total_prob_across_clusters(i);
    
       
    weighted_cov = zeros(feature_dimension, feature_dimension);
    
    for j = 1 : No_of_datapoints
        
        COV = (data(j,:) - New_cluster_mean(i,:)).' * (data(j,:) - New_cluster_mean(i,:));
        weighted_cov = weighted_cov + (Post_Prob(j,i).* COV);
    
    end
    
    New_cluster_cov{i} = (weighted_cov + (eye(size(data,2))*1e-06) ) / total_prob_across_clusters(i);

end

end
%weighted_cov+(eye(size(data,2))*1e-06)
