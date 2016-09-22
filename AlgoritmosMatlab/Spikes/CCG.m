%creating a model of excitatory synapse

%% Parameters declaration

%nC = 5; %number of neurons
nF = 10000; %number firing
timeStampsCellA = rand(1,nF);
timeStampsCellB = zeros(1,nF);
CCGwindow = 0.05;%in s, remember it is a -CCGwindow to CCGwindow
nBins = 100; %number of bins to use in -CCGwindow to CCGwindow
binSize = (2*CCGwindow)/nBins; %in s


%% Simple excitatory connection

for idx = 1:nF
   timeStampsCellA(1,idx) = timeStampsCellA(1,idx) + idx; 
end

for idx = 1:nF
    timeStampsCellB(1,idx) = timeStampsCellA(1,idx) + ((0.001*randn)+0.006);
end

%% CCG execution

for idx = 1:length(auxDif)
     %VERIFICAR SE HA PROBLEMA EM FAZER O FIND, POIS SE HOUVER BURST DE
     %DISPAROS ELE SERA CONTADO VARIAS VEZES COMO DISPARO POS DISPARO
     %CELULA A. VERIFICAR MAIS ARTIGOS, MAS ACREDITO QUE TEREI QUE MONTAR
     %UM FOR MESMO, POIS O NUMERO DE DISPARO DOS NEURONIOS E DIFERENTE
end
auxDif = timeStampsCellB-timeStampsCellA;
rng = -CCGwindow:binSize:CCGwindow;
binCount = histc(auxDif,rng);


%% CCG plot

bar(rng,binCount);xlim([-CCGwindow CCGwindow])