clear all; clc;close all;
%load ELDSR training set
load('elsdsr_train.mat');

%define inputs and labels
X=pitch_matrix;

%feature scaling
[Xscaled] = feature_scale(X); 
x=Xscaled;

% training data
train_data = x;   train_label = y;
% ***********************************************************************
% RBF on train model
model_train= svmtrain(train_label, train_data, '-t 2 -c 10 -g 0.1  -h 0');
disp('***************************Model trained!**********************')

%% *********************Select the file to test************************
[filename pathname]=uigetfile({'*.wav'},'select file');
user_voice=strcat(pathname,filename);

disp('Extracting features...');
disp('Please wait...');
[s,fs]=wavread(user_voice);
si=s; fsz=fs;
%feature extraction
[ss]=specsub(si,fsz);
mfcc =mean(melcepst(ss,fs));
pitch=pitch_autocorrelation(ss,fs); 

%add the feature to the train features for scaling
K=[X;pitch];

% %feature scaling
[Kscaled] = feature_scale_te(K); 
k=Kscaled(155,:);

%test sample
test_label=0;  test_data=k;

[predict_label, accuracy, dec_values] = svmpredict(test_label,...
    test_data, model_train); 


if predict_label~=test_label
    disp('False prediction');
    else
    disp('True prediction');
end

if predict_label==1
    msgbox('Gender is male');
else
    msgbox('Gender is female');
end