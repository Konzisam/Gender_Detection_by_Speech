clear all; clc;
%% *****************extract speech features from test folder**********
%s_test sound file from test folder
%fs_test sampling frequency from test folder
mfcc_matrix=zeros(44,12);
pitch_matrix_te=zeros(44,1);
mfcc_te={44};
ss_te={44};
pitch={44};
%preallocate array
s_test = {44}; fs_test = {44}; 
%=======================================================================
for i=1:44
 st = strcat('test\c',num2str(i),'.wav');
    [st1 fst1] = wavread(st);
    s_test{i} = st1; fs_test{i} = fst1; 
end
% =====================================================================
k=1;
while k<45
      si=s_test{k};
      fsz=fs_test{k};
      
      ss_te{k}=specsub(si,fsz);
      
      s=s_test{k};%pitch extraction
      fs=fs_test{k};
      pitch{k} =pitch_autocorrelation(ss_te{k},fs_test{k});      
      mfcc_te{k} =mean(melcepst((ss_te{k}),(fs_test{k})));
      fprintf('mfcc for file number:%d\n',k);
       k=k+1;
     
end
%=======================================================================
c=pitch';
z=mfcc_te';
for r=1:44
   mfcc_matrix(r,:)= [z{r,:}];
    pitch_matrix_te(r,:)=[c{r,:}];
end
%=======================================================================
%form the labels matrix for test examples
w=zeros(20,1);
x=ones(24,1);
y_test=[w;x];
%=======================================================================
keep={'mfcc_matrix','pitch_matrix_te','y_test'};
clearvars('-except',keep{:});