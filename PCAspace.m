function [PC,PCData] = PCAspace(data,ncomp)

%Function to calculate PCA and put data to PCA space

if size(data,1)  < size(data,2)
   data = data'; 
end

[coeff,score] = princomp(data');
PC = zeros(size(data,2),ncomp);
for idx = 1:ncomp
    PC(:,idx) = score(:,idx);
end

PCData = data*PC;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                     %
%    Author: Eliezyer F. Oliveira                     % 
%    $Date: August 3rd, 2016                          %
%                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%