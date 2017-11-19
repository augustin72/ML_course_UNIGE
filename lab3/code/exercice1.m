%This file contains the script for to launch to test the function

clear;  %clean memomry
clc;    %clean screen


%this script will load the dataset and separate the 
run('readdigits.m');
%here we got two variable :
%   - x is a matrix containing the observations features (1593 * 256)
%   (number of obervation * number of feature)
%   - t is a matrix containing the observation targets (1593 * 10)
%   (number of observation * number of target values
%Comment : here the target is represented with a binarie matrix. The matrix
%contains one colomn per target value. The correct target value for each
%observation is indicated with the value 1, all the other target values are
%have the value -1:
%example : 
%[-1 1 -1 -1 -1 -1 -1 -1 -1 -1] : here, it's the second target value the
%correct target for this observation.

%Now we want to create a colomn target
tt=ones(1593,1);
for i=1:1593
    for j=1:10
        number = find(t(i,:)==1);
    end
    tt(i,1)=number;
end

clear('i', 'j', 'number');

fullDataSet = [x,tt];




