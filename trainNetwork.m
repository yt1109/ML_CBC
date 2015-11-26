
cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);

nClasses = 6;
kFold = 10;
trainingFcn = 'trainrp';
filename = strcat(trainingFcn, '_Network');

%returns optimal parameters over all folds 
OptimalParameters =  CrossValidateNN(x2, y2, kFold, trainingFcn);

net = SetupNet(trainingFcn, OptimalParameters.layers, OptimalParameters.npl, x2, y2, (1:size(x2,2)), [], []);
net = ConfigureTrainingParams(net, OptimalParameters, trainingFcn);


net.trainParam.showWindow = true;

bestMatrix = zeros(nClasses);
bestCRate = 0;
bestNet = net;
for i=1:100
    trainedNet = train(net, x2, y2);
    matrix = ConfusionMatrix([cleanData.y, testANN(trainedNet, x2)], nClasses);
    classificationRate = sum(diag(matrix)) / sum(sum(matrix));
    if classificationRate > bestCRate
        bestMatrix = matrix;
        bestNet = trainedNet;
    end
end



classR = AnalyseMatrix(bestMatrix, nClasses);



save(filename);