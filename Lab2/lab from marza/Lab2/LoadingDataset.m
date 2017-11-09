clear;
clc;
x=load('Dataset.txt');
h=10;
for j=1:5
for i=1:10
    
x=x(randperm(size(x,1)),:);

training=x(1:h,:);
test=x(11:end,1:end);

[targetTest,errorRate]=Checking(training,test);
error(i)=errorRate/4;

end
meanError(j)=mean(error)*100;
stdError(j)=std(error)*100;
h=h+1;
end
figure(2)
plot(meanError);
title('Error percentage');
ylabel('Error%');
xticklabels({'10','','11','','12','','13','','14'});
xlabel('Elements of Training');
figure(3)
plot(stdError);
title('Std percentage');
ylabel('Std%');
xticklabels({'10','','11','','12','','13','','14'});
xlabel('Elements of Training');


