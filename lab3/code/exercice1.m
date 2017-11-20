%This file contains the script for to launch to test the function

% clear;  %clean memomry
% clc;    %clean screen


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

% %2 :
% %Now we sample our dataset in two set : trainingset and testset :
% numelementsInTrainingSet = ceil(numberOfObservations*0.8);
% indices = randperm(length(fullDataSet)); %here we create a vector of all mixed numbers from 1 to (size of dataset1)
% trainingSetIndex = indices(1:numelementsInTrainingSet);
% testSetIndex = indices(numelementsInTrainingSet+1:end);
% 
% trainingSet=fullDataSet(trainingSetIndex,:);
% 
% %Use this line if YOU WANT the target in test set
% %testSet = fullDataSet(testSetIndex,:);
% 
% %Use this line if you DO NOT WANT the target in the test set
% testSet = fullDataSet(testSetIndex,1:numberOfFeatureAndTargetcol);
% 
% 
% % 3 :calls the KNN classifier and reads the results
% [targetTest,errorRate] = knnClassifier(trainingSet, testSet, 10);
% targetTest;
% errorRate;
% 
% %This is what we have to compute for the exercice :
% 
% % the quality indexes for binary classification: accuracy or error rate, selectivity/specificity,
% % precision/recall, F1 measure
% % on 10 tasks: each digit vs the remaining 9 (i.e., recognize whether the observation is a 1 or not; 
% % recognize whether it is a 2 or not; ...; recognize whether it is a 0 or not)
% % for several values of k, e.g., k=1,2,3,4,5,6,8,10,15,20,30,40,50 
% 
% 
% %To make all these computations we will build a confusion matrix, and
% %compute the indicators. 
% 
% %At first, we will make the confusion matrix for only one k value, k = 3,
% %and one binary test : with the second class of the fullDataSet
% 
% %At first, we create a matrix with a target containg binary values
% %indicating if the observation is from the second class or not
% binaryMatrixForSecondClass = [fullDataSet(:,1:numberOfFeatureAndTargetcol-1) ones(numberOfObservations,1)];
% for i=1:numberOfObservations
%     if fullDataSet(i,end)== 2
%         binaryMatrixForSecondClass(i,end)=1;
%     else
%         binaryMatrixForSecondClass(i,end)=-1;
%     end
% end
% 
% %Now we sample our dataset in two set : trainingset and testset :
% numelementsInTrainingSet = ceil(numberOfObservations*0.8);
% indices = randperm(length(binaryMatrixForSecondClass)); %here we create a vector of all mixed numbers from 1 to (size of dataset1)
% trainingSetIndex = indices(1:numelementsInTrainingSet);
% testSetIndex = indices(numelementsInTrainingSet+1:end);
% trainingSet=binaryMatrixForSecondClass(trainingSetIndex,:);
% testSet = binaryMatrixForSecondClass(testSetIndex,1:numberOfFeatureAndTargetcol);
% [targetTest,errorRate, confusionMatrix] = knnClassifierWithAnalyze(trainingSet, testSet, 3);
% targetTest;
% errorRate;
% confusionMatrix;
% [errorRate2, sensitivity, specificity, precision, recall, F1] = analyzeConfusionMatrix(confusionMatrix);
% 
% %IMPORTANT COMMENT : selectivity = specificity !!!!!!
% 
% %Now we will do the same, but with all the binary possible combination :
% 
% resultMatrix = zeros(10,6);
% %this resultMatrix will contain 
% %[errorRate2, sensitivity, specificity,precision, recall, F1] for each
% %class
% 
% for i=1:10
%     
%     %first, we build the bninary matrix as before
%     binaryMatrix = [fullDataSet(:,1:numberOfFeatureAndTargetcol-1) ones(numberOfObservations,1)];
%     for j=1:numberOfObservations
%         if fullDataSet(j,end)== i
%             binaryMatrix(j,end)=1;
%         else
%             binaryMatrix(j,end)=-1;
%         end
%     end
%     
%     numelementsInTrainingSet = ceil(numberOfObservations*0.8);
%     indices = randperm(length(binaryMatrix)); %here we create a vector of all mixed numbers from 1 to (size of dataset1)
%     trainingSetIndex = indices(1:numelementsInTrainingSet);
%     testSetIndex = indices(numelementsInTrainingSet+1:end);
%     trainingSet=binaryMatrix(trainingSetIndex,:);
%     testSet = binaryMatrix(testSetIndex,:);
%     [targetTest,errorRate, confusionMatrix] = knnClassifierWithAnalyze(trainingSet, testSet, 3);
%     [errorRate2, sensitivity, specificity, precision, recall, F1] = analyzeConfusionMatrix(confusionMatrix);
%     
%     resultMatrix(i,:)=[errorRate2, sensitivity, specificity, precision, recall, F1];
%         
% end
% 

%Now we will do the same again but for many k values :
%We will use the fallowing k values :  k=1,2,3,4,5,6,8,10,15,20,30,40,50
% PB : "k should not be divisible by the number of classes"
%So we will use the following values k=1,3,5,7,9,11,15,21,31,40,50


%=== SCRIPT ====
% 
% krange = [1 3 5 7 9 11 15 21 31 41 51];
% numberForAverage = 50;
% resultMatrixForManyk = zeros(10, 6,length(krange));
% 
% for m=1:length(krange)
%     fprintf(' k = %d\n',krange(m));
%     resultMatrix = zeros(10,6);
%     %this resultMatrix will contain 
%     %[errorRate2, sensitivity, specificity,precision, recall, F1] for each
%     %class
% 
%     for i=1:10
%     fprintf(' class = %d\n',i);
%         %first, we build the bninary matrix as before
%         binaryMatrix = [fullDataSet(:,1:numberOfFeatureAndTargetcol-1) ones(numberOfObservations,1)];
%         for j=1:numberOfObservations
%             if fullDataSet(j,end)== i
%                 binaryMatrix(j,end)=1;
%             else
%                 binaryMatrix(j,end)=-1;
%             end
%         end
% 
%         numelementsInTrainingSet = ceil(numberOfObservations*0.8);
%         tempMatrixForAverage = ones(numberForAverage,6);
%         for counterForAverrage=1:numberForAverage
%             
%             indices = randperm(length(binaryMatrix)); %here we create a vector of all mixed numbers from 1 to (size of dataset1)
%             trainingSetIndex = indices(1:numelementsInTrainingSet);
%             testSetIndex = indices(numelementsInTrainingSet+1:end);
%             trainingSet=binaryMatrix(trainingSetIndex,:);
%             testSet = binaryMatrix(testSetIndex,:);
%             [targetTest,errorRate, confusionMatrix] = knnClassifierWithAnalyze(trainingSet, testSet, krange(m));
%             [errorRate2, sensitivity, specificity, precision, recall, F1] = analyzeConfusionMatrix(confusionMatrix);
%             tempMatrixForAverage(counterForAverrage,:)= [errorRate2, sensitivity, specificity, precision, recall, F1];
%         end
%         
%         resultMatrix(i,:)=mean(tempMatrixForAverage);
% 
%     end
%     
%     resultMatrixForManyk(:,:,m)=resultMatrix;
%     
%     
% end


%Finaly we will build 6 graph representing the evolution of one parameter
%(errorRate2, sensitivity, specificity, precision, recall, F1) VS the k
%value for each class


%Here is some code to save the results so we don't have to compute
%everything again :
%save('saveresultMatrixForManyk.mat','resultMatrixForManyk');

%Here the code to use these values :
example = matfile('saveresultMatrixForManyk.mat');
matrixFromSave = example.resultMatrixForManyk;
resultMatrixForManyk = matrixFromSave;

%Just to remember : resultMatrixForManyk = zeros(number of classes, parameter , k);
%==========
%Here we display the error rates for all the class (this is the first
%value)
figure(2);
hold on;
for i=1:10
    errorRateForClassi = squeeze(resultMatrixForManyk(i,1,:));
    formatSpec = "class = %d";
    str = compose(formatSpec,i);
    if i==10
        str="class = 0";
    end
    if i<5
        typeOfLine = '-x';
    else
        typeOfLine = '--x';
    end
    plot(krange,errorRateForClassi,typeOfLine, 'DisplayName', str);
end
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,1,:)));
plot(krange,errorRateForAllClass,'-o', 'DisplayName', "averrage");
xlabel('k value');
ylabel('error rate');
legend('show');
title(compose('error Rate for all class (and average)')); % add figure title
hold off;

%This graph shows the average error rate of all classes
figure(3);
hold on;
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,1,:)));
plot(krange,errorRateForAllClass,'-o');
title(compose('error Rate average (all classes included)')); % add figure title
hold off;

%==================
%Same but for SENSITIVITY (this is the second value)
figure(4);
hold on;
for i=1:10
    errorRateForClassi = squeeze(resultMatrixForManyk(i,2,:));
    formatSpec = "class = %d";
    str = compose(formatSpec,i);
    if i==10
        str="class = 0";
    end
    if i<5
        typeOfLine = '-x';
    else
        typeOfLine = '--x';
    end
    plot(krange,errorRateForClassi,typeOfLine, 'DisplayName', str);
end
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,2,:)));
plot(krange,errorRateForAllClass,'-o', 'DisplayName', "averrage");
xlabel('k value');
ylabel('sensitivity');
legend('show');
title(compose('Sensitivity for all the classes')); % add figure title
hold off;

%This graph shows the average error rate of all classes
figure(5);
hold on;
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,2,:)));
plot(krange,errorRateForAllClass,'-o');
title(compose('average sensitivity for all classes')); % add figure title
hold off;


%==============
%Same but for SPECIFICITY (this is the third value)
figure(6);
hold on;
for i=1:10
    errorRateForClassi = squeeze(resultMatrixForManyk(i,3,:));
    formatSpec = "class = %d";
    str = compose(formatSpec,i);
    if i==10
        str="class = 0";
    end
    if i<5
        typeOfLine = '-x';
    else
        typeOfLine = '--x';
    end
    plot(krange,errorRateForClassi,typeOfLine, 'DisplayName', str);
end
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,3,:)));
plot(krange,errorRateForAllClass,'-o', 'DisplayName', "averrage");
xlabel('k value');
ylabel('specificity');
legend('show');
title(compose('Specificity for all classes')); % add figure title
hold off;

%This graph shows the average error rate of all classes
figure(7);
hold on;
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,3,:)));
plot(krange,errorRateForAllClass,'-o');
xlabel('k value');
ylabel('specificity');
title(compose('average specificity for all classes')); % add figure title
hold off;

%=== Same for PRECISION == (this is the fourth value)
figure(8);
hold on;
for i=1:10
    errorRateForClassi = squeeze(resultMatrixForManyk(i,4,:));
    formatSpec = "class = %d";
    str = compose(formatSpec,i);
    if i==10
        str="class = 0";
    end
    if i<5
        typeOfLine = '-x';
    else
        typeOfLine = '--x';
    end
    plot(krange,errorRateForClassi,typeOfLine, 'DisplayName', str);
end
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,4,:)));
plot(krange,errorRateForAllClass,'-o', 'DisplayName', "averrage");
xlabel('k value');
ylabel('precision');
legend('show');
title(compose('Precision for all classes')); % add figure title
hold off;

%This graph shows the average error rate of all classes
figure(9);
hold on;
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,4,:)));
plot(krange,errorRateForAllClass,'-o');
xlabel('k value');
ylabel('precision');
title(compose('average precision for all classes')); % add figure title
hold off;



%==== RECALL (this is the fith value)
figure(10);
hold on;
for i=1:10
    errorRateForClassi = squeeze(resultMatrixForManyk(i,5,:));
    formatSpec = "class = %d";
    str = compose(formatSpec,i);
    if i==10
        str="class = 0";
    end
    if i<5
        typeOfLine = '-x';
    else
        typeOfLine = '--x';
    end
    plot(krange,errorRateForClassi,typeOfLine, 'DisplayName', str);
end
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,5,:)));
plot(krange,errorRateForAllClass,'-o', 'DisplayName', "averrage");
xlabel('k value');
ylabel('recall');
legend('show');
title(compose('Recall for all classes')); % add figure title
hold off;

%This graph shows the average error rate of all classes
figure(11);
hold on;
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,5,:)));
plot(krange,errorRateForAllClass,'-o');
xlabel('k value');
ylabel('recall');
title(compose('average recall for all classes')); % add figure title
hold off;


%====F1 (this is the value number six)
figure(12);
hold on;
for i=1:10
    errorRateForClassi = squeeze(resultMatrixForManyk(i,6,:));
    formatSpec = "class = %d";
    str = compose(formatSpec,i);
    if i==10
        str="class = 0";
    end
    if i<5
        typeOfLine = '-x';
    else
        typeOfLine = '--x';
    end
    plot(krange,errorRateForClassi,typeOfLine, 'DisplayName', str);
end
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,6,:)));
plot(krange,errorRateForAllClass,'-o', 'DisplayName', "averrage");
xlabel('k value');
ylabel('F1');
legend('show');
title(compose('F1 for all classes')); % add figure title
hold off;

%This graph shows the average error rate of all classes
figure(13);
hold on;
errorRateForAllClass = squeeze(mean(resultMatrixForManyk(:,6,:)));
plot(krange,errorRateForAllClass,'-o');
xlabel('k value');
ylabel('F1');
title(compose('F1 average for all classes')); % add figure title
hold off;

%==== Finaly we have all the graphs




