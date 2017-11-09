function  [ targetTest,errorRate ] = Bayes(training, test)
[rowTraining, columnTraining]=size(training);
[rowTest, columnTest]=size(test);

%Training
numberFeatures=max(training(:,end));
for h=1:numberFeatures
    frequencyFeatures(1,h)=length(find(training(:,end)==h));
    probFeatures(1,h)=frequencyFeatures(1,h)/rowTraining;
    for i=1:columnTraining-1
        maxValue(i)=max(training(:,i));
        for j=1:maxValue(i)
            event{j,i}=find(training(:,i)==j);
            frequencyEventFeatures{h}{j,i}=length(find(training(event{j,i},5)==h));
            probEventFeatures{h}{j,i}=(frequencyEventFeatures{h}{j,i}+1)/(frequencyFeatures(1,h)+2);
        end
    end
end

%Test
for h=1:numberFeatures
    for i=1:rowTest
        for j=1:columnTraining-1
            k=test(i,j);
            probEventTestFeatures{h}(i,j)=probEventFeatures{h}{k,j};
            if(k>maxValue(j))
            errorRate='this classificator is not trained for that pattern';
            probEventTestFeatures{h}(i,j)=[];
            return;
            end
        end
    end
    probEventTestFeatures{h}=prod(probEventTestFeatures{h},2);
    testFunctionFeatures(:,h)=probFeatures(1,h).*probEventTestFeatures{h};
end

%%
%Drawing graphs
for i=1:rowTest
    if(testFunctionFeatures(i,end)<testFunctionFeatures(:,end-1))
        targetTest(i)=1;
    else
        
        targetTest(i)=2;
    end
end

if columnTest>columnTraining-1
    fprintf( ...
        'number of correct classifications: %i out of %i total observations\n', ...
        sum(test(:,end)==targetTest'), size(test(:,end),1))
    errorRate=4-sum(test(:,end)==targetTest');
end

% for i=1:length(testFunctionFeatures)
%    if(targetTest(i)~=test(i,end))
%        testFunctionErr(i,:)=testFunctionFeatures(i,:);
%    else
%        testFunctionErr(i,:)=0;
%    end
% end
% figure(1)
% bar(testFunctionFeatures);
% title('Probability of playing');
% legend('Yes','No');
% hold on
% bar(testFunctionErr,'LineWidth',2,'EdgeColor','r');
% hold off

end

