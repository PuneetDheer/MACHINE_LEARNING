% SAMPLE SCRIPT FOR SEGMENTATION IN IMAGE USING K-MEANS
%
clear all

Image = imread('dp6.jpg');

data(:,1)=reshape(Image(:,:,1),[],1); % R channel flatten out in column 1
data(:,2)=reshape(Image(:,:,2),[],1); % G channel flatten out in column 2 
data(:,3)=reshape(Image(:,:,3),[],1); % B channel flatten out in column 3

%%
%[WCSS] = K_Means_Elbow(double(data), 15); % to find out appropriate number of clusters

%%

No_of_cluster = 4;
[Euclid_dist, Cluster_dist, Cluster_ind, NEWcentroid, Centroid_distance] = K_Means_PP(double(data), No_of_cluster);

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
xlabel('After Clustering','FontWeight','bold')

subplot(143)
imagesc(SEG_RGB_blackBKG)
xlabel('After Segmentation with Black BKG','FontWeight','bold')

subplot(144)
imagesc(SEG_RGB_whiteBKG)
xlabel('After Segmentation with White BKG','FontWeight','bold')

