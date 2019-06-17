% Coded by: Puneet Dheer
% Date: 1-May-2019
%
% INPUT:
% Data = Column-wise data
% Labels = Class labels in integer format [should start from 0 to K classes]
% iteration = No. of epoch required to run the classifier
% learning_Rate = gradient steps (generally, 0.01 or 0.05)
% Regu = 'woR' (without regularization) or 'wR'(with regularization then 'alpha' should be entered )
% alpha = the parameter 'alpha' we can control the impact of the regularization term. 
%         Higher values lead to smaller coefficients, but too high values
%         for 'alpha' can lead to underfitting.
%
% OUTPUT:
% Cost_fun: Log-loss or cross-entropy
% Classes_weights = Weights of each class (each column represents a class,[first row is 'bias' and from 2nd rows are 'weights'])
%
function [Cost_fun, Classes_weights] = Multi_Class_Logistic_Regression(Data, Labels, iteration, learning_Rate, Regu, alpha)

tic

if nargin == 4 
    Regu = 'woR';
elseif nargin == 5 && ~exist('alpha','var') && strcmp('wR',Regu)
    fprintf("Please enter the alpha value: \n")
    alpha = input( 'Enter alpha: ' );
end

[samples, features] = size(Data);

Data = [ones(samples, 1) Data];

weights = zeros(features + 1, 1);

[uni,counts,ind] = unique(Labels);

one_vs_all_class = zeros(samples,length(uni));

classes = length(uni);

for i=1:classes
    fprintf("Multi_Class_Logit_Classifier No.: %i is in progress...",i)
    
    class_ind = find(uni(ind) == i-1);
    one_vs_all_class(class_ind,i) = 1;

    for iter = 1 : iteration

        if strcmp('woR',Regu)
            
            [Updated_Weights, Cost_fun(i,iter)] = LogitR_Cost_Function(weights, Data, one_vs_all_class(:,i), learning_Rate);
        
        elseif strcmp('wR',Regu)
            
            [Updated_Weights, Cost_fun(i,iter)] = LogitR_Cost_RidgeR_Function(weights, Data, one_vs_all_class(:,i), learning_Rate, alpha);
        
        end
        
        weights = Updated_Weights;

    end
    
    fprintf("Done \n")
    
    Classes_weights(:,i) = Updated_Weights;
    
    weights = zeros(features + 1, 1);
end

toc

end

