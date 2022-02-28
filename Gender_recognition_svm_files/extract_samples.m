clear all; clc;
%% ******* code for extracting speech features from sample recordings****
%s_train sound file from train folder
%fs_train sampling frequency from train folder

%preallocate arrays(18 rows since there are 18 train examples)
mfcc_matrix_s=zeros(18,12);
pitch_matrix_s=zeros(18,1);
mfcc_tr={18};
ss_tr={18};
pitch={18};
s_train = {18}; fs_train = {18}; 

%========================================================================
%read .wav files contained in train one by one
for i=1:18
 st = strcat('recordings\u',num2str(i),'.wav');
    [st1 fst1] = wavread(st);
    s_train{i} = st1; fs_train{i} = fst1; 
end
%========================================================================
%place cell contants to an array
k=1;
while k<19
      si=s_train{k};     fsz=fs_train{k};
      %perform spectral subtraction for the 18 files
      ss_tr{k}=specsub(si,fsz);
      
      s=ss_tr{k};      fs=fs_train{k};
      %perform pitch extraction for all 18 files
      pitch{k}=pitch_autocorrelation(ss_tr{k},fs_train{k}); 
      %exctract mfccs
      mfcc_tr{k} =mean(melcepst((ss_tr{k}),(fs_train{k})));
      fprintf('mfcc for file number:%d\n',k);
       k=k+1;
     
end
%========================================================================
%extract from cell to array
c=pitch';
t=mfcc_tr';
for q=1:18
   mfcc_matrix_s(q,:)= [t{q,:}];
   pitch_matrix_s(q,:)=[c{q,:}];
end

%========================================================================
% adding known labels
y=[1;1;1;0;0;1;1;1;0;1;0;0;1;0;0;0;1;1];

keep={'mfcc_matrix_s','pitch_matrix_s','y'};
clearvars('-except',keep{:});

% save samples_test.mat
