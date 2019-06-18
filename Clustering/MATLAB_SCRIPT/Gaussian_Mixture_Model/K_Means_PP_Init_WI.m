% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% 
% K_Means_PP_Init_WI: it will calculate mean and diagonal variance or
% covariance matrix for each cluster till it crosses the given threshold kmeans_th.
%
function [ Old_Cluster_mean, var_mat_Init, prior_Init ] = K_Means_PP_Init_WI(data, No_of_cluster, cov_matrix_type, kmeans_th)

Old_Cluster_mean(1,:) = data(randi([1,size(data,1)],1,1),:);

for i = 1:No_of_cluster-1
    D_error = bsxfun(@minus,data,Old_Cluster_mean(i,:));
    D2(:,i) = sum(D_error.^2,2);
    [~,large_Dist] = max(min(D2,[],2)./sum(min(D2,[],2)));
    Old_Cluster_mean(i+1,:) = data(large_Dist,:);
end


k = 1;

NEW_cluster_mean = zeros(size(Old_Cluster_mean));

error = bsxfun(@minus,NEW_cluster_mean,Old_Cluster_mean);

Centroid_distance(k) = sum(sqrt(sum(error.^2,2)));

while Centroid_distance(k) >= kmeans_th %threshold at which the iteration will stop
    
    for i = 1:No_of_cluster

        distance = bsxfun(@minus,data,Old_Cluster_mean(i,:));

        Euclid_dist(:,i) = sqrt(sum(distance.^2,2));

    end

        [within_Cluster_dist, Cluster_ind] = min(Euclid_dist,[],2);

        
    for i = 1:No_of_cluster

        clustered_ind = find(Cluster_ind == i);

        NEW_cluster_mean(i,:) = mean(data(clustered_ind,:),1);

    end
     
    k = k + 1;
    
    NEW_cluster_mean(isnan(NEW_cluster_mean)) = eps;
    
    error = bsxfun(@minus,NEW_cluster_mean,Old_Cluster_mean);
    
    Centroid_distance(k) = sum(sqrt(sum(error.^2,2)));
    
    Old_Cluster_mean = NEW_cluster_mean;
    
   
        
end
        
for i = 1:No_of_cluster

        clustered_ind = find(Cluster_ind == i);

        Var = cov(data(clustered_ind,:),1);

        if strcmp('var',cov_matrix_type)

            var_mat_Init{1,i} = diag(diag(Var)); % diagonal variance matrix

        elseif strcmp('cov',cov_matrix_type)

            var_mat_Init{1,i} = Var; % covariance matrix

        end

end

[counts,~] = hist(Cluster_ind,unique(Cluster_ind));
prior_Init = counts./sum(counts);

end