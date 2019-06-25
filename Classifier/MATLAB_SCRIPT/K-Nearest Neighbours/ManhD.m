% CODED BY : PUNEET DHEER
% DATE : 20-06-2019
% ManhD : Manhattan distance
% 
function [Manhattan_distance] = ManhD(col_data,sample)

error = bsxfun(@minus,col_data,sample);

Manhattan_distance = sum(abs(error),2);

end
