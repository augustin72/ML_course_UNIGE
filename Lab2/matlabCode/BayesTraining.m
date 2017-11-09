function [targetTest,errorRate] = BayesTraining(trainingDataset, testDataset)
    %This function takes two argument : 
    %   - trainingDataSet ( (d+1) * numerOfTrainingObservation matrix )with
    %   d the dimension of our feature (number of feature)
    %   - testDataset : a matrix of size (d+1)*numerOfTrainingObservation
    %   OR (d)*numerOfTrainingObservation. The size depends on if the test
    %   set includes the target colomn or not.
    %
    %In normal use it returns two arguments :
    %   -targetTest : a vector containing the class of the test
    %   observation determined by the Bayes classifier
    %   -errorRate : this is only returned when the testSet has the colomn
    %   of target. It is the error rate of the Bayes classification
    %
    %It can also returns errors. When it returns an error, the value of
    %targetTest = 0, and errorRate contains a message. Errors are returned
    %in this cases :
    % -Training set and test set have different target values
    % -Test set have different feature value(s)
    %
    %Structure of the code :
    %The function contains 4 parts :
    % -CHECK THE DATASET : it check if the test set as different
    % feature/target values from the trainingSet
    % -TRAINING OF THE CLASSIFIER : it build a cell array likehoodMatrix
    % and a vector targetValues. Those contain the information needed to
    % make the Bayes classification
    % -CLASSIFICATION OF THE TEST SET
    % -ERROR RATE : it compute the error rate if the testSet contains the
    % target colomn
    
    
    
    
    
    %Here we store the dimension of our training set and test set
    [rowTraining, columnTraining]=size(trainingDataset);
    [rowTest, columnTest]=size(testDataset);
    
    %we create a vector containing the target values
    trainingTarget = trainingDataset(:,end);
    
    numberOfFeatures = columnTraining - 1;

    %====CHECK THE DATASET===== BEGIN
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
    
    %Now we now that the trainingset and the testset have the same number
    %of features. We will now check if the test set feaures contains values
    %that the trainingset doesn't have. To do so, we will make an array of list of
    %all feature values for each features of the training set. Then we will
    %check if the features values of the testset are in these lists :
    for i=1:numberOfFeatures
        listOfFeatureValue = unique(trainingDataset(:,i));
        
        for j=1:rowTest
            if ( (length (find(listOfFeatureValue==testDataset(j,i) )) )<1)
                targetTest = 0;
                errorRate = 'Test set have different feature value(s)';
                return;
            end
        end
    end
                
    
    %===CHECK THE DATASET=== END
    
    
    %*********TRAINING OF THE CLASSIFIER********* BEGIN
    
    %to calculate the number of different value for a feature we can use : 
    % length(unique(A)). It give the number of unique values in A
    % trainingDataset(:,end) gives the last colomns of the training set
    
    numberOfTargetValuesInTraining = length(unique(trainingDataset(:,end)));
    
    
    %Here is the frequency matrix, it contains what we need :
    frequencyMatrix = cell(numberOfFeatures,numberOfTargetValuesInTraining);
    
    %probs = cell(numfeatures,numclasses);
    %probs{feature,class}(level) = % probability that "feature" == "level" in class "class"
    
    for i=1:numberOfFeatures
        for j=1:numberOfTargetValuesInTraining
            %for each cell of our table, we will create an array containing
            %the right number of instance of the event
            
            %We create a temporary matrix with two colomns from the trainingdataset :
            %   -the current feature studied
            %   -the target
            %Also, we only keep the lines where the target is the current
            %one (defined by j)
            tempMatrix = horzcat(trainingDataset(:,i) , trainingDataset(:,end));
            
            getOnlyCurrentTarget = tempMatrix(:,end)~=j;
            tempMatrix(getOnlyCurrentTarget,:) = [] ;
            
            %Now we need to know how many possible feature values does this
            %feature contains
            %comments : we need also the values that don't exist with this
            %specific target !!!
            vectorOfFeatureValues = unique(trainingDataset(:,i));
            
            for k=vectorOfFeatureValues(1):length(vectorOfFeatureValues)
                
                frequencyMatrix{i,j}(k) = 0;
                %Now we sum the number of current feature values found for
                %the current target. To do so, we count the number of
                %instance in the tempMatrix. If there are none, we keep
                %zero.
                frequencyMatrix{i,j}(k) = sum(tempMatrix(:,1) == k);
            end
        end
    end
    
    %Now we have the frequency matrix, it is really cool !
    
    %Actually, to make a predictor, we only need two values :
    %   -The probability of each target
    %   -The probability of each feature value given the target
    %   "P(Xi=xi|w)"
        
    %we can get this probability is estimated with the likehood. Let's
    %build the likehood matrix :
    
    likehoodMatrix = cell(numberOfFeatures,numberOfTargetValuesInTraining);
    
    %Actually, we will need a smoothing. It may happen (and in our case it
    %happens), that some specific case have no instance at all. The
    %computation without smoothing would give a 0 probability, which cannot
    %be used for our Bayes classifier.
    
    %We will use Laplace's smoothing rule (or Laplace's "rule of
    %succession") :
    % "If an event occurs r times in n experiments, then its probability is
    % (r+1)/(n+2) rather than r/n."
    
    for i=1:numberOfFeatures
        for j=1:numberOfTargetValuesInTraining
            
            %as before :
            tempMatrix = horzcat(trainingDataset(:,i) , trainingDataset(:,end));
            getOnlyCurrentTarget = tempMatrix(:,end)~=j;
            tempMatrix(getOnlyCurrentTarget,:) = [] ;
            vectorOfFeatureValues = unique(trainingDataset(:,i));
            
            %This time, we also need to get the total number of occurence
            %for this target value
            %(exemple : number of target = YES)
            %because the calculation is 
            %  proba = (numberOfInstanceOfThisFeatureValueForThisTarget +
            %  1)/ (OccurenceForThisTargetValue + 2)
            %The number of occurence for this target value is given by the
            %tempMatrix number of rows
            [rowTempMatrix, columnTempMatrix]=size(tempMatrix);
            
            for k=vectorOfFeatureValues(1):length(vectorOfFeatureValues)
                
                likehoodMatrix{i,j}(k) = 0;
                
                likehoodMatrix{i,j}(k) = (frequencyMatrix{i,j}(k) + 1)/ ( rowTempMatrix+2);
            end
        end
    end
    
    
    
    %Now, we will make a vector containing all the probabilities for each
    %target values P(w)
    % taget proba is a vector which has the size equals to the number of
    % possible target values. So far it only contains 1, but we will fill
    % it.
    targetProba=ones(length(unique(trainingDataset(:,end))),1);
    
    for i=1:length(targetProba)
        %Also, we only keep the lines where the target is the current
        %one (defined by j)
        tempMatrix = trainingDataset;
        %selection of all rows where target != i
        getOnlyCurrentTarget = tempMatrix(:,end)~=i;
        tempMatrix(getOnlyCurrentTarget,:) = [] ;
        %Now temp matrix contains only the lines where target=i
        [rowTempMatrix, colomnTempMatrix]=size(tempMatrix);

        targetProba(i)= rowTempMatrix/rowTraining;
    end
    
    %Now, our training is ready, we can proceed to the classification using
    %Bayes classification !
    
    %*********TRAINING OF THE CLASSIFIER********* END
    
    
    %****** CLASSIFICATION OF THE TEST SET ******* BEGIN
    
    %***Example with one point to classify
    %At first, we will show how to classify one point, then we will do the
    %classification for the whole test set
    
    PointToClassify = [1,3,2,2];
    %this correspond to a situation with the following parameters :
    % outlook = Overcast
    % Temperature = hot
    % Hum = high
    % Windy = FALSE
    % no target value
    
    %Comment : for the classification, we do not need a target value, for
    %this reason, we will not put a target value in this example. The error
    %rate calculation will be explained later
    
    %Recall : the bayes classifier determine the class of the point X=f1,f2,f3,f4
    %by using this formula : 
    % class=argmax(P(w)*(P(outlook=f1|w)*P(temp=f2|w)*P(hum=f3|w)*P(windy=f4|w))
    %So we will build a matrix containing the computed value for each w,
    %and apply the matlab function [M,I]=max() to get the argmax
    
    vectorToPutInTheARGMAX=targetProba;
    %this gives the vector the size of all possible target values
    
    for i=1:length(vectorToPutInTheARGMAX)
        %now we calculate the factor of conditional probabilities :
        factorOfConditionnalProba = 1;
        
        for j=1:numberOfFeatures
            %this get the value of our likehoodMatrix at feature j, target
            %i, with a feature value equal to the feature value of the
            %point.
            conditionnalProba = likehoodMatrix{j,i}(PointToClassify(j));
            factorOfConditionnalProba = factorOfConditionnalProba * conditionnalProba;
        end
        
        vectorToPutInTheARGMAX(i) = factorOfConditionnalProba * targetProba(i);
    end
    
%     disp('vectorToPutInTheARGMAX');
%     disp(vectorToPutInTheARGMAX);
    
    %Now we just need to get the argmax of this vector :
    
    [maxValue, class] = max(vectorToPutInTheARGMAX);
    
%     disp('class found by bayes classifier');
%     disp(class);
    
    
    %***Classification of the whole testDataSet
    %Now we will classify the whole testDataSet correclty :
    
    % we will follow the same process, but the class will be stored in a
    % vector of th size of the test set.
    classOfTestSet = ones(rowTest,1);
    
    %We can put this line out of the loops, since it is only usefull to get
    %the appropriate size
    vectorToPutInTheARGMAX=targetProba;
    %this gives the vector the size of all possible target values
    
    for k=1:rowTest
        %here we will apply the same algorithms for each point of the
        %dataset. A point is one line of the dataset, and all the
        %featureColomn

        PointToClassify=testDataset(k,1:numberOfFeatures);
        
        for i=1:length(vectorToPutInTheARGMAX)
            %now we calculate the factor of conditional probabilities :
            factorOfConditionnalProba = 1;

            for j=1:numberOfFeatures
                %this get the value of our likehoodMatrix at feature j, target
                %i, with a feature value equal to the feature value of the
                %point.
                conditionnalProba = likehoodMatrix{j,i}(PointToClassify(j));
                factorOfConditionnalProba = factorOfConditionnalProba * conditionnalProba;
            end

            vectorToPutInTheARGMAX(i) = factorOfConditionnalProba * targetProba(i);
        end
        [maxValue, class] = max(vectorToPutInTheARGMAX);
        
        %now we store the value of this specific point into the vector
        %containing the class found for each points of the testset
        classOfTestSet(k)=class;
        
    end
    
%     disp('classOfTestSet');
%     disp(classOfTestSet);
    
    targetTest = classOfTestSet;
    
    %Congratulation, we just made a Naive Bayes classification !
    
    %****** CLASSIFICATION OF THE TEST SET ******* END
    
    
    %******* ERROR RATE ******* BEGIN
    
    %This part is only applyed if the test set contains a target colomn
    
    
    if testSetContainsTarget==1
        %we will look at all the points from the test set, and compare the
        %value found by the bayes classifier, with the real target value.
        numberOfCorrectlyClassifiedPoints=0;
        
        %This loop go throw the test set and compare the etimated target
        %with the real one. We increase the
        %numberOfCorrectlyClassifiedPoints if the target found was correct
        for i=1:rowTest
            if (testDataset(i,end)==classOfTestSet(i))
                numberOfCorrectlyClassifiedPoints = numberOfCorrectlyClassifiedPoints +1;
            end
        end
        %now we just compute the percentage
        percentageOfCorrectlyClassifiedPoints = numberOfCorrectlyClassifiedPoints / rowTest;
        errorRate = 1 - percentageOfCorrectlyClassifiedPoints;
    else
        
        %If we do not have the target for the test set, then we set the
        %error rate to 2.
        errorRate = 2;
    end
    
    %******* ERROR RATE ******* BEGIN
        
   
            
end