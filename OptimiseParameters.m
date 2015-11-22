function [Parameters] = OptimiseParameters(x2, y2, trainingFcn, trainIndex, valIndex, testIndex)
    
    bestPerf = 1;
 
    switch trainingFcn
        case 'traingd'
        
        case 'traingda'
            
        case 'traingdm'    
           
        case 'trainrp'
            Parameters.layers = 15;
            Parameters.npl = 1;
            Parameters.delt_inc = 1.2;
            Parameters.delt_dec = 0.5;
            for i=15:25
                for j=1:5
                    net = SetupNet('trainrp', i, j, x2, y2, trainIndex, valIndex, testIndex);
                    for delt_inc=1.1:0.01:1.3
                        for delt_dec=0.4:0.01:0.6
                            net.trainParam.delt_inc = delt_inc;
                            net.trainParam.delt_dec = delt_dec;
                            [~,tr] = train(net, x2, y2);
                            if tr.best_vperf < bestPerf
                                bestPerf = tr.vperf;
                                Parameters.layers = i;
                                Parameters.npl = j;
                                Parameters.delt_inc = delt_inc;
                                Parameters.delt_dec = delt_dec;
                              
                            end
                        end
                    end
                end
            end
        otherwise
            warning('invalid training function!');
    
    end
    
    
end