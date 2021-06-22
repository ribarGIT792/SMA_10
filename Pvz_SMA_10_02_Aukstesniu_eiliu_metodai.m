%------------------------------------------------------------------------
%
% Aukstesniu eiliu metodai - netiesine PDL
%
function Aukstesniu_eiliu_metodai
clc, clear all,
% close all

% simbolines funkcijos ir daliniu isvestiniu israiskos:
syms xp yp 
% f=-yp+1;               % paprasciausia lygtis
f=-yp+sqrt(xp+1)-3;  % netiesine lygtis
% f=-sin(yp)+sqrt(xp*yp^2+1)-3;  % netiesine lygtis
% f=-sin(yp^2+cos(xp))
eile=3 ;              % metodo eile 
% spalvos kodas:
shift=floor(eile/7); sp=eile-floor(eile/7)*7;
sp=dec2base(sp,2,3);spalva=[str2num(sp(1)),str2num(sp(2)),str2num(sp(3))]+shift*0.2
spalva=spalva/norm(spalva);
% spalva='k'
     
% apskaiciuojamos analitnes isvestiniu israiskos:
dyp(1)=f; for i=2:eile, dyp(i)=diff(dyp(i-1),xp)+diff(dyp(i-1),yp)*dyp(1); end

x=0;y=1; % pradines reiksmes
dx=2.7    ;  % integravimo zingsnis    

xmax=100; % sprendimo intervalo pabaiga  
nsteps=xmax/dx; % zingsniu skaicius
     
figure(1), hold on, grid on, set(gcf,'Color','w');
plot(x,y,'ro') % pradinio tasko vaizdavimas 
pntx=x;pnty=y; % pirmas taskas (tik braizymu  i) 
title(sprintf('metodo eile=%d',eile),'Color',spalva); 
for i=1:nsteps     
    sum=0;for j=1:eile  % skaitine Teiloro eilutes sumos reiksme 
        sum=sum+eval(subs(subs(dyp(j),sym(xp),sym('x')),sym(yp),sym('y')))*dx^j/factorial(j); 
          end
    y=y+sum;
    x=x+dx; % argumento prieaugis per 1 zingsni
        pause  % stabdymas vizualizacijai
    plot(x,y,'.','Color',spalva,'MarkerSize',8);plot([pntx,x],[pnty,y],'-','Color',spalva); % braizome sekantio apskaiciuota taska
    pntx=x;pnty=y; % prisimename apskaiciuota taska (tik braizymui)
end

return,end