
% analitinis RK4 tikslumo tyrimas
close all

syms y0 x a dt
 
f0=a*y0;
yz=y0+dt/2*f0;  %Eulerio per puse zingsnio, prognoze
fz=a*yz;
yzz=y0+dt/2*fz; % Atgal.Eul.per puse zingsnio, korekcija
fzz=a*yzz;
yzzz=y0+dt*fzz; % Vidurinio tasko per 1 zingsni, prognoze
fzzz=a*yzzz;
y1=y0+dt/6*(f0+2*fz+2*fzz+fzzz); % Simpsono, korekcija
expand(y1)
