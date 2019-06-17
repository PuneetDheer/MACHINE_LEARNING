% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% K_Means
%
% INPUT:
% data = column-wise data
% No_of_cluster = Number of Cluster
% Dimension = for plotting purpose '2D' or '3D' only or leave it blank
%
% OUTPUT:
% Euclid_dist = distance of all data points from each clusters (column wise)
% within_Cluster_dist = minimum distance from 'Euclid_dist' (corresponding cluster index given in "CLuster_ind")
% Cluster_ind = assigned cluster number for all data points
% NEWcentroid = updated centroid values
% Centroid_distance = centroid distance after each iteration
%
% USAGE:
% [Euclid_dist, within_Cluster_dist, Cluster_ind, NEWcentroid, Centroid_distance] = K_Means(data, 4, '2D')
% [Euclid_dist, within_Cluster_dist, Cluster_ind, NEWcentroid, Centroid_distance] = K_Means(data, 4, '3D')
% 
function [Euclid_dist, within_Cluster_dist, Cluster_ind, NEWcentroid, Centroid_distance] = K_Means(data, No_of_cluster, Dimension)


OLDcentroid = data(randi([1,size(data,1)],No_of_cluster,1),:);

k = 1;

NEWcentroid = zeros(size(OLDcentroid));

error = bsxfun(@minus,NEWcentroid,OLDcentroid);

Centroid_distance(k) = sum(sqrt(sum(error.^2,2)));

if exist('Dimension','var') && strcmp('2D', Dimension) 
    
    K_Means_Plot('frame_1', '2D', data(:,1), data(:,2), [], OLDcentroid(:,1), OLDcentroid(:,2), [], [])
    
    Gif_maker('frame_1')
    
elseif exist('Dimension','var') && strcmp('3D', Dimension) 
    
    K_Means_Plot('frame_1', '3D', data(:,1), data(:,2), data(:,3), OLDcentroid(:,1), OLDcentroid(:,2), OLDcentroid(:,3), [])
    
    Gif_maker('frame_1')
    
elseif ~exist('Dimension','var')
    
end


iter = 1;

while Centroid_distance(k) ~= 0
    
    
    for i = 1 : No_of_cluster
        
        distance = bsxfun(@minus,data,OLDcentroid(i,:));
        
        Euclid_dist(:,i) = sqrt(sum(distance.^2,2));
        
    end

    [within_Cluster_dist, Cluster_ind] = min(Euclid_dist,[],2);

    for i = 1 : No_of_cluster
        
        clustered_ind = find(Cluster_ind == i);
        
        NEWcentroid(i,:) = mean(data(clustered_ind,:),1);
        
        if exist('Dimension','var') && strcmp('2D', Dimension)
            
            K_Means_Plot('frame_onwards', '2D', data(clustered_ind,1), data(clustered_ind,2), [], NEWcentroid(i,1), NEWcentroid(i,2), [], iter)
        
        elseif exist('Dimension','var') && strcmp('3D', Dimension) 
            
            K_Means_Plot('frame_onwards', '3D', data(clustered_ind,1), data(clustered_ind,2), data(clustered_ind,3), NEWcentroid(i,1), NEWcentroid(i,2), NEWcentroid(i,3), iter)
       
        elseif ~exist('Dimension','var')
            
        end
        
                     
    end
    
    if exist('Dimension','var')
        Gif_maker('frame_onwards')
    end

        
    k = k + 1;
    
    NEWcentroid(isnan(NEWcentroid)) = eps;
    
    error = bsxfun(@minus,NEWcentroid,OLDcentroid);
    
    Centroid_distance(k) = sum(sqrt(sum(error.^2,2)));
    
    OLDcentroid = NEWcentroid;
    
    iter = iter + 1;  
end

end
