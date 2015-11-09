function [indices] = GenerateIndices(k, n)
    
    foldSize = floor(n/k);
    
    extra = mod(n, k);
    
    indices = zeros(foldSize + extra, k);
    
    for i=1:k
        
        first = 1 + (i -1) * foldSize;
        
        for j=1:foldSize          
            indices(j,i) = first + j - 1;
        end   
        
    end
    
    lastIndex = 1;
    for i=(k * foldSize + 1):n
        indices(foldSize + lastIndex, k) = i;
        lastIndex = lastIndex + 1;
    end
    
    
end