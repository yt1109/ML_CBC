function [normalisedMatrix] = NormaliseMatrix(confusionMatrix)

    matrixSize = size(confusionMatrix,1);
    normalisedMatrix = zeros(matrixSize);
   
    for i=1:matrixSize
        rowSize = sum(confusionMatrix(i,:));
        normalisedMatrix(i,:) = confusionMatrix(i,:) ./ rowSize;
    end
end