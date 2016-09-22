cd C:\Users\guilherme.souza\Documents\MATLAB\imagens  %Alterar para computador.

Sub_id = [103 104 105 106 107 108 109 110 111 112 113 114] ; %Alterar id dos ratos.
Sessao = 4; %Alterar sessão.
G1='ASLP';
G2='ASNP';
G3='DRRD';
gl_lim=106; %maior número do grupo(alterar de acordo com a numeração dos ratos).
gn_lim=110; %maior número do grupo(alterar de acordo com a numeração dos ratos).
gd_lim=114; %maior número do grupo(alterar de acordo com a numeração dos ratos).

for i = 1:length(Sub_id)
    var=1;
    rato=Sub_id(i);
    
    %     Gráfico de apenas uma sessão
    
    D = drrd('AH0', rato, Sessao);         %Função para extração dos dados de cada sessão.
     %      xlim([0 7]); %Limita o eixo x até Xs
    
    if isempty(D)
        i=i+1;
        rato=Sub_id(i);
        D = drrd('AH0', rato, Sessao);
    end
    
    
    %      SESSÕES INDIVIDUAIS
    
   
    if rato <=gl_lim
        print(['AH0', num2str(Sub_id(i),3), '_', num2str(Sessao,3), '_', G1],'-dpng')  %Salva o diagrama de cada sessão para os ratos do grupo ASLP.
    elseif rato>gl_lim && rato<=gn_lim
        print(['AH0', num2str(Sub_id(i),3), '_', num2str(Sessao,3), '_', G2],'-dpng')  %Salva o diagrama de cada sessão para os ratos do grupo ASNP.
    elseif rato>gn_lim
        print(['AH0', num2str(Sub_id(i),3), '_', num2str(Sessao,3), '_', G3],'-dpng')  %Salva o diagrama de cada sessão para os ratos do grupo DRRD.
    end
    
    

    
    peak = compareSessionDistributions('AH0',rato,Sessao);     %Plota o grafico de distribuição da sessão.
    
    %        ylim ([0 1.5])
    
    %            K= D(1,5);
    %            J=(size(D));
    %            H=D(J(1),5);
    %            plot([H H],ylim, 'r--')                                              %Critério final
    %            plot([K K],ylim, 'b--')                                              %critério inicial
    %            plot([0.5 0.5],ylim,'k--')                                           %500ms
    
    
    
    
    if rato <=gl_lim
        print(['Hist_AH0', num2str(Sub_id(i),3),'_00',num2str(Sessao,3), '_', G1],'-dpng')  %Salva o diagrama de cada sessão para os ratos do grupo ASLP.
    elseif rato>gl_lim && rato<=gn_lim
        print(['Hist_AH0', num2str(Sub_id(i),3),'_00',num2str(Sessao,3), '_', G2],'-dpng')  %Salva o diagrama de cada sessão para os ratos do grupo ASNP.
    elseif rato>gn_lim
        print(['Hist_AH0', num2str(Sub_id(i),3),'_00',num2str(Sessao,3), '_', G3],'-dpng')  %Salva o diagrama de cada sessão para os ratos do grupo DRRD.
    end
    
    
    
    
    
    %     %       TODAS AS SESSÕES
    %
    %
    %             D = gatherDrrd('AH0',rato,var:Sessao,true,false);                  %Plota o diagrama de todas as sessões para cada rato.
    %             print(['All_AH0', num2str(Sub_id(i),2), '00'],'-dpng')
    %
    %             peak =compareSessionDistributions('AH0',rato,var:Sessao);          %Plota a distribuição de todas as sessões para cada rato.
    %
    %             plot([0.5 0.5],ylim)
    %             print(['All_Hist_AH0', num2str(Sub_id(i),2), '00'],'-dpng')
    
    
    
end

