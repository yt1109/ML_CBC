function [net] = ConfigureTrainingParams(net, Parameters)

    paramArray = fieldnames(Parameters);
    
    for i=1:size(paramArray)
        name = paramArray(i);
        if (strcmp(name,'layers') || strcmp(name,'npl'))
            continue
        end
        field = strcat('trainParam.', name);
        name{1}
        value = extractfield(Parameters, name{1});
        net = setfield(net, field,  value);
    end


end