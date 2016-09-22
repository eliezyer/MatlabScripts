function allOdds = cp_reyes(x,N)
%function allOdds = cp_reyes(x,N)

%odds = 4;
%N = 25;

if length(x)<2*N
    warning(1,'Series too short, returning empty vector');
    allOdds = [];
    return;
end

ret = NaN(length(x),1);
close all;

aux = [];
for k = N:length(x)-N-2

    [~, p] = ttest2(x(k-N+1:k),x(k+1:k+N+1));
    
    % use the line below for matlab
    %[~, p] = kstest2(x(k-N+1:k),x(k+1:k+N+1));
    % or the line below for octave
    %[p,aux,aux] = kolmogorov_smirnov_test_2(x(k-N+1:k),x(k+1:k+N+1));

        ret(k) = (1-p)/p;
end

allOdds = ret;


