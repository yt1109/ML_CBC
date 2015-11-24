function [cleanMatrix, noisyMatrix, cleanPerformance, noisyPerformance] = CrossValidatePE(trainingFcn, x2, y2, xn2, yn2, kFold, nClasses)


    cleanMatrix = zeros(nClasses);
    noisyMatrix = zeros(nClasses);
    
    cleanActual = zeros(size(y2, 2), 1);
    noisyActual = zeros(size(yn2, 2), 1);
    
    CleanIndices = GenerateIndices(kFold, size(x2, 2));
    NoisyIndices = GenerateIndices(kFold, size(xn2, 2));
    foldSize = floor(size(x2, 2)/kFold);
    cleanValidationSets = cell(1);
    noisyValidationSets = cell(1);
    
    for i=1:kFold
        cleanValidationSets{i} = CleanIndices.training{i}(1:foldSize);
        noisyValidationSets{i} = NoisyIndices.training{i}(1:foldSize);
        CleanIndices.training{i} = setdiff(CleanIndices.training{i}, cleanValidationSets{i});
        NoisyIndices.training{i} = setdiff(NoisyIndices.training{i}, noisyValidationSets{i});
    end
    
   
    for i=1:size(y2,2)
        [~,cleanActual(i)] = max(y2(:,i));
    end
    for i=1:size(yn2,2)
        [~,noisyActual(i)] = max(yn2(:,i));
    end
    
    cleanPerformance = 0;
    noisyPerformance = 0;
    for i=1:kFold
        
        
        % generate optimal param configuration per fold
        Parameters = OptimiseParameters(x2, y2, trainingFcn, CleanIndices.training{i}, cleanValidationSets{i}, CleanIndices.test{i});
        
        cleanNet = SetupNet(trainingFcn, Parameters.layers, Parameters.npl, x2, y2, CleanIndices.training{i}, cleanValidationSets{i}, CleanIndices.test{i});
        cleanNet = ConfigureTrainingParams(cleanNet, Parameters, trainingFcn);
        noisyNet = SetupNet(trainingFcn, Parameters.layers, Parameters.npl, xn2, yn2, NoisyIndices.training{i}, noisyValidationSets{i}, NoisyIndices.test{i});
        noisyNet = ConfigureTrainingParams(noisyNet, Parameters, trainingFcn);
        
        [cleanNet,ctr] = train(cleanNet, x2, y2);
        [noisyNet,ntr] = train(noisyNet, xn2, yn2);
        
        cleanPerformance = cleanPerformance + (1 - ctr.best_tperf);
        noisyPerformance = noisyPerformance + (1 - ntr.best_tperf);
        
        
      
        cleanMatrix = cleanMatrix + ConfusionMatrix([cleanActual(CleanIndices.test{i},:), testANN(cleanNet, x2(:,CleanIndices.test{i}))], nClasses);
        noisyMatrix = noisyMatrix + ConfusionMatrix([noisyActual(NoisyIndices.test{i},:), testANN(noisyNet, xn2(:,NoisyIndices.test{i}))], nClasses);
        
    end    
   
    cleanPerformance = cleanPerformance/kFold;
    noisyPerformance = noisyPerformance/kFold;
    
    %save CrossValidatePE.mat cleanPerformance noisyPerformance;
    
end