% Coded by: Puneet Dheer
% Date: 1-May-2019
%
% This function update the weights during backward pass with Ridge Regularization.
%
function [Updated_Weights, Cost_fun] = LogitR_Cost_RidgeR_Function(weights, data, labels, learning_Rate, alpha)


samples = length(data); 

weight_gradient = zeros(size(weights));

Updated_Weights = weights;

prob = sigmoid (data * weights);

Ridge_Reg = (alpha / (2 * samples)) * sum(weights(2:end).^2);

Cost_fun = (-1 / samples) * sum(labels.*log( prob + eps ) + (1 - labels).*log(1 - prob + eps)) + Ridge_Reg;

error = prob - labels; %predicted-groundTruth

weight_gradient = (1 / samples) * (data' * error) + ((alpha / samples) * sum(weights(2:end)));

Updated_Weights = Updated_Weights - learning_Rate * weight_gradient;



end

