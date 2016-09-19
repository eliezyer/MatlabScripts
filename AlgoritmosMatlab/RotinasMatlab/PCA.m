%Computa o comando princomp e plota as 3 primeiras componentes

[coeff, score, latent] = princomp(spikes);

figure(5), plot(score(:,1),'r')
hold on
plot(score(:,2),'b')
plot(score(:,3),'k')
xlabel(int2str(e))
legend(['Component 1';'Component 2';'Component 3'])
hold off