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
            for layers=1:1
                for npl=5:5
                    net = SetupNet('trainrp', layers, npl, x2, y2, trainIndex, valIndex, testIndex);
                    for delt_inc=1.2:0.05:1.2
                        for delt_dec=0.5:0.05:0.5
                            net.trainParam.delt_inc = delt_inc;
                            net.trainParam.delt_dec = delt_dec;
                            [~,tr] = train(net, x2, y2);
                            if tr.best_vperf < bestPerf
                                bestPerf = tr.vperf;
                      
                                Parameters.layers = layers;
                                Parameters.npl = npl;
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