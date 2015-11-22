
cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);

%returns optimal parameters over all folds 
OptimalParameters =  CrossValidateNN(x2, y2, 10, 'trainrp');

net = SetupNet('trainrp', OptimalParameters.layers, OptimalParameters.npl, x2, y2, (1:size(x2,2)), [], []);
net = ConfigureTrainingParams(net, OptimalParameters);


net.trainParam.showWindow = true;
train(net, x2, y2);


