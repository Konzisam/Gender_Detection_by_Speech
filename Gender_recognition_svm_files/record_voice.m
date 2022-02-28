clear all; close all; clc;

voice = audiorecorder(16000, 16, 1);
% voice=audiorecorder;
disp ('recording');
recordblocking(voice,10);
disp('end');
play(voice);
% save audio file sam.wav
myspeech=getaudiodata(voice);
wavwrite(myspeech,16000, 16, 'sam');
%read and play sound
[x, fs ,nbits]=wavread('sam');
 sound('sam',16000)