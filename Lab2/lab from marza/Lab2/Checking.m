function [targetTest,errorRate] = Checking(training, test)

[rowTraining, columnTraining]=size(training);
[rowTest, columnTest]=size(test);

if(columnTest<columnTraining-1)
    targetTest=0;
    errorRate = 'Number of columns in test is lower then number of columns -1 in training';
    return;
end

if(find(training<1))
    targetTest=0;
    errorRate='Found value less than zero for Training';
    return;
end

if(find(test<1))
    targetTest=0;
    errorRate='Found value less than zero for Test';
    return;
end

[ targetTest,errorRate ] = Bayes(training, test);
end

