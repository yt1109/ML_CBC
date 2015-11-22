function [net] = ConfigureTrainingParams(net, Parameters, trainingFcn)

%     paramArray = fieldnames(Parameters);
%     
% %     for i=1:size(paramArray)
% %         name = paramArray(i);
% %         if (strcmp(name,'layers') || strcmp(name,'npl'))
% %             continue
% %         end
% %         field = strcat('trainParam.', name);
% %         name{1}
% %         value = extractfield(Parameters, name{1});
% %         net.(field) = value;
% %     end

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