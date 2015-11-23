
cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);

deepness = 40;

PlotTopoGraph(deepness, 'traingd', x2, y2);


PlotTopoGraph(deepness, 'traingda', x2, y2);


PlotTopoGraph(deepness, 'traingdm', x2, y2);


PlotTopoGraph(deepness, 'trainrp', x2, y2);









