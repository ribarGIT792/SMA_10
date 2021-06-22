% Skirtingu aukstesniuju eiliu metodu stabilumo tyrimas
clc, close all, clear all
xxx=[-6:0.001:1]; % braizymo sritis
maxeile=10;
a=1
figure(1),grid on,hold on,set(gcf,'Color','w');xlim([-6  1]);ylim([0  1.5]); 
plot(xxx,ones(1,length(xxx)),'r-');
leg={sprintf('y(x)=%d',1)};hleg=[];
colormap('jet')
cmap=colormap
cmp=size(colormap,1)
dcmp=floor(cmp/(maxeile-1));
for eile=1:maxeile
    % spalvos kodas:
    spalva=cmap(1+(eile-1)*dcmp,:)

    fff=1;for j=1:eile, fff=fff+a*xxx.^j/factorial(j);end

    plot(xxx,abs(fff),'Color',spalva,'Linewidth',2); 
    
    leg={leg{:},sprintf('eile=%d',eile)};
    if ~isempty(hleg),delete(hleg);end;
    hleg=legend(leg);
    pause
end
xlabel('\alpha*\Deltax');ylabel('E');title('Aukstesnes eiles metodu stabilumo intervalai','Color',spalva); 

  
