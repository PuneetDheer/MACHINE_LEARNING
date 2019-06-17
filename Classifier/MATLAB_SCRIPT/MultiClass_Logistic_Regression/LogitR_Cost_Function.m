% Coded by: Puneet Dheer
% Date: 1-May-2019
%
% This function update the weights during backward pass.
%
function [Updated_Weights, Cost_fun] = LogitR_Cost_Function(weights, data, labels, learning_Rate)


samples = length(data); 

weight_gradient = zeros(size(weights));

Updated_Weights = weights;

prob = sigmoid (data * weights);

Cost_fun = (-1 / samples) * sum(labels.*log( prob + eps ) + (1 - labels).*log(1 - prob + eps));

error = prob - labels;

weight_gradient = (1 / samples) * (data' * error); 

Updated_Weights = Updated_Weights - learning_Rate * weight_gradient;



end

