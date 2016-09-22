function D = gatherDrrd(prefix,animalID,sessions,plotFlag,elimFirst)
%function D = gatherDrrd(prefix,animalID,sessions,plotFlag)
% example: D = gatherDrrd('AB0',10,1:9,1) 
% runs the sessions 1 through 9 for animal 10 and plots the results.

if ~exist('plotFlag','var')
    plotFlag = true;
end

if ~exist('elimFirst','var')
    elimFirst = 0;
end


D = [];

for k = sessions
    newD = drrd(prefix,animalID,k,false);
    newD = newD(1+elimFirst:end,:);
    D = [D ; newD];
end; 

if plotFlag
    if length(sessions) == 1
        plotDrrd(D,['Animal: ' num2str(animalID) '- sess.: ' num2str(sessions)]);
    else
        plotDrrd(D,['Animal: ' num2str(animalID) '- sess.: ' num2str(sessions)]);
    end
end