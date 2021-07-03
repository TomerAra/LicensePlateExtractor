function [H2to1] = computeH(p1, p2)
%   This function computes the Homography matrix that projects image_1 to image_2
%   Parameters:
%   p1 - set of 4 points (at least) from image_1
%   p2 - set of 4 points (at least) from image_2

% transpose the matrices
p1 = p1';
p2 = p2';

s1 = size(p1);
s2 = size(p2);

% check equal number of points & points of 2D
if(s1(2) ~= s2(2))
    error("Inequal number of points from each image.");
elseif((s1(1) ~= 2) || (s2(1) ~= 2))
    error("Invalid points dimensions.");
end

N = s1(2);

u = reshape(p2(1,:), [N,1]);
v = reshape(p2(2,:), [N,1]);
x = reshape(p1(1,:), [N,1]);
y = reshape(p1(2,:), [N,1]);

% calculate the two parts of A matrix
upperA = horzcat(-1*u, -1*v, -1*ones(N,1), zeros(N,3), x.*u, x.*v, x);
lowerA = horzcat(zeros(N,3), -1*u, -1*v, -1*ones(N,1), y.*u, y.*v, y);

% stack the two parts together into A matrix
A = vertcat(upperA, lowerA);

% SVD to A matrix
[~,~,V] = svd(A);

% taking the last column of V
h = V(:,end);
H2to1 = reshape(h, [3,3]);

end

