cleanData = load('cleandata_students.mat');
noisyData = load('noisydata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);
[xn2, yn2] = ANNdata(noisyData.x, noisyData.y);

[cleanMatrix, noisyMatrix] = CrossValidatePE(x2, y2, xn2, yn2, 10, 6);

