function [ net ] = SetupNet(trainingFcn, layers, npl, x2, y2, trainIndex, valIndex, testIndex)
    

            net = feedforwardnet(repmat(npl, 1, layers), trainingFcn);
            net.inputs{1}.processFcns = {};
            net = configure(net, x2, y2);
            net.divideFcn = 'divideind';
            net.divideParam.trainInd = trainIndex;
            net.divideParam.valInd = valIndex;
            net.divideParam.testInd = testIndex;
            %net.trainParam.epochs = 100;
            net.trainParam.showWindow = false;
            net.trainParam.showCommandLine = false;
   
   
end

