cd C:\Users\guilherme.souza\Documents\MATLAB %Alterar para computador

clear all

ratos  = 103:114; %Alterar a quantidade de ratos.
grupos = [ 1 1 1 1 2 2 2 2 3 3 3 3]; 


% ratos  = 74:78;
% grupos = [ 1 2 2 3 3];
Sessao =3;

i=1;
j=1;
l=1;

M=NaN(length(ratos),5);

% M= matriz com os dados de cada rato
% Col1= Ratos;
% Col2= Grupos;
% Col3= Total de tentativas; 
% Col4= Total de respostas prematuras;
% Col5= Porcentagem de respostas prematuras;


for k = 1:length(ratos) 
    D = drrd('AH0', ratos(k), Sessao);
    Trials = length(D(:,1))-sum(D(:,4)==0);
    Recompensadas
    Porcentagem_prematuras=(countPremature(D)/Trials)*100;
    M(k,:) = [ratos(k) grupos(k) Trials countPremature(D) Porcentagem_prematuras]; 
    
    if grupos(k)==1
        ASLP(i)=Porcentagem_prematuras;
        Reforcadas_ASLP(i)=(sum(D(:,3))/Trials)*100;
        i=i+1;
    elseif grupos(k)==2
        ASNP(j)=Porcentagem_prematuras;
        Reforcadas_ASNP(j)=(sum(D(:,3))/Trials)*100;
        j=j+1;
    elseif grupos(k)==3
        DRRD(l)=Porcentagem_prematuras;
        Reforcadas_DRRD(l)=(sum(D(:,3))/Trials)*100;
        l=l+1;
    end
        
%     plot(M(:,5),M(:,2),'ko');
end
  close all
  
x=[1 1; 2 2; 3 3];  
y=[mean(ASLP) mean(Reforcadas_ASLP); mean(ASNP) mean(Reforcadas_ASNP); mean(DRRD) mean(Reforcadas_DRRD)];
bar(x, y,'grouped')
colormap winter
hold on;
dt = 0.15;
z=[1-dt 1+dt; 2-dt 2+dt; 3-dt 3+dt];

Reforcadas_ASLP;
Reforcadas_ASNP;
Reforcadas_DRRD;

plot(1-dt,ASLP,'k>','markerfacecolor','k');
plot(1+dt,Reforcadas_ASLP,'k>','markerfacecolor','k');

plot(2-dt,ASNP,'k>','markerfacecolor','k');
plot(2+dt,Reforcadas_ASNP,'k>','markerfacecolor','k');

plot(3-dt,DRRD,'k>','markerfacecolor','k');
plot(3+dt,Reforcadas_DRRD,'k>','markerfacecolor','k');

% e=[std(ASLP) std(Reforcadas_ASLP); std(ASNP) std(Reforcadas_ASNP); std(DRRD) std(Reforcadas_DRRD)];
% errorbar (z,y,e,'k');




ylim([0 100])
% title(['ErroPadrão','.Sessão',num2str(Sessao,2)])
xlabel('Grupos')
ylabel('Porcentagem')
legend('Respostas prematuras', 'Respostas reforçadas', 'location', 'northWest')
% print (['prematutasbarra2','_sessao', num2str(Sessao,2)], '-dpng')


%---------------------------------

% este_grupo = 1;
% estes_Rats = ratos(grupos==este_grupo));



