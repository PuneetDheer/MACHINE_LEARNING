% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% TRain_Gaussian_NB_Classifier
%
% INPUT:
% data = column-wise data
% labels = labels vector (0 to K class)
%
% OUTPUT:
% Train_Post_Prob = Probability of each samples in each class by column wise
% Train_max_Post_Prob = Maximum Probability selected from 'Train_Post_Prob'
% Train_Pred_class = Predicted Class
% class_mean_Init = Class mean
% class_var_Init = Class diagonal variance Matrix
% prior_Init = Prior Probability
%
function [ Train_Post_Prob, Train_max_Post_Prob, Train_Pred_class, class_mean_Init, class_var_Init, prior_Init] = TRain_Gaussian_NB_Classifier(data,Labels)


[class_mean_Init, class_var_Init, prior_Init] = GNB_Init(data, Labels);


[ Train_Post_Prob ] = Posterier_Prob(data, class_mean_Init, class_var_Init, prior_Init);


[Train_max_Post_Prob, Train_Pred_class] = max(Train_Post_Prob,[],2);


Train_Pred_class = Train_Pred_class - 1; %just to match if classID starts with 0 to K classes

end

