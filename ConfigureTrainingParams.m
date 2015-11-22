function [net] = ConfigureTrainingParams(net, Parameters)

    paramArray = properties(Parameters);
    
    for i=1:numel(paramArray)
        name = Parameters.(paramArray(i));
        if (strcmp(name,'layers') || strcmp(name,'npl'))
            continue
        end
        field = strcat('trainParam.', name);
        value = extractfield(Parameters, name);
        net = setfield(net, field,  value);
    end


end