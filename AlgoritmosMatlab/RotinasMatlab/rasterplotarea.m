%raster plot com comando area

e=1;
count = 5;
figure
hold on

    for i=1:N %este irá fazer a varredura dentro do timestamps
        
        if (timestamps(1,i) <= count)
            
            
            area([5+(timestamps(1,i) - count)-0.01 5+(timestamps(1,i) - count)+0.01], [e e], e-.8,'FaceColor','r')
            alpha(0.5)
            
        elseif (timestamps(1,i) > count)
            
            count=count+5;
            e=e+1;
             
            
        end
                
    end
    
    
   