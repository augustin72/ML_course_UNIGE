%the first task is to ceonvert int number
%the most natural way is to use natural number
%because it's good to have numbers that can be used as matrix index

%Here are the explanation of how we converted it :
% 
% outlook :
% Overcast    => 1
% Rainy       => 2
% Sunny       => 3
% 
% Temp :
% cool        => 1
% mild        => 2
% hot         => 3
% 
% Hum:
% normal      => 1
% high        => 2
% 
% Windy:
% TRUE        => 1
% FLASE       => 2
% 
% Play:
% yes         => 1
% no          => 2

%function sshould not print ! function should return values !
%function can return errors, but it's better if they don't print anything

%description of the dataset :
%play is the target (class)


clear;  %clean memomry
clc;    %clean screen


%load a file :
dataset1 = load('dataset1Modifyed.txt');

%now we create one vcotr for each colonm
% Outlook=dataset1(:,1); 
% Temperature=dataset1(:,2);
% Humidity=dataset1(:,3);
% Windy=dataset1(:,4);
% Target=dataset1(:,5);


trainingSet=dataset1(1:10,:);
trainingSet=dataset1;
% trainingSet(1,1)=0;
testSet = dataset1(11:14,:); % recall :  ":" means we take all the colomns !
testSet = dataset1;


[targetTest,errorRate] = naiveClassification(trainingSet, testSet);
targetTest;
errorRate;


%********* HERE START THE SCRIPT ************

%instruction :
% Write a script that, without the user's intervention:
% 
% 1 : loads the weather data set (already converted in numeric form)
% 2 : splits it into a training set with 10 randomly chosen patterns 
% and a test set with the remaining 4 patterns
% 3 : calls the naive Bayes classifier and reads the results
% 4 : prints the results: classification for each pattern of the test set, 
% corresponding target if present, error rate if computed.

%1 :
dataset1 = load('dataset1Modifyed.txt');

%2 :
%Now we sample our dataset in two set : trainingset and testset :
numelements = 10;
indices = randperm(length(dataset1)); %here we create a vector of all mixed numbers from 1 to (size of dataset1)


trainingSetIndex = indices(1:numelements);
testSetIndex = indices(numelements+1:end);

trainingSet=dataset1(trainingSetIndex,:);

%Use this line if you want the target in test set
testSet = dataset1(testSetIndex,:);

%Use this line if you do not want the target in the test set
%testSet = dataset1(testSetIndex,1:4);


% 3 :calls the naive Bayes classifier and reads the results
[targetTest,errorRate] = naiveClassification(trainingSet, testSet);
targetTest;
errorRate;

% 4 : prints the results: classification for each pattern of the test set, 
% corresponding target if present, error rate if computed.
if (targetTest==0)
    disp('targetTest =');
    disp(targetTest);
    disp('errorRate =');
    disp(errorRate);
else if (errorRate==2)
    %In this case, we do not have the target in the test set, so we just
    %print the classification
    disp('classification for each pattern of the test set :');
    disp(targetTest);
    else
        %Here, the test set contains the target, so we will create a matrix
        %containg the target found by the classifier and the real target
        
        comparaison = [targetTest,testSet(:,end)];
        disp('target found by classifier ; real target');
        disp(comparaison);
        
        disp('errorRate');
        disp(errorRate);
    end
end

    
%******** END OF SCRIPT FOR EXERCICE **********




%******** EXTRA CODE FOR ANALYSE OF THE CLASSIFIER ******

%what we want to do print the average 
%what we want a matrix of 14 colomns, 100 lines.
%Each columns will correspond to the size of the training set, the lines
%will contain the error rate. The objectif is to see the influence of the
%test/training sets size on the error rate.
% 
% numberOfLines = 1000;
% matrixOfErrorrate=zeros(numberOfLines,14);
% 
% minSizeOfTrainingSet = 3; %we can not use a training set smaller than 3 values !!!
% maxSizeOfTrainingSet = 14; 
% for i=minSizeOfTrainingSet:maxSizeOfTrainingSet
%     numelements = i;
%     j=1;
%     while j <= numberOfLines
%         indices = randperm(length(dataset1));
%         trainingSetIndex = indices(1:numelements);
%         testSetIndex = indices(numelements+1:end);
%         trainingSet=dataset1(trainingSetIndex,:);
%         testSet = dataset1(testSetIndex,:);
%         [targetTest,errorRate] = naiveClassification(trainingSet, testSet);
%         if (targetTest==0)
%             o=0;
%             %this was a useless line
%         else if (errorRate~=2)
%                 %Here, the test set contains the target, so we will create a matrix
%                 %containg the target found by the classifier and the real target
%                 matrixOfErrorrate(j,i)=errorRate;
%                 j = j+1;
%             else
%                 %In this case, we do not have the target in the test set, so we just
%                 %print the classification
%                 
%             end
%         end
%         
%     end
% end
% 
% figure(1);
% plot(mean(matrixOfErrorrate));
% title('Plot of error rate average') % add figure title
% hold off;

%******** END OF EXTRA CODE FOR ANALYSE *********





%***** From here, these are just notes for personnal use
%***** Nothing relevant for evaluation/comprehension 

%Usefull code to sample :

%    % create vector    
%    a = randn(100,1);
%    % determine how many elements is ten percent
%    numelements = round(0.1*length(a));
%    % get the randomly-selected indices
%    indices = randperm(length(a));
%    indices = indices(1:numelements);
%    % choose the subset of a you want
%    b = a(indices);




