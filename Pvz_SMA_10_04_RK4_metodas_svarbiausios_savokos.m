%------------------------------------------------------------------------
%
%RK4 metodas
%
function RK4_metodas_svarbiausios_savokos
clc, clear all,
close all
spalva='b';
spalva1='r';
spalva2='c';
spalva3='m';
spalva4=[1 1 1]*0.6;

% simbolines funkcijos ir daliniu isvestiniu israiskos:
syms xp yp 
fp=-yp+1;
% fp=-5*yp^2+sin(xp)+2;

x=0;y=0; % pradines reiksmes
dx=1;  % integravimo zingsnis  riba 2.7853

nnn=1000; % vaizdavimo tasku skaicius zingsnyje
xxx=0:dx/(nnn-1):dx; % vaizdavimo taskai viename zingsnyje 
xmax=100; % sprendimo intervalo pabaiga 
nsteps=xmax/dx; % zingsniu skaicius

figure(1), hold on, grid on,set(gcf,'Color','w'); 
plot(x,y,'ro') % pradinio tasko vaizdavimas
pntx=x;pnty=y; % pirmas taskas (tik braizymui) 
for i=1:nsteps
    % braizome tikslu sprendini:
    plot(xxx,sprendinys(xxx),'g-','LineWidth',2);plot(xxx(end),sprendinys(xxx(end)),'k.','MarkerSize',8)
    dy=eval(subs(subs(fp,sym(xp),sym('x')),sym(yp),sym('y')));
    yz=y+dx/2*dy; % gauname pirmaja ekstrapoliacija pagal T.e. narius iki 1 eiles
    plot([pntx,x+dx/2],[pnty,yz],[spalva,'--']);plot(x+dx/2,yz,[spalva1,'.'],'MarkerSize',8)
    title('Eulerio zingsnis deltax/2','Color',spalva);
            pause  % stabdymas vizualizacijai
        % apskaiciuojame  desines puses funkcija prie (x+dx/2,yz)
    dyz=eval(subs(subs(fp,sym(xp),str2sym('x+dx/2')),sym(yp),sym('yz')));
    yzz=y+dx/2*dyz; % atgaline Eulerio formule
    plot([pntx,x+dx/2],[pnty,yzz],[spalva1,'--']); plot(x+dx/2,yzz,[spalva2,'.'],'MarkerSize',8)% braizome pagal nauja "liestines" krypti
    title('atgalinis Eulerio zingsnis deltax/2','Color',spalva1);
            pause  % stabdymas vizualizacijai
    dyzz=eval(subs(subs(fp,sym(xp),str2sym('x+dx/2')),sym(yp),sym('yzz')));
    yzzz=y+dx*dyzz; % vidurinio tasko formule
    plot([pntx,x+dx],[pnty,yzzz],[spalva2,'--']); plot(x+dx,yzzz,[spalva3,'.'],'MarkerSize',8)%  braizome pagal nauja "liestines" krypti
    title('vidurinio tasko formule zingsniu deltax','Color',spalva2);
            pause  % stabdymas vizualizacijai
    dyzzz=eval(subs(subs(fp,sym(xp),str2sym('x+dx')),sym(yp),sym('yzzz')));
    
    %********
    if 0
    % Vizualizuojame, kaip atrodytu atgalinis Eulerio zingsnis per dx,
    % naudojant dyzzz isvestines iverti
    yzzzz=y+dx*dyzzz; % skaiciuojant realiai, sio veiksmo atlikti nereikia 
    plot([pntx,x+dx],[pnty,yzzzz],'Color',spalva4,'Linestyle',':');plot(x+dx,yzzzz,'.','MarkerSize',8,'Color',spalva4); 
    title('taip gautume, atlike atgalini Eulerio zingsni deltax','Color',spalva4);
    %********
    end
    pause  % stabdymas vizualizacijai
    
    y=y+dx*(dy+2*dyz+2*dyzz+dyzzz)/6  % Heuno (II RK) formule
    plot([pntx,x+dx],[pnty,y],['k-']);plot(x+dx,y,[spalva,'.'],'MarkerSize',8); % braizome sekanti apskaiciuota taska
    title('Simpsono korekcija','Color','k');
            pause  % stabdymas vizualizacijai
    x=x+dx % argumento prieaugis per 1 zingsni
    pntx=x;pnty=y; % prisimename apskaiciuota taska (tik braizymui)
    xxx=xxx+dx;  % vaizdavimo taskai perstumiami i sekanti zingsni 
end

return,end

%------------------------------------------------------------------------
% analitinis sprendinys:
function y=sprendinys(x); y=-exp(-x)+1; return,end  
%------------------------------------------------------------------------