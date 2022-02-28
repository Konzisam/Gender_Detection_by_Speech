clear all;  clc; close all;
%% **************************PITCH BASED MODEL****************************
%load dataset for training and testing
load('elsdsr_train.mat');

%define inputs and labels
X=pitch_matrix;

%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;
% training data
train_data = x;    train_label = y;
% =====================================================================
%load test data
load('samples_test.mat');

X=pitch_matrix_s;
%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;

%test data
test_data=x;     test_label=y_s;
%======================================================================
%Linear Kernel on train
disp('=======================PITCH BASED MODEL========================');
disp('==============Test accuracy using Linear Kernel=================');
model_linear = svmtrain(train_label, train_data, '-t 0 -c 1 -g 0.1 -h 0');

[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label,...
    test_data, model_linear);
% =======================================================================
%Gaussian Kernel
disp('==============Test accuracy using GAUSSIAN Kernel================');
model_RBF = svmtrain(train_label, train_data, '-t 2 -c 1 -g 0.1 -h 0');

[predict_label_G, accuracy_G, dec_values_G] = svmpredict(test_label,...
    test_data, model_RBF);
%% *******************************MFCC_MODEL******************************
%load dataset for training and testing
load('elsdsr_train.mat');

%define inputs and labels
X=mfcc_matrix;

%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;

% training data
train_data = x;
train_label = y;
% ****************************load test data*****************************
load('samples_test.mat');
X=mfcc_matrix_s;

%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;
%test data
test_data=x;
test_label=y_s;
% ****************** Applying Linear kernel on test Data*****************
disp('=================================================================');
disp('=======================MFCC BASED MODEL==========================');
disp('===============Test accuracy using Linear Kernel=================');
model_linear = svmtrain(train_label, train_data, '-t 0 -c 1 -g 0.1 -h 0');
[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label,...
    test_data, model_linear);
% *****************Applying Gaussian Kernel on Test Data*****************
disp('==============Test accuracy using GAUSSIAN Kernel================');
model_RBF = svmtrain(train_label, train_data, '-t 2 -c 1 -g 0.1 -h 0');
[predict_label_G, accuracy_G, dec_values_G] = svmpredict(test_label,...
    test_data, model_RBF);

%% ********************COMBINED MFCC AND PITCH_MODEL**********************
%load dataset for training and testing
load('elsdsr_train.mat');

%define inputs and labels
X=[mfcc_matrix pitch_matrix];

%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;

% training data
train_data = x;     train_label =y;
% ****************************load test data*****************************
load('samples_test.mat');
X=[mfcc_matrix_s pitch_matrix_s];

%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;

%test data
test_data=x;    test_label=y_s;
% ****************** Applying Linear kernel on test Data*****************
disp('=================================================================');
disp('================COMBINED MFCC AND PITCH MODEL====================');
disp('==============Test accuracy using Linear Kernel==================');
model_linear = svmtrain(train_label,train_data, '-t 0 -c 1 -g 0.1 -h 0');

[predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label,...
    test_data, model_linear);
% *****************Applying Gaussian Kernel on Test Data*****************
disp('==============Test accuracy using GAUSSIAN Kernel================');
model_RBF = svmtrain(train_label, train_data, '-t 2 -c 1 -g 0.1 -h 0');

[predict_label_G, accuracy_G, dec_values_G] = svmpredict(test_label,...
    test_data, model_RBF);
