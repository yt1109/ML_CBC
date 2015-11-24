function [Parameters] = OptimiseParameters(x2, y2, trainingFcn, trainIndex, valIndex, testIndex)
    
    bestPerf = 1;
    Parameters.epochs = 1000;
 
    
    switch trainingFcn
        case 'traingd'
            Parameters.layers = 20;
            Parameters.npl = 10;
            Parameters.lr = 0.1;
            for layers=20:30
                for npl=10:20
                    net = SetupNet('traingd', layers, npl, x2, y2, trainIndex, valIndex, testIndex);
                    for lr=0.01:0.01:0.1
                            net.trainParam.lr = lr;
                            [~,tr] = train(net, x2, y2);
                            if tr.best_vperf < bestPerf
                                bestPerf = tr.vperf;
                      
                                Parameters.layers = layers;
                                Parameters.npl = npl;
                                Parameters.lr = lr;                              
                            end
                    end
                end
            end
        case 'traingda'
            Parameters.layers = 5;
            Parameters.npl = 5;
            Parameters.lr = 0.1;
            Parameters.lr_inc = 1.05;
            Parameters.lr_dec = 0.5;
            for layers=5:10
                for npl=5:10
                    net = SetupNet('traingda', layers, npl, x2, y2, trainIndex, valIndex, testIndex);
                    for lr=0.01:0.01:0.1
                        for lr_inc=1.05:0.01:1.1
                            for lr_dec=0.5:0.05:0.7
                                net.trainParam.lr = lr;
                                net.trainParam.lr_inc = lr_inc;
                                net.trainParam.lr_dec = lr_dec;
                                [~,tr] = train(net, x2, y2);
                                if tr.best_vperf < bestPerf
                                    bestPerf = tr.vperf;

                                    Parameters.layers = layers;
                                    Parameters.npl = npl;
                                    Parameters.lr = lr;
                                    Parameters.lr_inc = lr_inc;
                                    Parameters.lr_dec = lr_dec;
                                end
                            end
                        end
                    end
                end
            end
        case 'traingdm'    
            Parameters.layers = 10;
            Parameters.npl = 10;
            Parameters.lr = 0.1;
            Parameters.mc = 0.9;
            for layers=10:20
                for npl=10:20
                    net = SetupNet('traingdm', layers, npl, x2, y2, trainIndex, valIndex, testIndex);
                    for lr=0.01:0.01:0.1
                        for mc=0.9:0.01:0.95
                            net.trainParam.lr = lr;
                            net.trainParam.mc = mc;
                            [~,tr] = train(net, x2, y2);
                            if tr.best_vperf < bestPerf
                                bestPerf = tr.vperf;
                      
                                Parameters.layers = layers;
                                Parameters.npl = npl;
                                Parameters.lr = lr;
                                Parameters.mc = mc;
                              
                            end
                        end
                    end
                end
            end
        case 'trainrp'
            Parameters.layers = 5;
            Parameters.npl = 1;
            Parameters.delt_inc = 1.2;
            Parameters.delt_dec = 0.5;
            for layers=5:20
                for npl=1:10
                    net = SetupNet('trainrp', layers, npl, x2, y2, trainIndex, valIndex, testIndex);
                    for delt_inc=1:0.05:1.4
                        for delt_dec=0.3:0.05:0.7
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