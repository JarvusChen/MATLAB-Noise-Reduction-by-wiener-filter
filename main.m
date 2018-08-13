clear
close all
clc

[clean, fs] = audioread('jarvus.wav');
[noise] = audioread('jarvus_pub.wav');
output = noiseReduction_YW(noise, fs);

subplot(3,2,1)
plotWave_YW(0,clean,fs,'time',1);
title('Clean speech')
subplot(3,2,2)
plotWave_YW(0,clean,fs,'freq');

subplot(3,2,3)
plotWave_YW(0,noise,fs,'time',1);
title('Noisy speech')
subplot(3,2,4)
plotWave_YW(0,noise,fs,'freq');

subplot(3,2,5)
plotWave_YW(0,output,fs,'time',1);
title('Enhanced speech')
subplot(3,2,6)
plotWave_YW(0,output,fs,'freq');