function y = linclass(x,w)
% linear threshold classifier
%   x: n x m data set to classify
%   w: 1 x m coefficient vector of hyperplane
  y = 2*(x*w'<0)-1;
end

% recall : ' means transposée 

%We added a *2 -1 to the resultuts, because we want this function to return
%the class given by the classifier w.

% this source code MUST be saved in a separate file named linclass.m

% typing 'help linclass' at the prompt will print the three lines of comments
% that follow the function header

% display the number of correctly classified points