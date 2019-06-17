% CODED BY : PUNEET DHEER
% DATE : 4-06-2019
% K_Means_Elbow
%
% INPUT:
% data = column-wise data
% No_of_cluster = Number of Cluster
%
% OUTPUT:
% WCSS = Within Cluster Sum of Squares Distance
%
function [WCSS] = K_Means_Elbow(data, NO_cluster)

for No_of_cluster = 1:NO_cluster
    fprintf("%i Cluster in progress \n", No_of_cluster)
    [Euclid_dist, within_Cluster_dist, Cluster_ind, NEWcentroid, Centroid_distance] = K_Means(data, No_of_cluster);
        
    for clusterIND = 1 : size(NEWcentroid,1)
        clustered_ind = find(Cluster_ind == clusterIND);
        error(1,clusterIND) = sum(within_Cluster_dist(clustered_ind).^2,1);
    end
        
    WCSS(1,No_of_cluster) = sum(error);
    WCSS(2,No_of_cluster) = No_of_cluster;
    
    clear error clustered_ind
    
end

    
    figure
    plot(WCSS(2,:),WCSS(1,:),'-o','linewidth',2)
    xlabel("Cluster No.")
    ylabel("Within Cluster Sum of Squares Distance")
    title("Elbow Plot")

end