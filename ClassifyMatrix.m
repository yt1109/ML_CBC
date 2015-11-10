function [ClassificationResults] = ClassifyMatrix(confusionMatrix, nAttributes)
    for i=1:nAttributes
        ClassificationResults.recall(i, 1) = CalculateRecall(confusionMatrix(i,:), i);
        ClassificationResults.precision(i, 1) = CalculatePrecision(confusionMatrix(:,i), i);
        ClassificationResults.fMeasure(i, 1) = CalculateFMeasure(ClassificationResults.precision(i, 1), ClassificationResults.recall(i, 1), 1); 
    end
    
    ClassificationResults.rate = CalculateRate(confusionMatrix);
end


function [recall] = CalculateRecall(row, class)
    recall = row(1, class) / sum(row);
end

function [precision] = CalculatePrecision(column, class)
    precision = column(class, 1) / sum(column);
end

function [classificationRate] = CalculateRate(matrix)
    classificationRate = sum(diag(matrix)) / sum(sum(matrix));
end

function [fMeasure] = CalculateFMeasure(precision, recall, a)
    fMeasure = (1 + a ^ 2) * (precision * recall/ (precision + recall));
end