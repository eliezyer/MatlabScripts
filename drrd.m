function D = drrd(prefix, animalID, session, plotFlag,saveMatFlag)
%function D = drrd(prefix, animalID, session, plotFlag,saveMatFlag)
% ___________________________________________________________________________________________
% File:             drrd.m
% File type:        Function
% Created on:       September 25, 2013
% Created by:       Marcelo Bussotti Reyes
% Last modified on: March 3, 2015
% Last modified by: Marcelo Bussotti Reyes
% Modifications:     
%
%2015_03_03         Now I gave up on differentiating the autoshape function
%                   and I just check if there is an autoshape session, but
%                   analyse it just as if it was a normal session.
%                   Basically I revogued the modification below(15_02_26). 
%2015_02_26         Included option to analyze data from autoshape phase.
%                   In this phase, the file names are EEE###.%%%A. EEE are
%                   the experiment label (e.g. AB1, #### is the number of
%                   the rat, %%% is the session number and the A means
%                   autoshape. 
%2014_08_29         Fixed bug: when the animal did not respond at all
%                   during the session, there was an error in the funciont
%                   findValidTrials when it tried to access st(end), while st
%                   was empty. Not it checks if there is at least one valid 
%                   trial, and if not, returns D = [];
%2014_08_26 (MBR)   When filename is not found, now returns a mesage
%                   stating so.
%2014_08_25 (MBR)   Function now prints the session number along with the
%                   animal number and other performance information
%2014_08_?? (MBR)   Included a verification if the file exists before initiating 
%                   the analysis. Eliminated routine that eliminates trials for which the
%                   ITI was smaller than a certain cutoff. Included a new
%                   condition that detects when there are fewer than 3
%                   responses and avoids a second comparison.
%
% 2014_08_21 (MBR)  makeFileName updated to use the prefix parsed
% 2013_11_22 (MBR)  Included the option of saving a matlab file with the
%                   matrix D. This helps to speed up the analysis when
%                   several sessions and animals are to be analyzed.
%                   Included session column (6th) and the input format
%	
% Purpose:          A function that analyzes the performance of rats in the drrd
%                   procedure. The animals are supposed to press a lever for a
%					duration longer than the prime time in order to receive food.
%
% Input:            File name prefix as a string, animal id as a number and 
%					session as a number. Filene name are in the format:
%					[prefix00A.00S] where A is the animal and S is the sesson 
%
% Output:           D, a matrix with 6 columns containing data from a trial in 
%					each line.
%                   In case saveMatFlag is parsed as true, the program will
%                   save a matlab file (.mat) with the same name as the
%                   original data file.
% Coments:          Uses functions: med2tec.m, and plotDrrd.m
%
% Format:           drrd(prefix,animalID,session))
% Example:          D = drrd('AB1',1,2'); 
%					this will analyze the file AB1001.002, animal 1 and session 2 

%Todo
% To make sure that the number of events is correct, e.g. if the number of trials
% when the lever was pressed is the same as the releases. There is a possible problem
% that the animal may be pressin the lever when the trial starts. This would produce
% a lever release before a lever press (maybe?)
%
% make a correction for the animal ID, in case it is larger than 9 (two or three
% digits.


filename = makeFileName(prefix,animalID,session);

% --- Indexes for each of the output variable columns
dtCol 		= 1;
itiCol		= 2;
primedCol 	= 3;
validCol	= 4;
phaseCol	= 5;
sessionCol	= 6;			% session variable column index

dPh			= 0.1;			% initiates the variable just in case it cannot be 
							% obtained from the data, as for example when no 
							% trials were primed (reinforced) in one session

if ~exist('filename','var')
    disp('Missing input variable: name of the file to be analyzed');
end
if ~exist('plotFlag','var')
    plotFlag = true;
end
if ~exist('saveMatFlag','var');
    saveMatFlag = false;
end

% --- removed ---
%if ~exist('isAutoshapeSession','var');  % this var is used for analyzing data
%    isAutoshapeSession = false;         % from autoshape sessions. The difference
%end                                     % lies in the letter A at the end of the filename

if exist(filename,'file');
    data = med2tec(filename); 		% reads data from medpc format to time-event code
elseif exist([filename 'A'],'file');
    data = med2tec([filename 'A']); 		% reads data from medpc format to time-event code
    disp('Found autoshape session');
else
    D = [];
    disp(['File ' filename ' not found']);
    return;
end

% --- Small correction for a bug in the med-pc file ---
if size(data,1)>2               % if the animal presses the lever at the same cycle of the Start command in the
    if data(1,1) > data(2,1)    % box, the first time can be registered wrong, so this sets it to zero as it 
        data(1,1) = 0;          % should be
    end
end

% --- look for indexes of temporal events ---
startIndex      = find(data(:,2)== 1);  
endIndex        = find(data(:,2)== 3);  
startIndex      = startIndex(1:length(endIndex));	% eliminates the last trial in case it was incomplete
primeIndex      = find(data(:,2)==18); 
lightOnIndex    = find(data(:,2)==11);
lightOffIndex   = find(data(:,2)==21);
phaseAdvIndex   = find(data(:,2)==17);        % indexes of trials where phase was advanced
phaseBckIndex   = find(data(:,2)==27);        % indexes of trials where phase was retreated


% --- searching for trials in which the animals received food. We call these "primed" ----
primedTrials	= findTrial(startIndex,primeIndex);

% --- searching for trials in which animals progressed or retreated phase
phaseAdvTrials	= findTrial(startIndex,phaseAdvIndex);
phaseBckTrials  = findTrial(startIndex,phaseBckIndex);

% --- searching for trials in which the animals responded with the light on 
% (not in timeout). We'll call these trials "valid". 
if ~isempty(startIndex)
    validTrials     = findValidTrial(startIndex,lightOnIndex,lightOffIndex);
else
    D = [];
    disp('No valid trials, returning D = []');
    return;
end
% --- search for valid trials in which animals were and were not reinforded ---
validPrimed 	= intersect(validTrials,primedTrials);	% looks for trials when the animals received food and 
validNonPrimed 	= setdiff(  validTrials,primedTrials);
invalid			= setdiff(1:length(startIndex), validTrials);

%--- gets the initial prime time ---
if length(primeIndex) >= 1
	iniPh 			= data(primeIndex(1),1) - data(primeIndex(1)-1,1);
else
	iniPh = 1.2;
end

% --- Organizing data in one single matriz: D --- 
D = zeros(length(startIndex),6);        	% Initiates the vector for speed

% --- Calculating the duration of the lever presses ---
D(:,dtCol)  				= data(endIndex,1) - data(startIndex,1);
D(1:end-1,itiCol) 			= data(startIndex(2:end),1) - data(endIndex(1:end-1),1);
D(end,itiCol) 				= NaN;
D(primedTrials,primedCol)   = 1;             % sets to 1 all the trials that were primed
D(validTrials ,validCol)	= 1;             % sets to 1 all the trials that were primed
D(phaseAdvTrials,phaseCol)	=  dPh;
D(phaseBckTrials,phaseCol) 	= -dPh;
D(:,phaseCol) 	= cumsum(D(:,phaseCol))+iniPh;
D(:,sessionCol)		= session;			% puts a mark (1) on the last trial showing that 
									% it was the end of session (eos)
									
% --- graphical part ---
if plotFlag
    hold on;
    plotDrrd(D,filename);
end
%__________________________________________________________________________

% Filtering the responses that were followed by ITI shorter than a
% criterion. The idea behind this is to eliminte responses in which the
% animal did not go look for the pellet, meaning that it was not engaged in
% the task.
%cutoff = 0;             % time in seconds for miminum ITI
%D=D(D(:,2)>cutoff,:);   % eliminates trials in which ITI<cutoff


N  = length(D(:,1));
vp = length(validPrimed);
vnp= length(validNonPrimed);
iv = length(invalid);

fprintf('Rat:%d Session:%d Trials:%d vreinf:%d(%.1f%%) vnreinf:%d(%.1f%%) Inv:%d(%.1f%%)\n',animalID,session,N,vp,vp/N*100,vnp,vnp/N*100,iv,iv/N*100);

% --- saving matlab file in case it was requested ---
if saveMatFlag
    save([filename '.mat'],'D');
end
%__________________________________________________________________________


function ret = findTrial(st, v)
% --- Looks for the trial in which the events occurred
% v is a list of indexes of temporal events. For example, if you know
% that an event ocurred in the index 102, this function will look in the
% indexes of the starts of the trial (st) and count the number of trials
% that had started before that particular event, let's say N, and hence 
% return that the event belongs to that trial N. If v is a vector, the
% function returns all the trials the events belong to

v = v(:);
ret = nan(size(v));
for k = 1:length(v)
    ret(k) = length(st(st<v(k)));
end
%__________________________________________________________________________


function ret = findValidTrial(st,u,v)
% --- Looks for trials that occurred between the events u and v. The most typical
% example is in the drrd trials: only the lever presses that ocurred while the
% light was on are valid. Hence, this function is used to find the trials that
% started after the light was turned on, and before the light was turned off.
% If there were multiple events, e.g. light turns on and off more than once, the 
% junction will look for events that are in between u(i) and v(i) where i is the
% ith time the light was turned on.

u = u(:); v = v(:);				% makes sure the inputs are column vectors
if length(u) ~= length(v)		% makes sure that the events have the same size
	if length(u) == length(v)+1;
		v(end+1) = st(end)+1; 	% just makes the last event one index after the last data set
	else
		disp('Incompatible number of events');
		exit(0);
	end
end

ret = [];               					% initializes the return variable as empty

for k = 1:length(u)							% loop for all the events
    Nu = length(st(st<u(k)));   			% select the starts that happened before the event u(k)     
    Nv = length(st(st<v(k)));        		% select the starts that happened before the event v(k),
    										% supposedly after u(k)    
    ret = vertcat(ret,(Nu+1:Nv)');  		%#ok<AGROW> % adds to the return variable the trials between u(k) and v(k) 
end
%__________________________________________________________________________

function filename = makeFileName(prefix, animalID, session)
% --- Function to put the parts of the file name together ---

animalID = num2str(animalID/1000,'%.4f'); 
animalID = animalID(3:end-1);                 % same with animalID to 3 digits
session  = num2str(session/1000,'%.3f'); 
session  = session(2:end);                  % converts the session to .+3 digits
filename=[prefix animalID session];         % put together the parts 
%_______________________________________________________________________________

