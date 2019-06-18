% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
% 
% GMM_Plot
%
function GMM_Plot(frame, Dimension, data1, data2, data3, Centroid1, Centroid2, Centroid3, iter)

if strcmp('frame_1',frame)
    
    if strcmp('2D',Dimension)

        cm = figure(1);
        scatter(data1,data2)
        hold on 
        scatter(Centroid1,Centroid2,150,'filled')

        title({'Random Cluster Mean: GMM';'Initialization'})
        xlabel('Feature 1')
        ylabel('Feature 2')
        box on
        hold off

        
    else

        cm = figure(1);
        scatter3(data1,data2,data3)
        hold on 
        scatter3(Centroid1,Centroid2,Centroid3,150,'filled')
        view([-56.9191,7.4253])

        title({'Random Cluster Mean: GMM';'Initialization'})
        xlabel('Feature 1')
        ylabel('Feature 2')
        zlabel('Feature 3')
        box on
        hold off

    end
    
else
    
    if strcmp('2D',Dimension)
       
        scatter(data1,data2)
        hold on 
        scatter(Centroid1,Centroid2,150,'filled')
        
        Iteration = sprintf('Iteration: %i',iter);
        title({'Updated Cluster Mean: GMM';Iteration})
        xlabel('Feature 1')
        ylabel('Feature 2')
        box on
        
    else
        
        scatter3(data1,data2,data3)
        hold on 
        scatter3(Centroid1,Centroid2,Centroid3,150,'filled')
        view([-56.9191,7.4253])
        
        Iteration = sprintf('Iteration: %i',iter);
        title({'Updated Cluster Mean: GMM';Iteration})
        xlabel('Feature 1')
        ylabel('Feature 2')
        zlabel('Feature 3')
        box on
        
    end
    
end

end
