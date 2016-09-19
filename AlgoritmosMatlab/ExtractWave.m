function [tankName] = ExtractWave(tankDir,block,tankName,tankSort,epocTime, epocName)
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
%  controlYYMMDD. If none is declared, tankName is setted do Subject
%
%
%  [tankName] = ExtractTank(tankDir,block,tankName,tankSort) tankSort is a
%  string variable that will change the sort code called. If none is
%  declared, tankSort will be declared SortOFF
%
%
%  [tankName] = ExtractTank(tankDir,...,epocTime,epocName). epocTime must
%  be a vector of 2 components, the first one is the time to extract before
%  epoc start, the second one is the time to extract after epoc end, e.g.,
%  epocTime = [ time_before time_after ]. If epocTime is not declared, then
%  will be used a vector of [5 5].
%  epocName will change which variable the algorithm will use for extract
%  epocs. If none is declared, then CSap will be used

%%

error(nargchk(2,6,nargin)) %User must give to algorithm tank directory and block name

if nargin < 3, tankName = 'Subject'; end %set a general name to variable

if nargin < 4, tankSort = 'SortOFF'; end %set an offline sort if there's no sort declared

if nargin < 5
    time_before = 5;        % time (in seconds) before the epoc onset for analysis
    time_after  = 5;        % time (in seconds) after the epoc onset for analysis
elseif length(epocTime) == 2        %epocTime must be a vector of length equal 2
    time_before = abs( epocTime(1) );  %absolute value to avoid negative value
    time_after  = abs( epocTime(2) );
else
    error('epocTime must be a vector of length 2')
end

if nargin < 6, epocName = 'CSap'; end


%% Extract Algorithm
tic
%Parameters

TTX = actxcontrol('TTank.X');
TTX.ConnectServer('Local','Me');
TTX.OpenTank(tankDir,'R');
TTX.SelectBlock(block);
TTX.CreateEpocIndexing; % Allow to extract data by epocs

% Parameters for data extraction
LFPfs = 1017.26;

% Codes for TDT data extraction
ts_code = 6;            % code to extract time stamps (ts) in ParseEvInfoV

%Extraction    (Order of called variables interferes in

epoc = TTX.GetEpocsExV(epocName,0); %second argument allow to return entire epoch
totalTime = (epoc(2,1)+5) - epoc(2,1) + time_before + time_after;
wavePoints = round( LFPfs * totalTime);

Waves=zeros(wavePoints,32,120);

% TTX.SetUseSortName(tankSort); % declare which sort you are using!

for ch = 1:32
    TTX.SetGlobalV('Channel', ch);
    
    
     for sc = 1:5
         TTX.SetGlobalV('SortCode', sc);
        
        for trial= 1:length(epoc)
            
            TTX.SetGlobalV('T1',epoc(2,trial) -  time_before);
            TTX.SetGlobalV('T2',epoc(2,trial)+5 +  time_after );
            N = TTX.ReadEventsSimple('eNeu');
            data(ch,sc,trial).timeStamps = TTX.ParseEvInfoV(0,N,ts_code);
            data(ch,sc,trial).spikes = TTX.ParseEvV(0, N);
            
            
        end
        
     end
    
    TTX.SetGlobalV('SortCode',0); %Problems calling Waves varying sortcode
    for trial= 1:length(epoc)
        
        TTX.SetGlobalV('T1',epoc(2,trial) - time_before);
        TTX.SetGlobalV('T2',(epoc(2,trial)+5) + time_after );
        Waves(:,ch,trial) = TTX.ReadWavesV('Waves');
        
        
    end
end

data(1,1,1).Wave = Waves;
data(1,1,1).epoc = epoc;
data(1,1,1).epocName = epocName;
data(1,1,1).tankDir = tankDir;
data(1,1,1).tankName = tankName;
data(1,1,1).blockName = block;
data(1,1,1).time_windows = [time_before time_after];

%naming data with tankName string
assignin('base',data(1,1,1).tankName,data);


%saving variable
cd(tankDir)
varName = [tankName,'.mat'];


save (varName, 'data')

TTX.CloseTank

TTX.ReleaseServer
% toc
% sound(sin(2*pi*1000*0:1000))
end

%Author: Eliezyer Fermino de Oliveira

%Version: 1.0.1 $Date: 2014/08/27 $

