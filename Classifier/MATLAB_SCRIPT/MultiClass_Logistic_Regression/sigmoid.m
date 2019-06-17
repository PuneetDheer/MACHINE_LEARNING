% Coded by: Puneet Dheer
% Date: 1-May-2019
%
% SIGMOID functoon
% 
function [ pro ] = sigmoid(z)


pro = zeros(size(z));

pro = 1./(1 + exp(-1*z));

end
