% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% 
% Random_Init: randomly assign cluster index and then calculate mean and
% diagonal variance matrix for each cluster.
%
function [cluster_mean_Init, cluster_var_Init, prior_Init] = Random_Init(data, No_of_cluster)

Random_cluster_ind = randi([1,No_of_cluster],size(data,1),1);

for i = 1:No_of_cluster
        clustered_ind = find(Random_cluster_ind == i);
        cluster_mean_Init(i,:) = mean(data(clustered_ind,:),1);
        cluster_var = var(data(clustered_ind,:),1);
        cluster_var_Init{i} = diag([cluster_var]); % diagonal variance matrix
end

[counts,~] = hist(Random_cluster_ind,unique(Random_cluster_ind));
prior_Init = counts./sum(counts);

end
