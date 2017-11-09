clear;  %clean memomry
clc;    %clean screen
clf;    %clean console

%This is exercice 3 of the first lab :

datasetEx2 = load('datasetEx2.txt');

%First, we will plot the dataset to get an idea about what we kind of data
%we have 

%we know the third colomn is the one used for the target, so we create a
%vector containing only the target :
t=datasetEx2(:,3);



%we plot the first dataset
figure(1);
%firstly, we plot the pont where the information class is equal to 1,
%these points are going to be the ones represented with a blue cross
plot(datasetEx2(t==1,1),datasetEx2(t==1,2),'xb');
hold on;
%then we add the other point (information class == -1),
%these points will be the red circles
plot(datasetEx2(t==-1, 1), datasetEx2(t==-1,2),'or');
title('Plot of dataset1') % add figure title
hold off;

%from this first overview, we can expect the data to be linearly separable
%now, let's try to find an hyperplan that can seperate the data :

w1 = -0.1;
w2 = 1;
w3 = -1;
w = [w1 w2 w3];

percentageOfClassifyedPoints = resultLinClass(datasetEx2, w, t);
disp('the percentage of classifyed points (dataset1, correct classification )is  : ');
disp(percentageOfClassifyedPoints);
%this is definitly better
figure(6);
plot(datasetEx2(t==1,1),datasetEx2(t==1,2),'xb');
hold on;
plot(datasetEx2(t==-1, 1), datasetEx2(t==-1,2),'or');
title(compose('Plot of dataset1, correct hyperplan & classification.\nPercentage of correctly classifyed poitns = %.5f', percentageOfClassifyedPoints)); % add figure title
% linspaceForVector = linspace(0,1,1);
x = linspace(0,35,3);
hyperplan = -w3/w2 -(w1*x)/w2;
plot(x, hyperplan);
hold off;

%after some tests, we found a correct hyperplan that classifyed everything
%:) youpi

