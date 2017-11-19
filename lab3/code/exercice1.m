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

%Now we want to create a colomn target with the target values indicated
%with integer
tt=ones(1593,1);
for i=1:1593
    for j=1:10
        number = find(t(i,:)==1);
    end
    tt(i,1)=number;
end
clear('i', 'j', 'number');
%Now we do have the matrix tt (number of observation * 1) that contains all
%the target values indicated with an int

%we create a new matrix by concatening the features values and the target
fullDataSet = [x,tt];
[numberOfObservations, numberOfFeatureAndTargetcol] = size(fullDataSet);

%2 :
%Now we sample our dataset in two set : trainingset and testset :
numelementsInTrainingSet = ceil(numberOfObservations*0.8);
indices = randperm(length(fullDataSet)); %here we create a vector of all mixed numbers from 1 to (size of dataset1)
trainingSetIndex = indices(1:numelementsInTrainingSet);
testSetIndex = indices(numelementsInTrainingSet+1:end);

trainingSet=fullDataSet(trainingSetIndex,:);

%Use this line if YOU WANT the target in test set
%testSet = fullDataSet(testSetIndex,:);

%Use this line if you DO NOT WANT the target in the test set
testSet = fullDataSet(testSetIndex,1:numberOfFeatureAndTargetcol);


% 3 :calls the KNN classifier and reads the results
[targetTest,errorRate] = knnClassifier(trainingSet, testSet, 4);
targetTest;
errorRate;

%This is what we have to compute for the exercice :

% the quality indexes for binary classification: accuracy or error rate, selectivity/specificity,
% precision/recall, F1 measure
% on 10 tasks: each digit vs the remaining 9 (i.e., recognize whether the observation is a 1 or not; 
% recognize whether it is a 2 or not; ...; recognize whether it is a 0 or not)
% for several values of k, e.g., k=1,2,3,4,5,6,8,10,15,20,30,40,50 





