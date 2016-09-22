function peak = compareSessionDistributions(prefix,animalID,sessions)
%function peak = compareSessionDistributions(prefix,animalID,sessions)
% ___________________________________________________________________________________________
% File:             compareSessionDistributions.m
% File type:        Function
% Created on:       Around September, 2013
% Created by:       Marcelo Bussotti Reyes
% Last modified on: February 26, 2015
% Last modified by: Marcelo Bussotti Reyes
% Modifications:
%
%2015_02_26         Included option to analyze data from autoshape phase.
%                   If it is an autoshape session, it parses the flag
%                   isAutoshapeSesson=true to the drrd.m function (which in
%                   turn adds a letter A to the end of the filename
%
% Purpose:          A function that analyzes the performance of rats in the drrd
%                   procedure over several sessions by comparing the probability
%                   distributions for each sessions. Distributions are smoothered
%                   by a gaussian function.
%
% Input:            File name prefix as a string, animal id as a number and
%					session as an array (e.g 1:5 analyzes sessions one through
%                   5. Filene name are in the format: [PPPAAA.SSSA] where PPP
%                   is the prefix label (experiment id) AAA is the animal number
%                   and SSS is the session to be analyzed. A is an optional
%                   label that identifies the Autoshape sessions.
%
% Output:           peak, array containing the peak times for each session
%
% Coments:          Uses functions: drrd.m, med2tec.m, plotDrrd.m (all
%                   though drrd.m),
%
%
% Format:           peak = compareSessionDistributions(prefix,animalID,sessions,isAutoshapeSession)
% Examples:
%                   peak = compareSessionDistributions('AE0',1,1:5,false);
%                       runs analysis for experiment AE0, animal 1, sessions 1 through5 not
%                       for autoshape.
%                   peak = compareSessionDistributions('AB1',10,[1 3 5 7]);
%                       runs for AB1, animal 10, sessions 1, 3, 5 and 7.


% Todo: fix the plot using the dt/2: replace the histc by hist (check
% documentation.

% obsolete
%if ~exist('isAutoshapeSession','var')
%    isAutoshapeSession = false;         % defaulte is the drrd session, not autoshape
%end

close all;

dt = 0.02;               % delta T for histogram calculation 0.02
rng = 0:dt:5;           % range of times for binning histogram
sigma = 0.1;            % standard deviation for the gaussian for smoothing (0.2 for Diegos thesis)

lnClr = {'k' 'r' 'm' 'g' 'c' 'y' [.3 .3 .3] [.4 .4 .4] [.5 .5 .5] [.6 .6 .6] [.7 .7 .7] [.8 .8 .8]};
maxClr = 12;

gauss = dt/sqrt(2*pi())/sigma*exp(-0.5*((rng-mean(rng))/sigma).^2);

count = 1;
lgnd={};
hc = rng(:);


for k = sessions
    D = drrd(prefix,animalID,k,false,false);
    
    if ~isempty(D)
        n = histc(D(:,1),rng);
        n = n/length(D(:,1))/dt;
        
        %stairs(rng,n,'-','color',lnClr{clrCount},'linewidth',2) ; hold on;
        
        hc(:,count) = n(:);         % gets the histogram counts (hc) in a columnn vector
        
        C = conv(n,gauss,'same');   % convolves the histogram counts with a gaussian for smoothig
        
        hold on;
        disp(mod(count,maxClr));
        plot(rng+(dt/2),C,'-','markerfacecolor','w',...    % plots the smooth function
            'color',lnClr{mod(count-1,maxClr)+1},...
            'linewidth',3,'markersize',5);
        lgnd{end+1} = ['sessão ' num2str(k,'%g')];
        
        %stairs(rng,hc,'k-','linewidth',1);
        
        ind = find(C == max(C),1,'last');
        peak(count,:) = [rng(ind) + dt/2 C(ind)];
        disp(peak);
    end
    count = count+1;
end

title(['Rato ' num2str(animalID)],'fontsize',18,'fontname','arial');
legend(lgnd,'location','NE');
xlim([min(rng) max(rng)]);
set(gca, 'box','on');
xlabel('tempo (s)','fontsize',18,'fontname','arial');
ylabel('P[tempo]'    ,'fontsize',18,'fontname','arial');
set(gca,'fontsize',16);

%% plotting the peak positions
%for k = 1:count-1
%    plot(peak(k,1),peak(k,2),'o-','markerfacecolor','w',...
%        'color',lnClr{mod(k-1,maxClr)+1},'linewidth',2);
%end

%figure;
%plot(hc-C);
%disp(mean(hc-C));
%disp(mean(hc-C).^2);


%figure; hold on;
%plot(sessions,peak(:,1));

