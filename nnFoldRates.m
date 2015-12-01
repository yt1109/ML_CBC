OptimalNN = load('trainrp_Network_latest');
cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);
[xn2, yn2] = ANNdata(noisyData.x, noisyData.y);

kFold = 10;
nClasses = 6;

OptimalParameters = OptimalNN.OptimalParameters;
OptimalFunction = OptimalNN.trainingFcn;


CleanIndices = GenerateIndices(10, size(x2,2));
NoisyIndices = GenerateIndices(kFold, size(xn2, 2));


cleanClassificationRates = zeros(kFold, 1);
noisyClassificationRates = zeros(kFold, 1);

for i=1:kFold
    net = SetupNet(OptimalFunction, OptimalParameters.layers, OptimalParameters.npl, x2, y2, CleanIndices.training{i}, CleanIndices.test{i}, []);
    net = ConfigureTrainingParams(net, OptimalParameters, OptimalFunction); 
    net = train(net, x2, y2);
    matrix = ConfusionMatrix([cleanData.y(CleanIndices.test{i},:), testANN(net, x2(:,CleanIndices.test{i}))], nClasses);
    cleanClassificationRates(i) = sum(diag(matrix)) / sum(sum(matrix));
end

for i=1:kFold
    nnet = SetupNet(OptimalFunction, OptimalParameters.layers, OptimalParameters.npl, xn2, yn2, NoisyIndices.training{i}, NoisyIndices.test{i}, []);
    nnet = ConfigureTrainingParams(nnet, OptimalParameters, OptimalFunction); 
    nnet = train(nnet, xn2, yn2);
    matrix = ConfusionMatrix([noisyData.y(NoisyIndices.test{i},:), testANN(nnet, xn2(:,NoisyIndices.test{i}))], nClasses);
    noisyClassificationRates(i) = sum(diag(matrix)) / sum(sum(matrix));
end
    
    
    
    
    
    