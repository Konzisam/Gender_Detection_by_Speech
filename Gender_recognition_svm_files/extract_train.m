clear all; clc;
%s_train sound file from train folder
%fs_train sampling frequency from train folder

%preallocate arrays(154 rows since there are 154 train examples)
mfcc_matrix=zeros(154,12);
pitch_matrix=zeros(154,1);
mfcc_tr={154};
ss_tr={154};
pitch={154};
s_train = {154}; fs_train = {154}; 

%========================================================================
%read .wav files contained in train folder one by one
for i=1:154
 st = strcat('train\f',num2str(i),'.wav');
    [st1 fst1] = wavread(st);
    s_train{i} = st1; fs_train{i} = fst1; 
end
%========================================================================
%place cell contants to an array
k=1;
while k<155
      si=s_train{k};     fsz=fs_train{k};
      %perform spectral subtraction for the 154 files
      ss_tr{k}=specsub(si,fsz);
      
      s=ss_tr{k};      fs=fs_train{k};
      %perform pitch extraction for all 154 files
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
for q=1:154
   mfcc_matrix(q,:)= [t{q,:}];
   pitch_matrix(q,:)=[c{q,:}];
end

%========================================================================

%form the labels matrix for train examples
w=zeros(70,0);
x=ones(84,1);
y=[w;x];

keep={'mfcc_matrix','pitch_matrix','y'};
clearvars('-except',keep{:});

% save elsdsr.mat
