function[A,t,Vcw,Vlfm,FFT_CW,FFT_LFM] = Square_CW_LFM(fs,fo,taud,phi,Bc)
% fo is the pulse signal center frequency
% taud is the total puse width
%tr and tf are times rise and fall 10% to 90%
% phi is the initial signal phase
% tau is the pulse width at 50% voltage
% Bc is Pulse Chirp Bandwidth for LFM
close all
% fs=fs*1.0e06;
% fo=fo*1.0e06;
% Bc=Bc*1.0e06;
% taud;
tr=0.03;
tf=0.03;

%APROXIMACIÓN TIEMPO TOTAL 
%tauext = tau_50 + 0.5 * (tr/0.8 + tf/0.8);
t = (0 : 1/fs : taud);
n = length(t);

%Create the trapezoidal pulse waveform
t1=0;
t2 = tr;
t4 = taud;
t3=t4-tf;
%A(t)
for i=1:n
    if (t(i) >=t1 && t(i) <= t2)
        A(i) = (t(i)-t1)/(tr);
    elseif (t(i) >= t2 && t(i) <= t3)
        A(i) = 1;
    elseif (t(i) >= t3 && t(i) <= t4)
        A(i) = (t4 - t(i))/(tf);
    else
        A(i) = 0;
    end
end
figure
plot(t,A)
axis([-0.01 taud+0.01 0 1.1])
title('Square Pulse Envelope')
%axis([-0.0015 0.009 0 1.1])
tsq = t.^2;
%CW waveform 

Vcw=A.*cos(2*pi*fo.*t + phi);

figure
plot(t,Vcw)
xlabel('Time')
ylabel('Amplitude')
%axis([0.002 0.04 -1.01 1.01])
title('CW waveform with V=1')
%LFM waveform

k = Bc/taud;
Vlfm=A.*cos(2*pi*(fo.*t + k.*tsq/2 + phi));
figure
plot(t,Vlfm)
xlabel('Time')
ylabel('Amplitude')
%axis([0.002 0.04 -1.01 1.01])
title('LFM waveform with V=1')

% % FFT The time Signal and Plot the pulse spectrum
%nfft = 2^13;

%fft return complex part

FFT_CW = fft(Vcw);
FFT_LFM = fft(Vlfm);

len_CW = length(Vcw);
len_LFM = length(Vlfm);
freqlimit = fs;
freq_cw = linspace(0,freqlimit,len_CW);
freq_lfm = linspace(0,freqlimit,len_LFM);
figure
plot(freq_cw,abs(FFT_CW))
title('FFT_(CW)')
xlabel('Frequency(Hz)')
ylabel('Amplitude')
%axis([11800 26600 0 100])
figure
plot(freq_lfm,abs(FFT_LFM))
title('FFT_(LFM)')
xlabel('Frequency(Hz)')
ylabel('Amplitude')
%axis([0 5 0 100])

end