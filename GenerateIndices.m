function [Indices] = GenerateIndices(k, n)
    
    foldSize = floor(n/k);
    
    extra = mod(n, k);
    
    Indices.build = zeros(foldSize + extra, k);
    Indices.training = cell(1);
    Indices.test = cell(1);
    
    for i=1:k
        
        first = 1 + (i -1) * foldSize;
        
        for j=1:foldSize          
            Indices.build(j,i) = first + j - 1;
        end   
        
    end
    
    lastIndex = 1;
    for i=(k * foldSize + 1):n
        Indices.build(foldSize + lastIndex, k) = i;
        lastIndex = lastIndex + 1;
    end
    
    
    for i=1:k
        test = Indices.build(:,i);
        training = setdiff(Indices.build, test);
       
        Indices.training{i} = training(training~=0);
        Indices.test{i} = test(test~=0);
    end
    
    
    
end