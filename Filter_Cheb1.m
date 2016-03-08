function[y] = Filter_Cheb1(n,Rpass,Wp,type,input)
%1=Lowpass
%2=Bandpass
%3=Highpass
%4=bandstop
    if (type==1)
        [z,p,k] = cheby1(n,Rpass,Wp(1),'low');
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=cheby1(n,Rpass,Wp(1),'low');
         y = filter(b,a,input);
    elseif (type==2)
        [z,p,k] = cheby1(n,Rpass,Wp);
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=cheby1(n,Rpass,Wp);
         y = filter(b,a,input);
    elseif (type==3)
        [z,p,k] = cheby1(n,Rpass,Wp(1),'high');
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=cheby1(n,Rpass,Wp(1),'high');
         y = filter(b,a,input);
    elseif (type==4)
        [z,p,k] = cheby1(n,Rpass,Wp,'stop');
        sos = zp2sos(z,p,k);
        fvtool(sos,'Analysis','freq')
        [b,a]=cheby1(n,Rpass,Wp,'stop');
         y = filter(b,a,input);
    else 
        y=0;
    end
end
