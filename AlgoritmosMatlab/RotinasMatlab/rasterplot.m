%raster plot

e=1;
count = 5;
figure
hold on

    for i=1:N %este ir� fazer a varredura dentro do timestamps
        
        if (timestamps(1,i) <= count)
            
            plot(5+(timestamps(1,i) - count),e,'sk','LineWidth',2,'MarkerSize',6,'MarkerEdgeColor','k','MarkerFaceColor','none')
            alpha(0.5)
        
        elseif (timestamps(1,i) > count)
            
            count=count+5;
            e=e+1;
             
            
        end
                
    end
    
   