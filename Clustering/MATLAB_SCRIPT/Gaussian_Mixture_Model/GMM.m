% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% Gaussian_Mixture_Model
%
% INPUT:
% data = column-wise data
% No_of_cluster = Number of Cluster
% Init = Initialization of mean and variance using 
%        (1)'kmeans' => kmeans++ 1st initialization or after some iteration to find out mean, variance
%        using 'cov' or 'var' and prior prob... where 'cov' for covariance matrix and 'var'
%        for diagonal variance matrix.
%        (2)'randaomC' => randomly assign clusterID and then calculate
%        mean, diagonal variance matrix and prior prob.
%        (3)'default' => select any point from data as a mean of cluster, Identity matrix
%        as a covariance matrix and prior prob will be 1/no_of_cluster 
% GMM_Thre = use 1 or 0.5 or 0.01 or 0.001 or anything at which the iteration will stop 
% when Sum of EuclidD between New and old cluster mean reaches less than or equal to the given threshold
% Dimension = for plotting purpose '2D' or '3D' only or leave it blank not to plot
%
% OUTPUT:
% New_cluster_mean = mean of each cluster (row wise) 
% New_cluster_cov = covariance of each cluster (cell wise)
% Post_Prob = Posterior probability of each data points for each clusters
% (column represents clusters and row represents probability of each data points in each clusters)
% New_Prior_prob = updated prior probablity for each cluster
% log_likelihood = at each step of iteration, the log_likelihood increases and then later on it stabilizes.
% Centroid_distance = track the centroid converge
% Point_max_prob = maximum Posterior probability from 'Post_Prob'
% Cluster_ind = clusterID assigned based on max Posterior probability.
%
% USAGE:
% Init.a = 'kmeans';
% Init.b = 'woi'; % comment Init.b if 'dafault' or 'randomC' was used in Init.a
% [ New_cluster_mean, New_cluster_cov, Post_Prob, New_Prior_prob, log_likelihood, Centroid_distance, Point_max_prob, Cluster_ind ] = GMM(double(data), 4, Init, 1, '2D')
% [ New_cluster_mean, New_cluster_cov, Post_Prob, New_Prior_prob, log_likelihood, Centroid_distance, Point_max_prob, Cluster_ind ] = GMM(double(data), 4, Init, 0.001)
% 
% Note: Try to re-run the program when you see some warning "sigular matrix
% or badly scaled". This happens when "a matrix is singular if it is not
% invertible" or can try with other threshold if result is not promising
%
function [ New_cluster_mean, New_cluster_cov, Post_Prob, New_Prior_prob, log_likelihood, Centroid_distance, Point_max_prob, Cluster_ind ] = GMM(data, No_of_cluster, Init, GMM_Thre, Dimension)

if strcmp('kmeans',Init.a)
    if strcmp('wi',Init.b)
        %set the last threshold parameter for kmeans, here it is 1
        [ Old_Cluster_mean, Old_Cluster_cov, Old_Prior_prob ] = K_Means_PP_Init_WI(data,No_of_cluster,'var', 1); % 'cov' or 'var'...with iteration
    elseif strcmp('woi',Init.b)
        [ Old_Cluster_mean, Old_Cluster_cov, Old_Prior_prob ] = K_Means_PP_Init_WOI(data,No_of_cluster,'cov');% 'cov' or 'var'... without iteration
    end
    
elseif strcmp('randomC',Init.a)
    [ Old_Cluster_mean, Old_Cluster_cov, Old_Prior_prob ] = Random_Init(data, No_of_cluster);

elseif strcmp('dafault',Init.a)
    Old_Cluster_mean = data(randi([1,size(data,1)],No_of_cluster,1),:);
    Old_Cluster_cov = repmat({eye(size(data,2))},1,No_of_cluster);
    Old_Prior_prob = repmat(1/No_of_cluster,1,No_of_cluster);
end

New_cluster_mean = zeros(size(Old_Cluster_mean));

error = bsxfun(@minus,New_cluster_mean,Old_Cluster_mean);

Centroid_distance = sum(sqrt(sum(error.^2,2)));


if exist('Dimension','var') && strcmp('2D', Dimension) 
    
    GMM_Plot('frame_1', '2D', data(:,1), data(:,2), [], Old_Cluster_mean(:,1), Old_Cluster_mean(:,2), [], [])
    
    Gif_maker('frame_1')
    
elseif exist('Dimension','var') && strcmp('3D', Dimension) 
    
    GMM_Plot('frame_1', '3D', data(:,1), data(:,2), data(:,3), Old_Cluster_mean(:,1), Old_Cluster_mean(:,2), Old_Cluster_mean(:,3), [])
    
    Gif_maker('frame_1')
    
elseif ~exist('Dimension','var')
    
end


iter = 1;
while Centroid_distance(iter) >= GMM_Thre
    
    fprintf('Iteration: %d \n',iter)
    fprintf('Sum of EuclidD between New and old cluster mean : %f \n',Centroid_distance(iter)) %within clustered sum of squared
    
    [ Post_Prob, log_likelihood(iter) ] = Expectation(data, Old_Cluster_mean, Old_Cluster_cov, Old_Prior_prob);
       
    [ New_cluster_mean, New_cluster_cov, New_Prior_prob ] = Maximization(data, Post_Prob, Old_Cluster_mean, Old_Cluster_cov, Old_Prior_prob);
    
    [ Point_max_prob, Cluster_ind ] = max(Post_Prob,[],2);
    
    iter = iter + 1;
    
    error = bsxfun(@minus,New_cluster_mean,Old_Cluster_mean);

    Centroid_distance(iter) = sum(sqrt(sum(error.^2,2)));
    
    for i = 1:No_of_cluster
        
        clustered_ind = find(Cluster_ind == i);
        
        if exist('Dimension','var') && strcmp('2D', Dimension)
            
            GMM_Plot('frame_onwards', '2D', data(clustered_ind,1), data(clustered_ind,2), [], New_cluster_mean(i,1), New_cluster_mean(i,2), [], iter)
        
        elseif exist('Dimension','var') && strcmp('3D', Dimension) 
            
            GMM_Plot('frame_onwards', '3D', data(clustered_ind,1), data(clustered_ind,2), data(clustered_ind,3), New_cluster_mean(i,1), New_cluster_mean(i,2), New_cluster_mean(i,3), iter)
       
        elseif ~exist('Dimension','var')
            
        end

    end
    
    
    if exist('Dimension','var')
        Gif_maker('frame_onwards')
    end
    

    Old_Cluster_mean = New_cluster_mean;
    Old_Cluster_cov = New_cluster_cov;
    Old_Prior_prob = New_Prior_prob;
end

% uncomment or comment when it necessary to plot gaussian shape over the
% clustered points and it is only for 2D
% 
% for i = 1 : No_of_cluster
%     fprintf("Visual Contour is fitting for cluster No: %i \n",i)
%     shape_G2D_Fit(data, New_cluster_mean(i,:), New_cluster_cov{i})
% end
% box on

if exist('Dimension','var')
    Gif_maker('frame_onwards')
end

end