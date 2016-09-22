function ret = plotDrrd(D, title_label)
%function ret = plotDrrd(D, title_label)
% Each line of the matrix D is a trial
% Collumn 1 is the duration of the lever press
% Collumn 2 is the the time between the lever release and the next lever press (ITI)
% Collumn 3 is 1 for the reinforced trials
% Collumn 4 is 1 for trials where the light was on (valid trials)
% Collumn 5 shows the criterion (prime time) for each trial

if nargin == 1
	title_label = [];
end

primed  = 3;		% collum
valid   = 4;
primeT  = 5;
session = 6; 	% column with the session number
N = size(D,1);

% --- looking for the specific trials ---
validPrimed 	= find(D(:,primed)==1 	& D(:,valid)==1);
validNonPrimed 	= find(D(:,primed)==0 	& D(:,valid)==1);
invalid			= find(D(:, valid)==0); 

clf; hold on;

% --- plotting the prime times ---
%plot(D(:,primeT),1:N,'r','linewidth', 1.5);

% --- alternative: patch ---
% patch([ D(:,5); 0.01; 0.001], [1:N N 1], [.7 .8 .7] ,'EdgeColor' ,'none');% % [.7 .8 .7]
patch([ D(:,5); 0.02; 0.02], [1:N N 1], [.7 .5 .2] ,'EdgeColor' ,'none');% % [.7 .8 .7]

% N = size(D,1);
% auxIndices = find(D(:,5) > D(1,5));
% D(auxIndices,5) = 2.0;
% patch([ D(:,5); 0.02; 0.02], [1:N N 1], [.7 .5 .2] ,'EdgeColor' ,'none');


% --- Plotting the moving average of the lever press durations ---
%plot(movingAverage(D(:,1),20),1:N,'linewidth',2);

% --- Plotting each trial in a different style ---
plot(D(validPrimed,1)   ,validPrimed,   'ko','markersize',4, 'markerfacecolor','k');
plot(D(validNonPrimed,1),validNonPrimed,'ko','markersize',5, 'markerfacecolor','w','linewidth',1);
plot(D(invalid,1)		,invalid,		'r.','markersize',10);

% --- setting up the scale and title ---
if D(end,5)>1                       % checks if there was a positive creterion
    xlim([0 2*D(end,5)]);           % if so, adjusts x scale to be proportional to it
else
    xlim([0 4]);                    % otherwise keeps the x scale "basic"
end
    
xlabel('Tempo (s)','fontsize',16);
ylim([0 N+5]);          ylabel('Tentativa','fontsize',16);
title(title_label,'fontsize',14);
set(gca,'box','on','fontsize',12);

% --- printing the lines dividing the sessions ---
div = find(diff(D(:,session)));
for k = 1:length(div)
	plot(xlim,[div(k) div(k)],'k--');
end

% --- mounting return variable ---
ret = [length(validPrimed)/N length(validNonPrimed)/N length(invalid)/N] *100;


