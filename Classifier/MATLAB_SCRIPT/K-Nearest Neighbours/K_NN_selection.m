% CODED BY : PUNEET DHEER
% DATE : 20-06-2019
% K_NN_selection : To find out the required number of 'K' value
% Note: Try to use odd number for K-values to avoid the equal number of
% class assignment.
%
% usage :
% [Accuracy, Miss_classification] = K_NN_selection(classes4data(:,1:end-1), classes4data(:,end), classes4data(:,1:end-1),30,'ManHD')
% [Accuracy, Miss_classification] = K_NN_selection(classes4data(:,1:end-1), classes4data(:,end), classes4data(:,1:end-1),30,'ED')
%
function [Accuracy, Miss_classification] = K_NN_selection(Train_col_data, Labels, Test_col_samples, K, d_Measure)

j=1;

for i = 1:2:K
    
    fprintf('Nearest Point Number %i: ',i)
    
    [Predicted_Labels] = K_NN( Train_col_data, Labels, Test_col_samples, i, d_Measure );
    
    Accuracy(j,1) = mean((Predicted_Labels == Labels)) * 100;
    
    Miss_classification(j,1) = 100-Accuracy(j,1);
    
    fprintf('...Done \n')
    
    j=j+1;
end

    figure
    subplot(121)
    plot([1:2:K],Accuracy,'-o','linewidth',2)
    xticks(1:2:K)
    xtickangle(90)
    xlabel("Nearest Neighbour (K)",'FontWeight','bold')
    ylabel("Accuracy (%age)",'FontWeight','bold')
    title('Higher is better, except K = 1')
    axis tight
        
    subplot(122)
    plot([1:2:K],Miss_classification,'-o','linewidth',2)
    xticks(1:2:K)
    xtickangle(90)
    xlabel("Nearest Neighbour (K)",'FontWeight','bold')
    ylabel("Miss Classification Rate (%age)",'FontWeight','bold')
    title('Lower is better, except K = 1')
    axis tight
    
end

