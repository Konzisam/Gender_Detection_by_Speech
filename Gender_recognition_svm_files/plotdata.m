function plotdata(feature,label)
%seperate male and female from the feauture examples
male = label == 1; female = label== 0;
% male1 = find(label1 == 1); female1 = find(label1== 0);
% Plot the features
plot(feature(male, 1), 'k+','LineWidth', 1, 'MarkerSize', 7)
hold on;
plot(feature(female, 1), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 7)
hold off;
% plot(feature1(male1, 1), 'b+','LineWidth', 1, 'MarkerSize', 7)
% hold on;
% plot(feature1(female1, 1), 'co', 'MarkerFaceColor', 'c', 'MarkerSize', 7)
% hold off;
end