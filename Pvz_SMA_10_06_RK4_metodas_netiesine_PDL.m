function RK4_metodas_netiesine_PDL

clc, clear all,
% close all
spalva='k';


% simbolines funkcijos ir daliniu isvestiniu israiskos:
syms xp yp 
fp=-yp+sqrt(xp+1)-3;
% fp=-yp-3;

x=0;y=0; % pradines reiksmes 
dx=0.7;  % integravimo zingsnis

xmax=40; % sprendimo intervalo pabaiga 
nsteps=xmax/dx; % zingsniu skaicius

figure(1), hold on, grid on, 
plot(x,y,'ro') % pradinio tasko vaizdavimas
pntx=x;pnty=y; % pirmas taskas (tik braizymui) 
for i=1:nsteps
    dy=eval(subs(subs(fp,sym(xp),sym('x')),sym(yp),sym('y')));
    yz=y+dx/2*dy; % gauname pirmaja ekstrapoliacija pagal T.e. narius iki 1 eiles
        % apskaiciuojame  desines puses funkcija prie (x+dx/2,yz)
    dyz=eval(subs(subs(fp,sym(xp),sym('x+dx/2')),sym(yp),sym('yz')));
    yzz=y+dx/2*dyz; % atgaline Eulerio formule
    dyzz=eval(subs(subs(fp,sym(xp),sym('x+dx/2')),sym(yp),sym('yzz')));
    yzzz=y+dx*dyzz; % vidurinio tasko formule
    dyzzz=eval(subs(subs(fp,sym(xp),sym('x+dx')),sym(yp),sym('yzzz')));
    y=y+dx*(dy+2*dyz+2*dyzz+dyzzz)/6;  % Heuno (II RK) formule
    plot(x+dx,y,[spalva,'.'],'MarkerSize',8);plot([pntx,x+dx],[pnty,y],[spalva,'-']); % braizome sekanti apskaiciuota taska
            pause  % stabdymas vizualizacijai
    x=x+dx; % argumento prieaugis per 1 zingsni
    pntx=x;pnty=y; % prisimename apskaiciuota taska (tik braizymui)
end

return,end

