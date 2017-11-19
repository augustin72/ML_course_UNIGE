%this file contains the knn classifier function


function [targetTest,errorRate] = knnClassifier(trainingDataset, testDataset, k)
%here we have the descritpion of the function


%Here the code

%First we neex to do the basic checks
%====== PARAMETERS CHECKS =======
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
   
    %Check that k>0 and k<=cardinality of the training set (number of rows) :
    if ( (k <= 0 )|| ( k > numberOfRowForTrainingSet) )
        targetTest = 0;
        errorRate = 'k value is inadequate (k <= 0 OR k > numberOfRowForTrainingSet)';
        return;
    end
      
    %First we check if the test set contains the target colomn are not :
    if(columnTraining == columnTest)
        testSetContainsTarget = 1;
        %disp('test set contains a target value');
        %Here we will do a little test to be sure that the training set target and
        %the test set target have the same possible values :
        allTestSetTarget = unique(testDataset(:,end));
        allTrainingSetTarget = unique(trainingDataset(:,end));
        
        testIsMember = ismember(allTestSetTarget, allTrainingSetTarget);
        if( find(testIsMember==0) > 0)
            targetTest = 0;
            errorRate = 'Training set and test set have different target values';
            return;
        else
            testAndTrainingHaveSameTargetValues = 1;
        end

    else if (columnTraining == (columnTest + 1))
        testSetContainsTarget = 0;
        end
    end
    %This check will be used later to see if we need to compute the error
    %rate or not
        
%====== END PARAMETERS CHECKS =======

%====== START CLASSIFICATION ========
    computedTarget = ones(numberOfRowForTestSet, 1);


    for i=1:numberOfRowForTestSet

        currentPointToClassify = testDataset(i,:);

    end

%====== END CLASSIFICATION ========

    
    
end


    


%Then we will use the D = pdist2(X,Y) to calculate the euclidian distance




