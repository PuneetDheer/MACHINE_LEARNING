% CODED BY : PUNEET DHEER
% DATE : 04-06-2019
% main_GNB_script
%
% data_with_labels = column data with labelsID in last column, and labelsID start from 0 to K classes
% 
function main_GNB_script(data_with_labels)

[No_of_samples,~] = size(data_with_labels) ;
P = 0.70 ; %TRaining percent
Index = randperm(No_of_samples)  ;

Training_set = data_with_labels(Index(1:round( P * No_of_samples )),1:end-1) ;
Training_label = data_with_labels(Index(1:round( P * No_of_samples )),end) ;

Testing_set = data_with_labels(Index(round( P * No_of_samples )+1 : end),1:end-1) ;
Testing_label = data_with_labels(Index(round( P * No_of_samples )+1 : end),end) ;


%%
% TRain GNB_classfier
fprintf('\n')
tic
[ Train_Post_Prob, Train_max_Post_Prob, Train_Pred_class, class_mean_Init, class_var_Init, prior_Init] = TRain_Gaussian_NB_Classifier(Training_set,Training_label);

fprintf('Training Done...')
toc

%%
% TRain Accuracy
Accuracy = mean(double(Train_Pred_class == Training_label)) * 100;
fprintf("Train Accuracy: %f percent \n\n",(Accuracy))
fprintf('\n')

%%
% Testing
tic

[ Test_Post_Prob ] = Posterier_Prob(Testing_set, class_mean_Init, class_var_Init, prior_Init);

[Test_max_Post_Prob, Test_Pred_class] = max(Test_Post_Prob,[],2);

Test_Pred_class = Test_Pred_class - 1; %just to match if classID starts with 0 to K classes

fprintf('Testing Done...')
toc

%%
% Test Accuracy
Accuracy = mean(double(Test_Pred_class == Testing_label)) * 100;
fprintf("Test Accuracy: %f percent \n\n",(Accuracy))
fprintf('\n')

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

[ GRid_Post_Prob ] = Posterier_Prob(feature_grid, class_mean_Init, class_var_Init, prior_Init);

[grid_max_Post_Prob, grid_prediction] = max(GRid_Post_Prob,[],2);

grid_prediction = grid_prediction - 1; %just to match if classID starts with 0 to K classes

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

[ GRid_Post_Prob ] = Posterier_Prob(feature_grid, class_mean_Init, class_var_Init, prior_Init);

[grid_max_Post_Prob, grid_prediction] = max(GRid_Post_Prob,[],2);

grid_prediction = grid_prediction - 1; %just to match if classID starts with 0 to K classes

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