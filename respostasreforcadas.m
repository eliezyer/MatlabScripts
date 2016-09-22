cd C:\Users\guilherme.souza\Documents\MATLAB %Alterar para computador

%Este código calcula quantos reforços cada rato de cada grupo recebe até
%realizar o primeiro avanço de critério (500 para 600 ms)


clear all

% Experimento 1
ratos  = [79:90];
grupos = [ 1 1 1 1 2 2 2 2 3 3 3 3];

x=0;

Sessao =[1 2 3 4 5 6 7];
for k = 1:length(Sessao)
    x=x+1;
    j=1;
    l=1;
    m=1;
    
    
    for i=1:length(ratos)
        
        D= drrd('AH0',ratos(i),Sessao(k),1,0);close all
        
        
        
        if isempty(D)
            primeirasrespostas=0;
            
        elseif D(:,5)>0.5
            primeirasrespostas=NaN;
            
            
        else
            criterio500= find (D(:,5)==0.5);
            primeirasrespostas=sum(D(criterio500,3));
            
        end
        
        
        if grupos(i)==1
            ASLP(j,x)= primeirasrespostas;
            j=j+1;
        elseif grupos(i)==2
            ASNP(l,x)= primeirasrespostas;
            l=l+1;
        elseif grupos(i)==3
            DRRD(m,x)= primeirasrespostas;
            m=m+1;
        end
        
        
        
    end
    
    
end