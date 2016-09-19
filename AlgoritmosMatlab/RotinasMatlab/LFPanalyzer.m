function LFPanalyzer(data1,data2,name)
close all

%% Parameters and folders

% setpath = input('Enter with the path to save images and data: ','s');
% name = input('Enter with the date (yymmdd) of data: ','s');

controlName = data1(1,1,1).tankName;
shockName   = data2(1,1,1).tankName;

%original content CD(SETPATH)!!!!
setpath = cd;
mkdir(name) %here the algorithm creates a folder with the name/date of data

fullpath = strcat(setpath,filesep,name);  %make a string to set a path inside the new folder
cd(fullpath); 

%% Data treatment, here the algorithm will clean up spikes too

%filter the specifica bands as Delta, Theta, Beta, Slow Gamma and Fast
%Gamma

[data1]=bandfilter(data1,1);
[data2]=bandfilter(data2,0);


%Spectrogram in bands of electrophysiology
% BandSpectrogram(data1);
% BandSpectrogram(data2);

print(figure(1),'-dpng','DeltaBodePlot.png')
print(figure(2),'-dpng','ThetaBodePlot.png')
print(figure(3),'-dpng','BetaBodePlot.png')
print(figure(4),'-dpng','SlowGammaBodePlot.png')
print(figure(5),'-dpng','FastGammaBodePlot.png')
% print(figure(6),'-dpng',strcat(controlName,'LFP.png'))
% print(figure(7),'-dpng',strcat(shockName,'LFP.png'))
string1 = [controlName,'_Filtered.mat'];
save(string1,'data1','-v7.3');

string2 = [shockName,'_Filtered.mat'];
save(string2,'data2','-v7.3');

end