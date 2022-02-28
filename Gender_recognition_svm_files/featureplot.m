clear all;
load elsdsr_train.mat

feature=pitch_matrix;
label=y_s;
plotdata(feature,label)
title('Graph of Pitch vs number of features');
ylabel('Pitch (in Hz)');
xlabel('Number of features')
y= legend('male','female',2);
