function [Xscaled, u, sd] = feature_scale(X)
%this function is takes the input of X and performs normalization
%using the formula {(x-u)/sd}

%Input:  X = (m x n) dimensions
% mean = (1 x n) 
% sd = (1 x n)
%Output: Xscaled  is the output of X normalised

% Declare variables
Xscaled = X;
%preallocate the arrays u and sd 
u = zeros(1, size(X, 2));
sd = zeros(1, size(X, 2));

% Calculate the mean and std deviation for each feature
for i=1:size(u,2)
    u(1,i) = mean(X(:,i)); 
    sd(1,i) = std(X(:,i));
    Xscaled(:,i) = (X(:,i)-u(1,i))/sd(1,i);
end
