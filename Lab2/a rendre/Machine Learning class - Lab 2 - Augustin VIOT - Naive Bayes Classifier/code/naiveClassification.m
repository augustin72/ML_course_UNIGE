%Exercice2
function [targetTest,errorRate] = naiveClassification(trainingDataset, testDataset)
    %   1: check number of colomn
    [numberOfRowForTrainingSet, numberOfColForTrainingSet] = size(trainingDataset);
    
    [numberOfRowForTestSet, numberOfColForTestSet] = size(testDataset);
    
    if (numberOfColForTestSet +1 < numberOfColForTrainingSet) 
        targetTest = 0;
        errorRate = 'Number of colomn in testSet is lower than the (number colomn-1 )in training set';
        %disp('we just gave a value to return');
        return;
    end
    
    %   2: check that the training set doesn't contains values smaller or
    %   eaqual to 0.
    if( find(trainingDataset<1) > 0)
        targetTest = 0;
        errorRate = 'Training set contains one or many values < 1';
        %disp('we just gave a value to return');
        return;
    end
    
    %   check that the test Dataset set doesn't contains values smaller or
    %   eaqual to 0.
    if( find(testDataset<1) > 0)
        targetTest = 0;
        errorRate = 'Test dataset contains one or many values < 1';
        %disp('we just gave a value to return');
        return;
    end
    
    %   3: Train a Naive Bayes classifier on the training set 
    %   (first input argument), using its last column as the target
    
   
    [targetTest,errorRate]=BayesTraining(trainingDataset, testDataset);

    
end



%***** From here, these are just notes for personnal use
%***** Nothing relevant for evaluation/comprehension 

%the function takes two dataset : training set and test set
%the training dataset is n rows and D+1 colomns
%the test dataset has m rows and c colonms

%training set :
%   we don't care about the nmber of rows of the 
%   but we have to have d+1 colomns (d parameter + one target)

%test set
%   d colomns or d + 1 (d parameter + target if we use to check the error
%   rate)
%   

%the training set decide the data size set. The testset should have at
%least d - 1 colomns


%The function will : %
%   1 : check number of colomns
%   2 : check the content (no number <1)
% 

%we return a the class computed for each observation from the test set.
% if the test set contains also the target (d+1 colomns), then 



% to choose random value to make the two dataset, we can use the functin
% index=randomperm(size)

%ex : randomperm(40) => [2 35 12 .... ] (vector of number between 1 and 40
%index(1:10)   : values used for the training set
%index(11;14)  : values used for the test set

%beacause we want the function to return two values, the function should
%look like somth like that : [r1, errorRate] = function(....)

%we should be able to deal with bug situtaion:
% the first arg returns 0 lentght vector
% the second arg an error message
