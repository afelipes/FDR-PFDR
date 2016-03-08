% Design Pulses-->Time[us] and Frequency[MHz]
function[A,t,Vcw,Vlfm,FFT_CW,FFT_LFM] = Trapezoidal_CW_LFM(fs,fo,taud,tr,tf,phi,Bc)
% fo is the pulse signal center frequency
% taud is the total puse width
%tr and tf are times rise and fall 10% to 90%
% phi is the initial signal phase
% tau is the pulse width at 50% voltage
% Bc is Pulse Chirp Bandwidth for LFM
%[A,t,Vcw,Vlfm,FFT_CW,FFT_LFM]=Trapezoidal_CW_LFM(170,85,1.45,0.2,0.3,0,0);
close all
% fs=fs*1.0e06;
% fo=fo*1.0e06;
% Bc=Bc*1.0e06;
% taud=taud*1.0e-06;
% tr=tr*1.0e-06;
% tf=tf*1.0e-06; 

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
title('Trapezoidal Pulse Envelope')
tsq = t.^2;
%CW waveform 

Vcw=A.*cos(2*pi*fo*t + phi);

figure
plot(t,Vcw)
xlabel('Time(us)')
ylabel('Amplitude')
axis([0 taud -1.01 1.01])
title('CW waveform with V=1')

%LFM waveform

k = Bc/taud;
Vlfm=A.*cos(2*pi*(fo.*t + k.*tsq/2 + phi));
figure
plot(t,Vlfm)
xlabel('Time(us)')
ylabel('Amplitude')
axis([0 taud -1.01 1.01])
title('LFM waveform with V=1')

% % FFT The time Signal and Plot the pulse spectrum
%nfft = 2^13;

%fft return complex part

FFT_CW = fft(Vcw,2^13);
FFT_LFM = fft(Vlfm,2^13);

len_CW = length(Vcw);
len_LFM = length(Vlfm);
freqlimit = fs/2;
freq_cw = linspace(0,fs,2^13);
freq_lfm = linspace(0,fs,2^13);
figure
plot(freq_cw,abs(FFT_CW))
title('FFT_(CW)')
xlabel('Frequency(MHz)')
ylabel('Amplitude')
%axis([6300 9700 0 250])
figure
plot(freq_lfm,abs(FFT_LFM))
title('FFT_(LFM)')
xlabel('Frequency(MHz)')
ylabel('Amplitude')
%axis([30000 70000 0 43])

end