rawdata=load('semeion.data');
x=rawdata(:,1:256);
t=rawdata(:,end-9:end);
clear('rawdata');
t=sign(t(:,[2:end 1])-.5);
