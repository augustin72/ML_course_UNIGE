%this file contains the knn classifier function


function [targetTest,errorRate,confusionMatrix] = knnClassifierWithAnalyze(trainingDataset, testDataset, k)
    %here we have the descritpion of the function


    %First we neex to do the basic checks
    %====== PARAMETERS CHECKS =======
    %   1: check number of colomn
    [numberOfRowForTrainingSet, numberOfColForTrainingSet] = size(trainingDataset);
    
    [numberOfRowForTestSet, numberOfColForTestSet] = size(testDataset);
    
    numberOfFeatures = numberOfColForTrainingSet -1;
    
    if (numberOfColForTestSet +1 < numberOfColForTrainingSet) 
        targetTest = 0;
        errorRate = 'Number of colomn in testSet is lower than the (number colomn-1 )in training set';
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
    if(numberOfColForTrainingSet == numberOfColForTestSet)
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
            testDataSetWithoutTarget = testDataset(:,1:numberOfFeatures);
        end

    else if (numberOfColForTrainingSet == (numberOfColForTestSet + 1))
        testSetContainsTarget = 0;
        testDataSetWithoutTarget = testDataset;
        end
    end
    %This check will be used later to see if we need to compute the error
    %rate or not
        
    %here we do an extra check, we verify if k is divisible by the number
    %of classes in the trainingSet. If it is, then we could have a cas
    %where two target can be given to a point from the test set, so we want
    %to avoid this situation :
    allTrainingSetTarget = unique(trainingDataset(:,end));
    if ( mod(k,length(allTrainingSetTarget)) == 0)
        targetTest = 0;
        errorRate = 'k is divisible by the number of possible target in training set !';
        return;
    end
    
    allTrainingSetTarget = unique(trainingDataset(:,end));
    testIF = ismember([-1 1], allTrainingSetTarget);
    testONLYIF = ismember(allTrainingSetTarget,[-1 1]);

    %====== END PARAMETERS CHECKS =======

    %====== START CLASSIFICATION ========
    computedTarget = ones(numberOfRowForTestSet, 1);

    for i=1:numberOfRowForTestSet
        currentPointToClassify = testDataSetWithoutTarget(i,:);
        %Compute the distances :
        distanceMatrix = pdist2(currentPointToClassify,trainingDataset(:,1:numberOfFeatures));
        %Now we create a new matrix containing the distance to each
        %observation of the training set, and the target of this
        %observation
        distanceAndAssociatedTarget = [transpose(distanceMatrix) trainingDataset(:,end)];

        %Now we sort this matrix, so the smallest distance will be the
        %first ones
        distanceAndAssociatedTarget = sortrows(distanceAndAssociatedTarget);
        
        %Now we just need to take the k first lines of this matrix, and
        %find wich target is the most represented
        kClosestObservationsTarget = distanceAndAssociatedTarget(1:k,end);
        targetForCurrentPoint = mode(kClosestObservationsTarget);
        computedTarget(i,1)=targetForCurrentPoint;
    end

    targetTest = computedTarget(:,1);
    
    %====== END CLASSIFICATION ========

    %====== ERROR RATE ======== BEGIN
    
    %This part is only applyed if the test set contains a target colomn
    if testSetContainsTarget==1
        %we will look at all the points from the test set, and compare the
        %value found by the bayes classifier, with the real target value.
        numberOfCorrectlyClassifiedPoints=0;
        
        %This loop go throw the test set and compare the etimated target
        %with the real one. We increase the
        %numberOfCorrectlyClassifiedPoints if the target found was correct
        for i=1:numberOfRowForTestSet
            if (testDataset(i,end)==targetTest(i,1))
                numberOfCorrectlyClassifiedPoints = numberOfCorrectlyClassifiedPoints +1;
            end
        end
        %now we just compute the percentage
        percentageOfCorrectlyClassifiedPoints = numberOfCorrectlyClassifiedPoints / numberOfRowForTestSet;
        errorRate = 1 - percentageOfCorrectlyClassifiedPoints;
    else
        
        %If we do not have the target for the test set, then we set the
        %error rate to 2.
        errorRate = 2;
    end
    
    %====== ERROR RATE ====== END
    
    %====== CONFUSION MATRIX ======= BEGIN
    confusionMatrix = zeros(2,2);
    
    realClass = testDataset(:,end);
    classounfByClassifier = targetTest(:,1);
    
    for i=1:numberOfRowForTestSet
       if ((classounfByClassifier(i,1) == -1)&&(realClass(i,1)== -1))   %True Negative
           confusionMatrix(1,1)=confusionMatrix(1,1)+1;
       end
       if ((classounfByClassifier(i,1) == -1)&&(realClass(i,1)== 1))    %Flase negative
           confusionMatrix(1,2)=confusionMatrix(1,2)+1;
       end
       if ((classounfByClassifier(i,1) == 1)&&(realClass(i,1)== -1))    %False Positive
           confusionMatrix(2,1)=confusionMatrix(2,1)+1;
       end
       if ((classounfByClassifier(i,1) == 1)&&(realClass(i,1)== 1))     %True positive
           confusionMatrix(2,2)=confusionMatrix(2,2)+1;
       end
    end
    
%                     Real value
%             |    -1     |   1
%     ================================
%             |    TN     |   FN
%          -1 |           |
% predicted===========================
%             |    FP     |   TP
%          1  |           |

end