% CODED BY : PUNEET DHEER
% DATE : 20-06-2019
% K-Nearest Neighbours
%
% INPUT:
% Train_col_data = column-wise data
% labels = labels vector (0 to K class) column-wise
% Test_col_samples = test data set colum-wise
% K = number of K nearest neighbours to be considered for classification
% d_Measure = Type of distance 'ED' for Euclidean distance OR 'ManHD' for Manhattan distance
%
% OUTPUT:
% Predicted_Labels = Predicted Class
%
function [Predicted_Labels] = K_NN( Train_col_data, Labels, Test_col_samples, K, d_Measure )

samples = length(Test_col_samples);

ID = unique(Labels);

if (mod(K,2) == 0)
    K = input('Please Enter the Odd number for K value: ');
end

for i = 1 : samples
    
    if strcmp(d_Measure,'ED')
        
        [Distance] = EuclidD(Train_col_data,Test_col_samples(i,:));
        
    elseif strcmp(d_Measure,'ManHD')
        
        [Distance] = ManhD(Train_col_data,Test_col_samples(i,:));
        
    end

    [~,indx] = sort(Distance);

    sorted_Labels = Labels(indx);

    [~,ind] = max(hist(sorted_Labels(1:K),0:length(ID)-1));
    
    Predicted_Labels(i,1) = ID(ind);

end

end
