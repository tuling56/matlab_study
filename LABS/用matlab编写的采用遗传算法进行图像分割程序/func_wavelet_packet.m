function [E_W] = func_wavelet_packet(I, level, type);
mm=mean(mean(abs(I)));
t=wpdec2(I,level,type);
%e=[];
%for i=0:15
%    c=wpcoef(t,[2,i]);
%    e1=mean(mean(c));
%    e=[e;e1];
%end  
%E_W=[e;mm];
c0=mean(mean(abs(wpcoef(t,[1,0]))));
c1=mean(mean(abs(wpcoef(t,[1,1]))));
c2=mean(mean(abs(wpcoef(t,[1,2]))));
c3=mean(mean(abs(wpcoef(t,[1,3]))));
ma=[c0,c1,c2,c3];
if (c0==max(ma))
    E_W=[c1;c2;c3;mean(mean(abs(wpcoef(t,[2,0]))));mean(mean(abs(wpcoef(t,[2,1]))));mean(mean(abs(wpcoef(t,[2,2]))));mean(mean(abs(wpcoef(t,[2,3]))));mm];
end   
   
if (c1==max(ma))
    E_W=[c0;c2;c3;mean(mean(abs(wpcoef(t,[2,4]))));mean(mean(abs(wpcoef(t,[2,5]))));mean(mean(abs(wpcoef(t,[2,6]))));mean(mean(abs(wpcoef(t,[2,7]))));mm];
end   

if (c2==max(ma))
    E_W=[c0;c1;c3;mean(mean(abs(wpcoef(t,[2,8]))));mean(mean(abs(wpcoef(t,[2,9]))));mean(mean(abs(wpcoef(t,[2,10]))));mean(mean(abs(wpcoef(t,[2,11]))));mm];
end   
if (c3==max(ma))
    E_W=[c0;c1;c2;mean(mean(abs(wpcoef(t,[2,12]))));mean(mean(abs(wpcoef(t,[2,13]))));mean(mean(abs(wpcoef(t,[2,14]))));mean(mean(abs(wpcoef(t,[2,15]))));mm];
end   


