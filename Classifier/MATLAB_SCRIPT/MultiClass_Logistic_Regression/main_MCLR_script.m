% Coded by: Puneet Dheer
% Date: 1-May-2019
% main_MCLR_script
% 
% data_with_labels = column data with labelsID in last column, and labelsID start from 0 to K classes
%
function main_MCLR_script(data_with_labels)

[No_of_samples,~] = size(data_with_labels) ;
P = 0.70 ; %TRaining percent
Index = randperm(No_of_samples)  ;

Training_set = data_with_labels(Index(1:round( P * No_of_samples )),1:end-1) ;
Training_label = data_with_labels(Index(1:round( P * No_of_samples )),end) ;

Testing_set = data_with_labels(Index(round( P * No_of_samples )+1 : end),1:end-1) ;
Testing_label = data_with_labels(Index(round( P * No_of_samples )+1 : end),end) ;

%%
% without Regularization
fprintf('\n')

[Train_Cost_fun, Train_classes_weights]= Multi_Class_Logistic_Regression(Training_set, Training_label, 40000, 0.01);

fprintf('Training Done...\n')

%%
% with Regularization
% [Cost_fun, classes_weights]= Multi_Class_Logistic_Regression(data, y, 40000, 0.01, 'wR', 10);

%% One vs all...Individual Probability was normalized by the sum of all Prob along the class

[ Train_class_predicted, Train_max_prob_raw, Train_one_vs_all_prob_raw, Train_max_prob_Norm, Train_one_vs_all_prob_Norm ]= Prediction(Train_classes_weights, [ones(size(Training_set,1), 1) Training_set]);
Accuracy = mean(double(Train_class_predicted == Training_label)) * 100;
fprintf("Training Accuracy: %f percent\n",(Accuracy))

%% Softmax Classifier for training

linear_sum_scores = ([ones(size(Training_set,1), 1) Training_set] * Train_classes_weights);
Exp = exp(linear_sum_scores);
Softmax_prob = Exp./sum(Exp,2);
[Softmax_max_prob_raw, Softmax_class_predicted] = max(Softmax_prob,[],2);
Softmax_class_predicted = Softmax_class_predicted - 1; %just to match if classID starts with 0 to K classes
Accuracy = mean(double(Softmax_class_predicted == Training_label)) * 100;
fprintf("Softmax Training Accuracy: %f percent\n\n",(Accuracy))

%%
% Testing
tic

[ Test_class_predicted, Test_max_prob_raw, Test_one_vs_all_prob_raw, Test_max_prob_Norm, Test_one_vs_all_prob_Norm ]= Prediction(Train_classes_weights, [ones(size(Testing_set,1), 1) Testing_set]);

fprintf('Testing Done...')
toc

%%
Accuracy = mean(double(Test_class_predicted == Testing_label)) * 100;
fprintf("Testing Accuracy: %f percent\n",(Accuracy))

%% Softmax Classifier for testing

linear_sum_scores = ([ones(size(Testing_set,1), 1) Testing_set] * Train_classes_weights);
Exp = exp(linear_sum_scores);
Softmax_prob = Exp./sum(Exp,2);
[Softmax_max_prob_raw, Softmax_class_predicted] = max(Softmax_prob,[],2);
Softmax_class_predicted = Softmax_class_predicted - 1; %just to match if classID starts with 0 to K classes
Accuracy = mean(double(Softmax_class_predicted == Testing_label)) * 100;
fprintf("Softmax Testing Accuracy: %f percent\n\n",(Accuracy))

%%
% X = column data
% this in only for 2D plot (2 features)
tic
figure
subplot(131)
scatter(data_with_labels(:,1),data_with_labels(:,2),'filled','MarkerEdgeColor','k')
box on
xlabel ('Entire Dataset','FontWeight','bold')

%%%% FOR TRAINING SET %%%%
X = Training_set;
fprintf('Plotting Train Data... ')

X_axis = linspace(min(X(:,1)), max(X(:,1)), 500)';
Y_axis = linspace(min(X(:,2)), max(X(:,2)), 500)';
[X_axis_grid,Y_axis_grid] = meshgrid(sort(X_axis(:,1)),sort(Y_axis(:,1)));
feature_grid = [X_axis_grid(:),Y_axis_grid(:)];

bias_feature_grid = [ones(250000, 1) feature_grid];

grid_prediction = Prediction(Train_classes_weights, bias_feature_grid);

grid_prediction = reshape(grid_prediction,size(X_axis_grid));

subplot(132)
contourf(X_axis_grid, Y_axis_grid, grid_prediction);
hold on;
for i=1:length(unique(Training_label))
    scatter(Training_set(find(Training_label == i-1),1),Training_set(find(Training_label == i-1),2),'filled','MarkerEdgeColor','k')
end
xlabel ('Training Set','FontWeight','bold')
MAP = rand(length(unique(Training_label)),3);
colormap(MAP)

toc

%%
%%%% FOR TESTING SET %%%%
tic
X = Testing_set;
fprintf('Plotting Test Data... ')
X_axis = linspace(min(X(:,1)), max(X(:,1)), 500)';
Y_axis = linspace(min(X(:,2)), max(X(:,2)), 500)';
[X_axis_grid,Y_axis_grid] = meshgrid(sort(X_axis(:,1)),sort(Y_axis(:,1)));
feature_grid = [X_axis_grid(:),Y_axis_grid(:)];

bias_feature_grid = [ones(250000, 1) feature_grid];

grid_prediction = Prediction(Train_classes_weights, bias_feature_grid);

grid_prediction = reshape(grid_prediction,size(X_axis_grid));

subplot(133)
contourf(X_axis_grid, Y_axis_grid, grid_prediction);
hold on;
for i=1:length(unique(Testing_set))
    scatter(Testing_set(find(Testing_label == i-1),1),Testing_set(find(Testing_label == i-1),2),'filled','MarkerEdgeColor','k')
end
hold off
xlabel ('Testing Set','FontWeight','bold')
colormap(MAP)

toc
fprintf('Done... \n\n')

end