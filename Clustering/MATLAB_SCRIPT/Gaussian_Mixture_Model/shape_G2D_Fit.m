% CODED BY : PUNEET DHEER
% DATE : 10-06-2019
%
% shape_G2D_Fit: to fit gaussian shape over clustered points and it is only for 2D
%
function shape_G2D_Fit(data, cluster_mean, cluster_cov)

feature_dimension = size(data,2);

[X1,X2] = meshgrid(sort(data(:,1)),sort(data(:,2)));

X = [X1(:),X2(:)];

X = bsxfun(@minus, X, cluster_mean);

pdf = (2 * pi) ^ (- feature_dimension / 2) * det(cluster_cov) ^ (-0.5) * exp(-0.5 * sum(bsxfun(@times, X * inv(cluster_cov), X), 2));

pdf = reshape(pdf,size(X1));

% plot(data(:, 1), data(:, 2),'o');

hold on;
% Not to plot if there are Inf
% if (sum(isinf(pdf)) == 0)
    contour(X1, X2, pdf,'linewidth',3);
% end
hold off;

end