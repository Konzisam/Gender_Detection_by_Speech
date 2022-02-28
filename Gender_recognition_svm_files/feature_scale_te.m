function [Kscaled, mu, stdev] = feature_scale_te(K)
%this function is takes the input of K and performs normalization
%using the formula {(k-u)/sd}
%Input:  K = (m x n) dimensions, 
% mean = (1 x n) 
% sd = (1 x n)
%Output: Kscaled  is the output of K normalised
% Declare variables
Kscaled = K;
%preallocate the arrays u and sd 
mu = zeros(1, size(K, 2));
stdev = zeros(1, size(K, 2));

% Calculate the mean and std deviation for each feature
for i=1:size(mu,2)
    mu(1,i) = mean(K(:,i)); 
    stdev(1,i) = std(K(:,i));
    Kscaled(:,i) = (K(:,i)-mu(1,i))/stdev(1,i);
end
