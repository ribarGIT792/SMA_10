%
% Eulerio metodas , tikslumo ir stabilumo paaiskinimas
%

function Euler
clc, clear all, 
% close all
spalva='k'

global a f
a=-1;f=1;

x0=0;y0=0.0;
dx=2.5;
xmax=100; 

nnnn=1000;
xplot=5;
xxxx=x0+(0:xplot/(nnnn-1):xplot);
figure(100), hold on, grid on,
plot(x0,y0,'ro')
plot(xxxx,sprendinys(xxxx,y0),'g-')

nnn=100;
nsteps=xmax/dx;
xxx=x0+(0:dx/(nnn-1):dx);
figure(1), hold on, grid on, %axis(range);

x=x0;y=y0;
plot(x,y,'ro');
pntx=x;pnty=y;  
for i=1:nsteps
    plot(xxx,sprendinys(xxx,y0),'g-');plot(xxx(end),sprendinys(xxx(end),y0),'r.','MarkerSize',8)
    dy=DY(x,y);
    y=y+dx*dy
    x=x+dx
    pause
    plot(x,y,[spalva,'.'],'MarkerSize',8)
    plot([pntx,x],[pnty,y],[spalva,'-']);
    pntx=x;pnty=y;
    xxx=xxx+dx;
end

return,end

function dy=DY(x,y)
global a f
dy=a*y+f;
% dy=-5*y^2+sin(x)+2;
return,end

function y=sprendinys(x,y0);
global a f 
y=(y0+f/a).*exp(a*x)-f/a;
return,end