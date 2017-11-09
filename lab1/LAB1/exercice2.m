clear;  %clean memomry
clc;    %clean screen
clf;    %clean console


%load a file :
dataset1 = load('dataset1.txt');
dataset2 = load('dataset2.txt');

%we create a vector that contains the class informattion for each dataset
t1=dataset1(:,3);
t2=dataset1(:,3);
% 
% %we plot the first dataset
% figure(1);
% %firstly, we plot the pont where the information class is equal to 1,
% %these points are going to be the ones represented with a blue cross
% plot(dataset1(t1==1,1),dataset1(t1==1,2),'xb');
% hold on;
% %then we add the other point (information class == -1),
% %these points will be the red circles
% plot(dataset1(t1==-1, 1), dataset1(t1==-1,2),'or');
% title('Plot of dataset1') % add figure title
% hold off;
% 
% % comments : to select the point fro mthe data set where the information
% % class is equal to 1, we could have done this way :
% %class1=dataset1( dataset1(:,3)==1 , :)
% %because dataset1(:,3)==1 returns a logical vector where the 3rd colomn ==1
% %then this logical vector is used to select only certain points in the
% %dataset
% 
% %we do the same to display the second dataset
% figure(2);
% plot(dataset2(t2==1,1),dataset2(t2==1,2),'xb');
% hold on;
% plot(dataset2(t2==-1, 1), dataset2(t2==-1,2),'or');
% title('Plot of dataset2') % add figure title
% hold off;


w1 = 0;
w2 = 0;
w3 = 0;

w = [w1 w2 w3];

percentageOfClassifyedPoints = resultLinClass(dataset1, w, t1);
disp('the percentage of classifyed points is  : ');
disp(percentageOfClassifyedPoints);

%We will try to find better coef fo rthis curve :

w1 = 1;
w2 = 1;
w3 = 1;

w = [w1 w2 w3];

percentageOfClassifyedPoints = resultLinClass(dataset1, w, t1);
disp('the percentage of classifyed with w = [1;1;1] points is  : ');
disp(percentageOfClassifyedPoints);
%this is definitly better

%let's plot with the line to know how we should change the coefs :

figure(3);
plot(dataset1(t1==1,1),dataset1(t1==1,2),'xb');
hold on;
plot(dataset1(t1==-1, 1), dataset1(t1==-1,2),'or');
title('Plot of dataset1, first try to draw an hyperplan') % add figure title
% linspaceForVector = linspace(0,1,1);
x = linspace(0,1,10);
hyperplan = -w3/w2 -(w1*x)/w2;
plot(x, hyperplan);
hold off;

%just to remember that the line had this equation :
%     w1*x + w2*y + w3*1 = 0
% <=> y = -w3/w2 -(w1*x)/w2


w1 = -1;
w2 = -1;
w3 = 1;
w = [w1 w2 w3];
linclassForDataset1 = linclass(dataset1,w);
disp('return of linclass(dataset1,w) : ');
disp(linclassForDataset1);
percentageOfClassifyedPoints = resultLinClass(dataset1, w, t1);
disp('the percentage of classifyed points is  : ');
disp(percentageOfClassifyedPoints);
figure(5);
plot(dataset1(t1==1,1),dataset1(t1==1,2),'xb');
hold on;
title('Plot of dataset1, correct hyperplan but wrong classification') % add figure title
plot(dataset1(t1==-1, 1), dataset1(t1==-1,2),'or');
x = linspace(0,1,10);
hyperplan = -w3/w2 -(w1*x)/w2;
plot(x, hyperplan);
hold off;
%Here we have something a bit confusing. We can see on the graph that
%we found an hyperplan that can separate the data points,
%but the function the function linclass indicates that there is no point
%correctly classifyed


w1 = 1;
w2 = 1;
w3 = -1;
w = [w1 w2 w3];
percentageOfClassifyedPoints = resultLinClass(dataset1, w, t1);
disp('the percentage of classifyed points (dataset1, correct classification )is  : ');
disp(percentageOfClassifyedPoints);
%this is definitly better
figure(6);
plot(dataset1(t1==1,1),dataset1(t1==1,2),'xb');
hold on;
plot(dataset1(t1==-1, 1), dataset1(t1==-1,2),'or');
title(compose('Plot of dataset1, correct hyperplan & classification.\nPercentage of correctly classifyed points = %.5f', percentageOfClassifyedPoints)); % add figure title
% linspaceForVector = linspace(0,1,1);
x = linspace(0,1,10);
hyperplan = -w3/w2 -(w1*x)/w2;
plot(x, hyperplan);
hold off;

%Here we found an hyper plan that can separate the data points.


%Now, let's do the same with dataset2 :
w1dataset2 = 1;
w2dataset2 = 1;
w3dataset2 = -1;
wdataset2 = [w1dataset2 w2dataset2 w3dataset2];
figure(8);
plot(dataset2(t2==1,1),dataset2(t2==1,2),'xb');
hold on;
plot(dataset2(t2==-1, 1), dataset2(t2==-1,2),'or');
title('Plot of dataset2, first try') % add figure title
x = linspace(0,1,10);
hyperplan = -w3dataset2/w2dataset2 -(w1dataset2*x)/w2dataset2;
plot(x, hyperplan);
hold off;
%we are really close to classify all points, but it's not the perfect
%result, let's try better


w1dataset2 = 1;
w2dataset2 = 1;
w3dataset2 = -1.06;
wdataset2 = [w1dataset2 w2dataset2 w3dataset2];
percentageOfClassifyedPointsdataset2 = resultLinClass(dataset2, wdataset2, t2);
disp('the percentage of classifyed points is : ');
disp(percentageOfClassifyedPointsdataset2);
figure(9);
plot(dataset2(t2==1,1),dataset2(t2==1,2),'xb');
hold on;
plot(dataset2(t2==-1, 1), dataset2(t2==-1,2),'or');
stringTitle = compose("Plot of dataset2, second try.\nPercentage of corretly classifyed points = %.5f",percentageOfClassifyedPointsdataset2);
title(stringTitle) % add figure title
x = linspace(0,1,10);
hyperplan = -w3dataset2/w2dataset2 -(w1dataset2*x)/w2dataset2;
plot(x, hyperplan);
hold off;
%after looking a little around w3 value, we found a match


%Now we will add the random perturbation :
%to add a random perturbation :
% p=rand(1,3);
% n = n*2 -1;
% p=p*n/norm(n);

%Recall :
%The Euclidean norm (or 2-norm) of a vector v that has N elements is defined by


%We are going to add a random perturbation to the previous exercice. We
%will add a random perturbation to the hyperplan.

% comment : we are going to apply the perturbation on the hyperplan !
% (usually, the perturbation is applyed to the data, 
% but because the hyperplan parameters are determined by the data, 
% it's the same to apply the perturbation to the hyperplane
% 
% How to proced :
% Let's make an example with a perturbation of p = 0.01 ( <=> 1%)
% 1)create a random vector with the same size as the hyperplan vector (here 3)
%   Here we want random values in [-1;1], so we'll use
randomVector = 2*rand(1,3) -1; 
% 2)Normalize the randomVector :
randomVector = randomVector / norm(randomVector);
% 3)Multiply the randomVector by the p factor (here p=0.01)
p=0.01;
randomVector = p * randomVector;
% 4)We want to add this random vector to the hyperplan vector, so we will
%   normalize the hyperplan vector. 
wNormalized = w / norm(w);
% 5)Now both vector have the same lenght, so we can sum them
wWithPerturbation = wNormalized + randomVector;

percentageOfClassifyedPoints = resultLinClass(dataset1, wWithPerturbation, t1);
disp('the percentage of classifyed points (for random perturbation) is  : ');
disp(percentageOfClassifyedPoints);
%this is definitly better
figure(10);
plot(dataset1(t1==1,1),dataset1(t1==1,2),'xb');
hold on;
plot(dataset1(t1==-1, 1), dataset1(t1==-1,2),'or');
title('Classification of dataset1 with random perturbation = 1%') % add figure title
% linspaceForVector = linspace(0,1,1);
x = linspace(0,1,10);

hyperplan = -wWithPerturbation(3)/wWithPerturbation(2) -(wWithPerturbation(1)*x)/wWithPerturbation(2);
plot(x, hyperplan);
hold off;

%We can see it worked perfectly ! (You can see a changed by increaseing the
%value of p

%Now we will tdo the same, but with a loop for all value from 1% to 10%
%with a stepsize of 1%
%For each p value we will 

%Here is the syntax for "for loop" :
%for i = <first value> : <step size> : <final value>
%   //code
%end

%we are going to store the percentage of correctly classifyed
%poitns is the following variable :
matrixOfErrors = zeros(100,10);
%we have 10 colonmns, each colomns is a p value (0.1, 0.2, ..., 0.10)
%we have 100 lines, each p value has 100 percentage of error to calculate

counter = 1; 
%we also keep a counter because we can't use p directly as an index to
%access the values inside the matrixOfErrors
disp("this is the w value we will use :");
disp(w);
wNormalized = w / norm(w);
for p = 0.01:0.01:0.1
   for i = 0:10000
       randomVector = 2*rand(1,3) -1;
       randomVector = randomVector / norm(randomVector);
       randomVector = p * randomVector;
       
       wWithPerturbation = wNormalized + randomVector;
       percentageOfClassifyedPoints = resultLinClass(dataset1, wWithPerturbation, t1);
       matrixOfErrors(i+1,counter) = percentageOfClassifyedPoints;
   end
   counter = counter + 1;
end

%We got a nice result ! a hugh matrix of errors ! :)
%Now it's time to plot it
%First we calculate the average of each colomn (average error percentage
%for each p value).

%def : If A is a matrix, then mean(A) returns a row vector containing the mean of each column.
percentageErrorsAverrage = mean(matrixOfErrors);
%we also create a vector of p value :
pValuesVector = 0.01:0.01:0.10;

%then we just have to plot the percentage average VS the p values :
figure(11);
plot(pValuesVector, percentageErrorsAverrage);
hold on;
title('Percentage of correclty classifyed points average VS perturbation size p, dataset 1'); % add figure title
hold off;
%Here we have a wonderful graph, it's working correctly !!!

%Now we do the same but for the second dataset :


matrixOfErrorsDataset2 = zeros(100,10);
counter = 1; 
wdataset2Normalized = wdataset2 / norm(wdataset2);
% this is smarter to do that outside of the loop, beacause we can calculate
% the value once and keep it since it doesn't change
for p = 0.01:0.01:0.1
   for i = 0:10000
       randomVector = 2*rand(1,3) -1;
       %comment : here we have to make two lines for this assignement !!
       %beacause is we call twice rand() in the same line, it's going to
       %give us two different random vectors !!!
       randomVector = (randomVector / norm(randomVector)) * p;
       wWithPerturbation = wdataset2Normalized + randomVector;
       percentageOfClassifyedPoints = resultLinClass(dataset2, wWithPerturbation, t2);
       matrixOfErrorsDataset2(i+1,counter) = percentageOfClassifyedPoints;
   end
   counter = counter + 1;
end

percentageErrorsAverrageDataset2 = mean(matrixOfErrorsDataset2);
figure(12);
plot(pValuesVector, percentageErrorsAverrageDataset2);
hold on;
title('Percentage of correclty classifyed points average VS perturbation size p ,dataset 2');
hold off;

%we make a cmparaison of the two curve :
figure(13);
plotdataset1 = plot(pValuesVector, percentageErrorsAverrage);
hold on;
plotdataset2 = plot(pValuesVector, percentageErrorsAverrageDataset2);
title('Percentage of correclty classifyed points average VS perturbation size p');
legend([plotdataset1 plotdataset2],'dataset 1','dataset 2', 'Location','northwest','Orientation','vertical');
hold off;

%We can see on this graph that the first dataset has a better resistance to
%random perturbation given on the hyperlan parameter.
%we can explain that by the distribution of the dataset points :
%   It is clear that on dataset2, the points of the two classes are closer.
%   Which means that when a random perturbation is added, the points can be
%   more easyly classifyed in the wrong class.





%and now, just need to add that to the weight vector


