function[pitch]=pitch_autocorrelation(s,fs)
%this code computes the pitch of each frame by autocorrelation
%vectorise the speech signal
s=s(:); 
%Obtain the  number of samples
no_samples=length(s);
%perform error checking toremove dc bias
%by subtracting the mean from the signal 
mean_s=mean(s);
s=s-mean_s;
%speech divided into frame of length 60milliseconds
frame_size=floor(0.12*fs);      %between 2 frames
overlaps=floor(0.11*fs);    %between 2 frames-overlap
no_frames=floor(no_samples/frame_size)-1;   %number of frames
%Pitch per_frame is thepitch of each of the frames
pitch_per_frame=zeros(1, no_frames);
%pitch_all_frames is a matrix with containing the pitch per frame
pitch_all_frames=zeros(1, no_frames);
%%
% determining pitch for each frame
n=1;    %refers to the first frame up to the nth frame
pitch=0;    %define pitch as 0
p=1;    %counter for t
%put all the frames together
for i=1:no_frames %no_frames is total no of frames
    frame_step=s(n:n+frame_size-1);
    pitch_all_frames(i)=autocorrelation(frame_size, fs, frame_step); %pitch for
    %all the frames(i upto number of frames)
    
    %perform median filtering for every three frames ro reduce effect
    %of noise
    if i>2 && no_frames>3
        z=pitch_all_frames(i-2:i); %median filtering for no_frames>3
        md=median(z);
        pitch_per_frame(i-2)=md;
        if md>0
            pitch=pitch+md;
            p=p+1;
        end
    elseif no_frames<=3 
        pitch_per_frame(i)=n;
        
        pitch=pitch+a;
        p=p+1;
    end
    n=n+overlaps;
end
if p==1
    pitch=0;
else
    pitch=pitch/(p-1);
end
        
end

