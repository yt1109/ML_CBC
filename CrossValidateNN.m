function [ OptimalParameters ] = CrossValidateNN(x2, y2, kFold, nClasses, trainingFcn)

    Indices = GenerateIndices();
    
    bestPerf = inf;
    OptimalParameters = null;
    for i=1:kFold
        perf = 0;
        
        % generate optimal param configuration per fold
        Parameters = OptimiseParameters(x2, y2, trainingFcn, Indices.training, Indices.test, []);
        
        % crossfold param configuration to get total perforamnce of param
        % configuration
        for testFold=1:kFold
            net = SetupNet(trainingFcn, Parameters.layers, Parameters.npl, x2, y2, [], [], []);
            net.
            [~,tr] = train(net, x2, y2);
            perf = perf + tr.best_vperf;
        end    
        
        if perf < bestPerf
            OptimalParameters = Parameters;
        end
        
    end
    
    
    
    
        
   
end

