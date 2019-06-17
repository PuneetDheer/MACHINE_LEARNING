% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% TRain_Quadratic_Discriminant_Classifier
%
% INPUT:
% data = column-wise data
% labels = labels vector (0 to K class)
%
% OUTPUT:
% Train_Post_Prob = Probability of each samples in each class by column wise
% Train_max_Post_Prob = Maximum Probability selected from 'Train_Post_Prob'
% Train_max_dk = Maximum log of post_prob selected
% Train_Pred_class_dk = Predicted Class for log of post_prob
% Train_Pred_class = Predicted Class
% class_mean_Init = Class mean
% class_covar_Init = Class covariance Matrix
% prior_Init = Prior Probability
%
function [ Train_Post_Prob, Train_max_Post_Prob, Train_max_dk, Train_Pred_class_dk, Train_Pred_class, class_mean_Init, class_covar_Init, prior_Init] = TRain_Quadratic_Discriminant_Classifier(data,Labels)


[class_mean_Init, class_covar_Init, prior_Init] = QDC_Init(data, Labels);


[ Train_Post_Prob, dK ] = Posterier_Prob(data, class_mean_Init, class_covar_Init, prior_Init);


[Train_max_Post_Prob, Train_Pred_class] = max(Train_Post_Prob,[],2);


[Train_max_dk, Train_Pred_class_dk] = max(dK,[],2);


Train_Pred_class = Train_Pred_class - 1; %just to match if classID starts with 0 to K classes


Train_Pred_class_dk = Train_Pred_class_dk - 1; %just to match if classID starts with 0 to K classes


end

