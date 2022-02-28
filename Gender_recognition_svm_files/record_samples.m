clear all;  clc;
%enter the number of voice sample(manually)
voice_number = 6;

%fixed for uniformity of dataset 
fs=16000;
bits=8;
channels=1;

myvoice=audiorecorder(fs, bits, channels);

% myvoice=audiorecorder;
disp('start speaking')
recordblocking(myvoice, 11);
disp('End of recording')

y1 = getaudiodata(myvoice);
y = getaudiodata(myvoice, 'uint8');

 
 data{voice_number,1} = y;
 
  y = double(y);
  voice_number;
  st=strcat('u',num2str(voice_number),'.wav');
  wavwrite(y1,fs,bits,st)
  
  save('voice_database.dat','data','voice_number','-append');
  disp('voice added to file');
