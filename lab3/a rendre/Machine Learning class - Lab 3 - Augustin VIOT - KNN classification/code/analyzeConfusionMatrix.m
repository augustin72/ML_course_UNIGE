%This file will compute the selectivity/specificity,
% precision/recall, F1 measure based on the confusion matrix

function [errorRate, sensitivity, specificity, precision, recall, F1] = analyzeConfusionMatrix(confusionMatrix)
%This function provides useful info based on the confusionMatrix it takes
%as parameter. It will compute the following values : 
%errorRate, selectivity, specificity, precision, recall, F1


%Some vocabulary recall :
% (number of) positive samples (P)
% (number of) negative samples (N)
% (number of) true positive (TP)    (also c11)
% eqv. with hit
% (number of) true negative (TN)    (also c00)
% eqv. with correct rejection
% (number of) false positive (FP)   (also c01)
% eqv. with false alarm, Type I error
% (number of) false negative (FN)   (also c10)
% eqv. with miss, Type II error

%This is the matrix we receive :
%                     Real value
%             |    -1     |   1
%     ================================
%             |    TN     |   FN
%          -1 |           |
% predicted===========================
%             |    FP     |   TP
%          1  |           |

TP = confusionMatrix(2,2);
TN = confusionMatrix(1,1);
FN = confusionMatrix(1,2);
FP = confusionMatrix(2,1);

sensitivity = TP / (TP+FN); %among all the real 1 value, percentage of correctly classified

specificity = TN / (TN + FN); %among all the real -1 value, percentage of correctly classified


precision = TP/(TP+FP);
%The fraction of positive outputs that was actually positive

recall = sensitivity;

F1 = 2 * ( (precision * recall) / (precision + recall) );


errorRate = (FP +FN) / (FP +FN + TP +TN);

end
