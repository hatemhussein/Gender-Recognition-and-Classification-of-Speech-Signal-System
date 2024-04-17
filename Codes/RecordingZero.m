
recObj = audiorecorder(44100, 24, 1);% record at Fs=44khz, 24 bits per sample
for i=1:1
fprintf('Start speaking for audio #%d\n',i)
recordblocking(recObj, 2); % record 2 seconds
fprintf('Audio #%d ended\n',i)
%play(recObj);

y = getaudiodata(recObj);
y = y - mean(y);
file_name = sprintf('D:/Matlab/bin/DSBProject/training/female/zero%d.wav',i);
audiowrite(file_name, y, recObj.SampleRate);
%figure
%plot(y);
end