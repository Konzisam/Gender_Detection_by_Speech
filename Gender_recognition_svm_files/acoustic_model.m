clc; clear all; 
%load dataset to the environment
load ('kaggledata.mat'); 

%define input features and and label
y=label;
%main features
% X=mode;
%test on the five main features
X=[meanfun];

%test for all the features
% X=[meanfun IQR sfm centroid Q25 sd meanfreq Q75 median spent maxdom ...
%     mindom minfun maxfun mode meandom modindx meandom meanfun skew];

% scaling of the features
[Xscaled] = feature_scale(X); 
x=Xscaled;
%========================================================================
%divide data into training and testing set
train_data = x(318:2850,:);
train_label = y(318:2850,:);

test_data_m= x(1:317,:);           test_label_m =y(1:317,:); %male
test_data_f=x(2851:3168,:);        test_label_f=y(2851:3168);%female

test_data=[test_data_m;test_data_f];
test_label=[test_label_m;test_label_f];
%=========================================================================
%training with 80% and testing on 20% of the dataset(linear)
disp('==============Test accuracy using Linear Kernel=================');
%the options -t 0 represents choice of linear kernel
model_Linear = svmtrain(train_label, train_data, '-t 0 -c 0.1 -g 0.1 -h 0');

[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label,...
    test_data, model_Linear);  
%======================================================================
%training with 80% and testing on 20% of the dataset(RBF)
disp('==============Test accuracy using GAUSSIAN Kernel================');
%the options -t 2 represents choice of gaussian kernel
model_RBF_test = svmtrain(train_label,train_data, '-t 2 -c 0.1 -g 0.1 -h 0');

[predict_label_R, accuracy_R, dec_values_R] = svmpredict(test_label,...
    test_data, model_RBF_test);