
%Elliptic filter to filter the input signal
%Where n=order and Rpass and Rstop 
%are the ripple in the passband and stopband
function[y] = Filter_Elliptic(n,Rpass,Rstop,Wp,type,input)
%Rpass and Rstop [dB]
%Wp [MHz]
%1=Lowpass   |___       _   __
%2=Bandpass  | |   |   |_| |  |
%3=Highpass  | |   |   |   |__|
%4=bandstop  |
    if (type==1)
        [z,p,k] = ellip(n,Rpass,Rstop,Wp(1),'low');
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=ellip(n,Rpass,Rstop,Wp(1),'low');
         y = filter(b,a,input);
    elseif (type==2)
        [z,p,k] = ellip(n,Rpass,Rstop,Wp);
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=ellip(n,Rpass,Rstop,Wp);
         y = filter(b,a,input);
    elseif (type==3)
        [z,p,k] = ellip(n,Rpass,Rstop,Wp(1),'high');
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=ellip(n,Rpass,Rstop,Wp(1),'high');
         y = filter(b,a,input);
    elseif (type==4)
        [z,p,k] = ellip(n,Rpass,Rstop,Wp,'stop');
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=ellip(n,Rpass,Rstop,Wp,'stop');
         y = filter(b,a,input);
    else 
        y=0;
    end
end
