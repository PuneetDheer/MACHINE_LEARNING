% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% TRain_Linear_Discriminant_Classifier
%
% INPUT:
% data = column-wise data
% labels = labels vector (0 to K class)
%
% OUTPUT:
% Train_Post_Prob = Probability of each samples in each class by column wise
% Train_max_Post_Prob = Maximum Probability selected from 'Train_Post_Prob'
% Train_max_dK = Maximum log of post_prob selected
% Train_Pred_class_dK = Predicted Class for log of post_prob
% Train_Pred_class = Predicted Class for post_prob
% class_mean_Init = Class mean
% common_covar_Init = Common covariance Matrix
% prior_Init = Prior Probability
%
function [ Train_Post_Prob, Train_max_Post_Prob, Train_max_dK, Train_Pred_class_dK, Train_Pred_class, class_mean_Init, common_covar_Init, prior_Init] = TRain_Linear_Discriminant_Classifier(data,Labels)


[class_mean_Init, common_covar_Init, prior_Init] = LDC_Init(data, Labels);


[ Train_Post_Prob, dK ] = Posterier_Prob(data, class_mean_Init, common_covar_Init, prior_Init);


[Train_max_Post_Prob, Train_Pred_class] = max(Train_Post_Prob,[],2);


[Train_max_dK, Train_Pred_class_dK] = max(dK,[],2);


Train_Pred_class = Train_Pred_class - 1; %just to match if classID starts with 0 to K classes


Train_Pred_class_dK = Train_Pred_class_dK - 1; %just to match if classID starts with 0 to K classes


end

