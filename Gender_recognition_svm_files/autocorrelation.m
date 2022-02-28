function [pitch_per_frame] = autocorrelation(frame_size, fs, frame_step)
%lpf at 900hz
[b, a]=butter(4, 900/(fs/2));
frame_step=filter(b,a, frame_step);

%find clipping level for first 1/3 of the frame
i13=frame_size/3;
maxi1=max(abs(frame_step(1:i13)));
%find clipping level for last 1/3 of the frame
i23=2*frame_size/3;
maxi2=max(abs(frame_step(i23:frame_size)));
%for the first third greater than the 2nd third,else.
if maxi1>maxi2
    cl=0.68*maxi2;
else
    cl=0.68*maxi1;
end
%center clip waveform and compute autocorrelation
% cllipping done to make  periodicity more dominant
clip=zeros(frame_size, 1);
ind1=find(frame_step>=cl);
clip(ind1)=frame_step(ind1)-cl;

ind2=find(frame_step <= -cl);
clip(ind2)=frame_step(ind2)+cl;

energy = norm(clip,2)^2; %energy of clipped waveform
RR = xcorr(clip); %compute autocorr fctn of clipped waveform
m = frame_size;
% Find the max autocorr range 70 <= f <= 300 Hz
LF = floor(fs/300);
HF = floor(fs/70);

Rxx = abs(RR(m+LF:m+HF));
[rmax, imax] = max(Rxx);%find the max ampplitude of signal
imax = imax + LF; %indices
pitch_per_frame = fs/imax;
% Check max RR against highest energy threshold
silence = 0.4*energy;
if (rmax > silence) & (pitch_per_frame > 70) & (pitch_per_frame <= 300)
pitch_per_frame = fs/imax;
else % unvoiced
pitch_per_frame = 0;
end

end

