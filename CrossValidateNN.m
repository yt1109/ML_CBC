function [ OptimalParameters ] = CrossValidateNN(x2, y2, kFold, trainingFcn)

    Indices = GenerateIndices(10, size(x2,2));
    
    bestPerf = inf;
    OptimalParameters = [];
    
    for i=1:kFold
        perf = 0;
        %x2fold = x2(:,Indices.training{i});
        %y2fold = y2(:,Indices.training{i});
        % generate optimal param configuration per fold
        Parameters = OptimiseParameters(x2, y2, trainingFcn, Indices.training{i}, Indices.test{i}, []);
        optimalEpoch = zeros(kFold);
        % crossfold param configuration to get total perforamnce of param
        % configuration
        for testFold=1:kFold
            net = SetupNet(trainingFcn, Parameters.layers, Parameters.npl, x2, y2, Indices.training{testFold}, Indices.test{testFold}, []);
            [~,tr] = train(net, x2, y2);
            optimalEpoch(testFold) = tr.best_epoch;
            perf = perf + tr.best_vperf;
        end    
        
        if perf < bestPerf
            Parameters.epoch = round(mean(optimalEpoch));
            OptimalParameters = Parameters;
        end
        
    end
    
    
    
    
        
   
end

