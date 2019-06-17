% Coded by: Puneet Dheer
% Date: 1-May-2019
%
% Prediction function
%
function [ class_predicted, max_prob_raw, one_vs_all_prob_raw, max_prob_Norm, one_vs_all_prob_Norm ] = Prediction(weights, data)
% data = [1 X1 X2 ... Xn]

one_vs_all_prob_raw = sigmoid(data * weights);

one_vs_all_prob_Norm = one_vs_all_prob_raw./sum(one_vs_all_prob_raw,2);

max_prob_Norm = max(one_vs_all_prob_Norm,[],2);

[max_prob_raw, class_predicted] = max(one_vs_all_prob_raw,[],2);

class_predicted = class_predicted - 1; %just to match with if class is assigned form 0 to K otherwise comment this line

end