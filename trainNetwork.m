function trainNetwork

cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);


OptimalParameters =  CrossValidateNN(x2, y2, 10, 6, 'trainrp');





end