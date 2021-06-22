function RK4_metodas_parasiutas

clc, clear all,
close all

% sistemos parametrai: 
m=100, g=9.81, H=1000, Hp=600  ;  %mase, pradinis aukstis
v0=[100;20;0] , %pradinis greitis
vvmaxh=[1;40;0] %vejo greitis aukstai
vvminh=[5;2 ;0]    %vejo greitis zemai
% vv=vvminh+(vvmaxh-vvminh)*z/H  % formule

c=0.01 %Ns/m  pasipriesinimo koeff be parasiuto
ch=5 %Ns/m  horizintalus pasipriesinimo koeff su parasiutu
cv=18 %Ns/m  vertikalus pasipriesinimo koeff su parasiutu
cp=[ch;ch;cv];

r0=[0;0;H] %pradine padetis 

color='b';

tmax=200;           % sprendimo intervalo pabaiga 
dt=0.1;
figure(1),set(gcf,'Color','w'); hold on, grid on, box on 
axis equal,view([1 1 0.5]); 
xlabel('x');ylabel('y');zlabel('z');axis equal 
zh=0:H/20:H;izh=length(zh);
axis([0 3000 0 3000 0 1000]);xrng=xlim;yrng=ylim;
fill3([xrng(1),xrng(2),xrng(2),xrng(1)],[yrng(1),yrng(1),yrng(2),yrng(2)],[0 0 0 0],[0 1 0]);
for i=1:izh  % braizo vejo vektorius
    vv=vvminh+(vvmaxh-vvminh)*zh(i)/H;
    quiver3(0,0,zh(i),vv(1),vv(2),vv(3),20); 
end
t=0;r=[r0;v0];      % pradines reiksmes 

ttt=[0:dt:tmax];
ix=0;  % kai pasieks zeme, taps ix=1
[TT,YY]=ode45(@fnk,ttt,r); % PDL sprendimas
hndl=[]; % pradine markerio valdiklio reiksme  
ttp=0; % laikas vizualizacijos valdymui
vaizdavimas
quiver3(0,0,H,v0(1),v0(2),v0(3),20,'LineWidth',3)
for i=1:length(TT)
    r=YY(i,:);
    vaizdavimas; %vaizdavimas kiekviename zingsnyje
    if r(3) < 0 , break,end
    if ttp==0,disp('***** Press Key'),pause,ttp=0.01;else, pause(ttp);end;
    str=sprintf('t=%5.3g x=%5.3g y=%5.3g z=%5.3g',TT(i),r(1:3));title(['\fontname{Courier}',str]);
end

return   % pagrindines programos pabaiga

% &&&&&&&&&&&&&&&&&&&&&&&&   vidines funkcijos &&&&&&&&&&&&&&&&&&&&&&&&&&&&
function dy=fnk(t,yyy) % Lygciu sistemos funkcija
    v=yyy(4:6); z=yyy(3); dy(1:3,1)=v;
    vv=vvminh+(vvmaxh-vvminh)*z/H;
    if z>Hp, Fr=-c*norm(v-vv)'*(v-vv);
    else,    Fr=-cp.*((v-vv).^2).*sign(v-vv);
    end
         dy(4:6,1)=Fr/m-[0;0;g];
         if z<0,dy=zeros(6,1); % jeigu pasieke zeme, toliau nebejuda
               if ix == 0, ix=1;  tg=t;rg=yyy(1:3); end % prisimename, kada ir kur nusileido 
         end
    return
end

 
function vaizdavimas  % Vaizdavimo funkcija
    x=r(1);y=r(2);z=r(3);
    if ~isempty(hndl), set(hndl,'Color',[1 1 1]*0.7);end
    if z > Hp, hndl=plot3(x,y,z,[color,'s'],'MarkerSize',4);
    else hndl=plot3(x,y,z,[color,'*'],'MarkerSize',8);
    end
    return 
end
% &&&&&&&&&&&&&&&&&&&&&&&&   vidiniu funkciju pabaiga &&&&&&&&&&&&&&&&&&&&&
    
end


