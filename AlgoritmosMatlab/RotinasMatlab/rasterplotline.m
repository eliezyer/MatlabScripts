%raster plot com comando plot

figure
subplot(2,1,2)
hold on
H = 0;
chan = 32;

    
         
         for ep=1:length(epoc) %este irá fazer a varredura dentro das épocas
            a = 1;
            clear indice
            
           
            
            for comp = 1:length(channels{1,ep})    %separa os índices onde há spikes específicos de cada canal, podendo assim plotar seletivamente
            if (channels{1,ep}(comp) == chan);
                
                    indice(a) = comp;
                    a = a+1;
                    
            end
            end
            
        
            for b = 1:length(indice)
                plot([timestamps{1,ep}(indice(b))-epoc(2,ep) timestamps{1,ep}(indice(b))-epoc(2,ep)], [ep-1 ep],'k')
                H = hist(timestamps{1,ep}-epoc(2,ep),100) + H;
            end
        
        
         end
         
  
        
subplot(2,1,1)
bar(linspace(-5,10,length(H)),(H/(100*30)))
xlim([-5 10])
 
    
   