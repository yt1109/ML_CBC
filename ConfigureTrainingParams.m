function [net] = ConfigureTrainingParams(net, Parameters, trainingFcn)


    switch trainingFcn
        case 'traingd'
        
        case 'traingda'
            
        case 'traingdm'    
           
        case 'trainrp'
            net.trainParam.epochs = Parameters.epochs;
            net.trainParam.delt_inc = Parameters.delt_inc;
            net.trainParam.delt_dec = Parameters.delt_dec;
        otherwise
            warning('invalid training function');
    end
    


end