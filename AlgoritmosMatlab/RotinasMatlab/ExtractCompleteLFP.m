function [data] = ExtractCompleteLFP(tankDir,block,tankName)
%This is a algorithm to extract data from TDT tanks,specifically for tank
%data that have epocs. It brings important information from tanks to a
%matlab structure.
%The structure is organized in channels x sort codes x number of epocs. For
%example: data(32,3,30) has 32 channels, 3 sort codes and 30 epocs.
%Inside of every index in data you can call time stamps and waveform of
%spikes by declaring data(ch,sc,trial).timeStamps and 
%data(ch,sc,trial).spikes. All LFP wave and epoc information are attached
%in the 1x1x1 index | data(1,1,1).Wave | data(1,1,1).epoc
%
%  [tankName] = ExtractTank(tankDir,block) Returns a structure with time
%  stamps, spikes waveforms, LFP waves, sortcodes and epoc information 
%  located in a diretory specified by tankDir string value and in a block 
%  specified by user. Do not forget to put a '~' before block name, e.g.,
%  '~Block-2'.
%
%
%  [tankName] = ExtractTank(tankDir,block,tankName) tankName will name your
%  structure data to a desire name. Examples of name are shockYYMMDD or
%  controlYYMMDD. If none is declared, tankName is setteed do Subject
%

%% Extract Algorithm

%Parameters
epocName = 'CSap';
TTX = actxcontrol('TTank.X');
TTX.ConnectServer('Local','Me');
TTX.OpenTank(tankDir,'R');
TTX.SelectBlock(block);
TTX.CreateEpocIndexing; % Allow to extract data by epocs

% Parameters for data extraction
LFPfs = 1017.26;

%Extraction    (Order of called variables interferes in

epoc = TTX.GetEpocsExV(epocName,1); %second argument allow to return entire epoch
TTX.SetGlobalV('T1',epoc(2,1)); %Time to start extracting of waves
TTX.SetGlobalV('T2',epoc(3,40)); %Time to end extracting of waves

%TTX.SetUseSortName(tankSort); % declare which sort you are using!

for ch = 1:32
    TTX.SetGlobalV('Channel', ch);
    
    Waves(:,ch) = TTX.ReadWavesV('Waves');
    
end

data(1,1,1).Wave = Waves;
data(1,1,1).tankName = tankName;

%saving variable
cd(tankDir)
varName = [tankName,'_LongWave.mat'];
save(varName,'data')

TTX.CloseTank

TTX.ReleaseServer

end

%Author: Eliezyer Fermino de Oliveira

%Version: 1.0.1 $Date: 2014/08/27 $

