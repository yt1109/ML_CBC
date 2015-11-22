cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);
[xn2, yn2] = ANNdata(noisyData.x, noisyData.y);

nClasses = 6;
kFold = 10;

[cleanMatrix, noisyMatrix] = CrossValidatePE('trainrp', x2, y2, xn2, yn2, kFold, nClasses);

CleanClassification = AnalyseMatrix(cleanMatrix, nClasses);
NoisyClassification = AnalyseMatrix(noisyMatrix, nClasses);

