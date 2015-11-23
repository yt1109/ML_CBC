
cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);

kFold = 10;
trainingFcn = 'trainrp';

%returns optimal parameters over all folds 
OptimalParameters =  CrossValidateNN(x2, y2, kFold, trainingFcn);

net = SetupNet(trainingFcn, OptimalParameters.layers, OptimalParameters.npl, x2, y2, (1:size(x2,2)), [], []);
net = ConfigureTrainingParams(net, OptimalParameters, trainingFcn);


net.trainParam.showWindow = true;
net = train(net, x2, y2);




matrix = ConfusionMatrix([cleanData.y, testANN(net, x2)], 6);

classR = AnalyseMatrix(matrix, 6);