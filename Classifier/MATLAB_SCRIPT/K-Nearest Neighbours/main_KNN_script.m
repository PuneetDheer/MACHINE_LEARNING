% CODED BY : PUNEET DHEER
% DATE : 20-06-2019
% main_KNN_script
%
% data_with_labels = column data with labelsID in last column, and labelsID start from 0 to N classes
% K = Note: Try to use odd number for K-values to avoid the equal number of class assignment.
% d_Measure = Type of distance 'ED' for Euclidean distance OR 'ManHD' for Manhattan distance
% 
% usage: main_KNN_script(classes4data,15,'ED') OR main_KNN_script(classes4data,15,'ManHD')
%
function main_KNN_script(data_with_labels, K, d_Measure)

if (mod(K,2) == 0)
    K = input('Please Enter the Odd number for K value: ');
end

[No_of_samples,~] = size(data_with_labels) ;
P = 0.70 ; %TRaining percent
Index = randperm(No_of_samples)  ;

Training_set = data_with_labels(Index(1:round( P * No_of_samples )),1:end-1) ;
Training_label = data_with_labels(Index(1:round( P * No_of_samples )),end) ;

Testing_set = data_with_labels(Index(round( P * No_of_samples )+1 : end),1:end-1) ;
Testing_label = data_with_labels(Index(round( P * No_of_samples )+1 : end),end) ;


%%
% KNN_classifier
fprintf('\n')
tic
[Train_Pred_class] = K_NN( Training_set, Training_label, Training_set, K, d_Measure );

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

[Test_Pred_class] = K_NN( Training_set, Training_label, Testing_set, K, d_Measure );

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

X_axis = linspace(min(X(:,1)), max(X(:,1)), 300)';
Y_axis = linspace(min(X(:,2)), max(X(:,2)), 300)';
[X_axis_grid,Y_axis_grid] = meshgrid(sort(X_axis(:,1)),sort(Y_axis(:,1)));
feature_grid = [X_axis_grid(:),Y_axis_grid(:)];

[grid_prediction] = K_NN( Training_set, Training_label, feature_grid, K, d_Measure );

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
X_axis = linspace(min(X(:,1)), max(X(:,1)), 300)';
Y_axis = linspace(min(X(:,2)), max(X(:,2)), 300)';
[X_axis_grid,Y_axis_grid] = meshgrid(sort(X_axis(:,1)),sort(Y_axis(:,1)));
feature_grid = [X_axis_grid(:),Y_axis_grid(:)];

[grid_prediction] = K_NN( Training_set, Training_label, feature_grid, K, d_Measure );

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