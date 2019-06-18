% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% Gaussian_Mixture_Model
%
% SAMPLE SCRIPT FOR SEGMENTATION IN IMAGE USING Gaussian_Mixture_Model
%
% Note: 
% 1) Try to re-run the program when you see some warning "sigular matrix
% or badly scaled". This happens when "a matrix is singular if it is not
% invertible".
% 2) Try to re-run if not satisfied by clustered result this happens
% because of random initialization of means and variance as well as try different threshold value.

clear all

Image = imread('d2.jpg');

data(:,1)=reshape(Image(:,:,1),[],1); % R channel flatten out in column 1
data(:,2)=reshape(Image(:,:,2),[],1); % G channel flatten out in column 2 
data(:,3)=reshape(Image(:,:,3),[],1); % B channel flatten out in column 3

%%
% Use any one of them 'kmeans' or 'randomC' or 'default' for random initialization of means and variance
% if it 'kmeans' then also initialize:
% a) 'wi' represents after some iteration mean and variance or covariance matrix will be calculated
% b) 'woi' represents mean and variance or covariance matrix will be calculated without iteration
% last parameter is GMM_thre represents the iteration will stopwhen Sum of EuclidD between New and 
% old cluster mean reaches less than or equal to the given threshold.

No_of_cluster = 5;

Init.a = 'kmeans';
Init.b = 'woi'; % comment Init.b if 'dafault' or 'randomC' was used in Init.a

[ New_cluster_mean, New_cluster_cov, Post_Prob, New_Prior_prob, log_likelihood, Centroid_distance, Point_max_prob, Cluster_ind ] = GMM(double(data), No_of_cluster, Init, 0.5);

Cluster_Map = reshape(Cluster_ind,size(Image,1),size(Image,2));

figure
imagesc(Cluster_Map)

maskImage = zeros(size(Image,1),size(Image,2));
maskImage = maskImage(:);

retain_Cluster = input('Enter Cluster Number to retain: ');

for i = 1 : length(retain_Cluster)
    Clustered = find(Cluster_ind == retain_Cluster(i));
    maskImage(Clustered) = 1;
end

maskImage = reshape(maskImage,size(Image,1),size(Image,2));

Rch = Image(:,:,1);
Gch = Image(:,:,2);
Bch = Image(:,:,3);

sR = maskImage.*double(Rch);
sG = maskImage.*double(Gch);
sB = maskImage.*double(Bch);

SEG_RGB_blackBKG = uint8(cat(3,sR,sG,sB));

idx = all(SEG_RGB_blackBKG == 0, 3);
SEG_RGB_whiteBKG = SEG_RGB_blackBKG;
SEG_RGB_whiteBKG(repmat(idx,[1,1,3])) = 255;

figure
subplot(141)
imagesc(Image)
xlabel('Original','FontWeight','bold')

subplot(142)
imagesc(Cluster_Map)
xlabel(sprintf('After Clustering (K = %d)',No_of_cluster),'FontWeight','bold')

subplot(143)
imagesc(SEG_RGB_blackBKG)
xlabel('After Segmentation with Black BKG','FontWeight','bold')

subplot(144)
imagesc(SEG_RGB_whiteBKG)
xlabel('After Segmentation with White BKG','FontWeight','bold')

