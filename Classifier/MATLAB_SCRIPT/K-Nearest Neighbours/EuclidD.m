% CODED BY : PUNEET DHEER
% DATE : 20-06-2019
% EuclidD : Euclidean distance
% 
function [Euclid_distance] = EuclidD(col_data,sample)

error = bsxfun(@minus,col_data,sample);

Euclid_distance = (sqrt(sum(error.^2,2)));

end

