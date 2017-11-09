function resultLinClass = resultLinClass(dataset, w, t)
%This function calculates the percentage of points correctly classyfied
%it takes three parameters : 
%dataset : the dataset we want to check
%w : 1 x m coefficient vector of hyperplane used to classify
%t : the vector containing the target of each individual


numberOfCorrectlyClassifyedPoints = sum(linclass(dataset, w)==t);
numberOfPoints = size(dataset, 1);
%size(A,1) for number of rows. size(A,2) for number of columns
resultLinClass = numberOfCorrectlyClassifyedPoints / numberOfPoints;

end