function [net] = ConfigureTrainingParams(net, Parameters, trainingFcn)


    switch trainingFcn
        case 'traingd'
            net.trainParam.epochs = Parameters.epochs;
            net.trainParam.lr = Parameters.lr;
        case 'traingda'
            net.trainParam.epochs = Parameters.epochs;
            net.trainParam.lr = Parameters.lr;
            net.trainParam.lr_inc = Parameters.lr_inc;
            net.trainParam.lr_dec = Parameters.lr_dec;
        case 'traingdm'    
            net.trainParam.epochs = Parameters.epochs;
            net.trainParam.lr = Parameters.lr;
            net.trainParam.mc = Parameters.mc;
        case 'trainrp'
            net.trainParam.epochs = Parameters.epochs;
            net.trainParam.delt_inc = Parameters.delt_inc;
            net.trainParam.delt_dec = Parameters.delt_dec;
        otherwise
            warning('invalid training function');
    end
    


end