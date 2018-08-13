function plotWave_YW(newFig, signal, fs, type, x_axis, name, removeFreq, frame)
%%     By YI-WEN CHEN, 2017 / Jarvus Studio
%     1. Plot signal wave in time or frequency domain
%     2. Choose x-axis as time or samples 
%     3. Remove spectral energy under a value when show the spectrogram
%     Read more at http://jarvus.dragonbeef.net/note/noteAudioPlot.php
% 
%     Required Input Parameters : 
%       newFig      Create in a new figure window ( 0:No, 1:Yes )
%       signal      Speech data
%       fs          Sampling frequency (Hz)
%       type        'time' or 'freq'
%     Optional Input Parameters : 
%       x_axis      0: samples, 1: time
%       name        Figure title
%       removeFreq  Threshold for  spectral energy
%       frame       Frame size for spectrogram (ms)
% %     example :
%     [ clean, fs ] = audioread( 'sp10.wav' );
% %     open a new figure, plot in time domain
% %     show index as x-axis, titile is 'clean speech'
%     plotWave_YW(1, clean, fs, 'time', 0, 'clean speech');
% %     open a new figure, plot in time domain
% %     show time as x-axis, titile is 'clean speech'
%     plotWave_YW(1, clean, fs, 'time', 1, 'clean speech');
% %     open a new figure, plot in frequency domain
% %     titile is 'clean speech'
%     plotWave_YW(1, clean, fs, 'freq', 1, 'clean speech');
% %     open a new figure, plot in frequency domain
% %     titile is 'clean speech', remove spectral energy when under 0
%     plotWave_YW(1, clean, fs, 'freq', 1, 'clean speech',0);
% %     use subplot, so the first parameter should be zero 
%     figure;
%     subplot(2,1,1);
%     plotWave_YW(0, clean, fs, 'time', 1, 'clean speech');
%     subplot(2,1,2);
%     plotWave_YW(0, clean, fs, 'freq', 1, 'clean speech');

    if ( nargin < 5)
        x_axis = 0;
    end
    if ( nargin < 7)
        removeFreq = 0;
    end
    if ( nargin < 8)
        frame = 32;
    end
    s_length = length(signal);
    sampleTime = ( 1:s_length )/fs;
    frameSize = fix(frame*0.001*fs);
    if ( newFig == 1 )
        figure;
    end
    if ( strcmp(type, 'time') && x_axis == 0)
        plot(signal);
        if ( nargin > 5 )
            title(name)
        end    
        xlabel('Samples');ylabel('Amplitude');
    end
    if ( strcmp(type, 'time') && x_axis == 1)
        plot(sampleTime, signal);
        if ( nargin > 5 )
            title(name)
        end
        xlabel('Time (s)');ylabel('Amplitude');
    end
    if ( strcmp(type, 'freq') )
        [B,f,T] = specgram(signal,frameSize*2,fs,hanning(frameSize),round(frameSize/2));
        B = 20*log10(abs(B));
        if ( nargin > 6 ) 
            B_idx =  B <= removeFreq ;
            B(B_idx) = -50;
        end
        imagesc(T,f,B);axis xy;colorbar
        if ( nargin > 5 )
            title(['Spectrogram' ' - ' name]);
        end
        xlabel('Time (s)');ylabel('Frequency (Hz)'); 
        colormap jet
    end

end