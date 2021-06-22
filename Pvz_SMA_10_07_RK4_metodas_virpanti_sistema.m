function RK4_metodas_virpanti_sistema

clc, clear all,
close all

 
m=1; k=0.1;   % virpancios sistemos parametrai:
nu=0.02;     % slopinimo laipsnis nu=c/2/sqrt(k*m)
c=2*nu*sqrt(k*m);   

lambda=1; ampl=0.1; % kelio bangos ilgis ir amplitude
x=0; v0=0; a=0.005; % pradinis atstumas, pradinis judejimo greitis ir pastovus pagreitis  
omrez=sqrt(k/m);    % sistemos rezonansinis daznis
tmax=500;           % sprendimo intervalo pabaiga 
dt=2*pi/(200*omrez);% zingsni parenkame maza ivertindami, kad laikui begant  
                    % virpesiu daznis dideja, didejant judejimo greiciui
figure(1),set(gcf,'Color','w'); hold on, grid on, box on
t=0;y=[0;0;x];      % pradines reiksmes 
Y=[]; S=[];T=[];    % vieta issaugoti poslinkiu laiko priklausomybei
ttp=0;
while t < tmax 
    T=[T,t];Y=[Y,y(1)];S=[S,y(3)]; % issaugomi rezultatai
    dy=fnk(t,y); yz=y+dt/2*dy;  % IV RK schema 
    dyz=fnk(t+dt/2,yz);yzz=y+dt/2*dyz; 
    dyzz=fnk(t+dt/2,yzz);yzzz=y+dt*dyzz; 
    dyzzz=fnk(t+dt,yzzz);y=y+dt*(dy+2*dyz+2*dyzz+dyzzz)/6; 
    
    cla,axis([-5*lambda,1*lambda,-ampl,3+ampl]);vaizdavimas; %vaizdavimas kiekviename zingsnyje
    plot(S(end:-1:1)-max(S),Y(end:-1:1)+1.5); if ttp==0,disp('***** Press Key'),pause,ttp=0.01;else, pause(ttp);end;
    str=sprintf('t=%8.3g, vel=%8.3g',t,vel);title(['\fontname{Courier}',str]);
    t=t+dt;  % i sekanti laiko zingsni
end
figure(2);set(gcf,'Color','w');hold on, plot(S,Y+1.5,'b-');plot(S,ampl*sin(2*pi/lambda*S),'r-');
axis([0,max(S),-ampl,3+ampl]);grid on, box on,   % virpesiu laiko priklausomybe 

return   % pagrindines programos pabaiga

% &&&&&&&&&&&&&&&&&&&&&&&&   vidines funkcijos &&&&&&&&&&&&&&&&&&&&&&&&&&&&
function dy=fnk(t,y) 
    vel=greitis(t);
    dy=[y(2);-c/m*(y(2)-ampl*2*pi/lambda*vel*y(3)*cos(2*pi/lambda*y(3)))-k/m*(y(1)-ampl*sin(2*pi/lambda*y(3)));vel];
    return
end

function vel=greitis(t),
    vel=v0+a*t; % tolygiai greitejantis judejimas
    return
end
 
function vaizdavimas
    xxx=[-5*lambda:lambda/20:1*lambda];
    plot([-5*lambda,1*lambda],[1.5,1.5],'g-'); 
    plot(xxx,ampl*sin(2*pi/lambda*(xxx+y(3))));
    W=lambda/4;
    spyruokle(1.5,ampl*sin(2*pi/lambda*y(3)),y(1),0,W,3,'m');
    rectangle('pos',[-W/2,1.5+y(1)-W/2,W,W],'cur',[1,1],'FaceColor','m');
    rectangle('pos',[-W/6,ampl*sin(2*pi/lambda*y(3))-W/6,W/3,W/3],'cur',[1,1],'FaceColor','m');
    return 
end
% &&&&&&&&&&&&&&&&&&&&&&&&   vidiniu funkciju pabaiga &&&&&&&&&&&&&&&&&&&&&
    
end

% -----------------------   isorines funkcijos ----------------------------
function spyruokle(L,dLa,dLv,y0,W,N,col)
    Lg=L/6; % galu ilgiai 
    L1=L-2*Lg-dLa+dLv; % atstumas lauztei 
    y=[y0+dLa,y0+Lg+dLa+[0:L1/(4*N):L1],L+dLv]; % lauztes atraminiai taskai 
    x=[0,W/2*sin(N*2*pi/L1*[0:L1/(4*N):L1]),0];  
    plot(x,y,col)
       return
end
% -------------------------------------------------------------------------
