
cleanData = load('cleandata_students.mat');

[x2, y2] = ANNdata(cleanData.x, cleanData.y);

deepness = 40;

gdTopoPerf = PlotTopoGraph(deepness, 'traingd', x2, y2);


gdaTopoPerf = PlotTopoGraph(deepness, 'traingda', x2, y2);


gdmTopoPerf = PlotTopoGraph(deepness, 'traingdm', x2, y2);


rpTopoPerf = PlotTopoGraph(deepness, 'trainrp', x2, y2);



save topo_perf.mat gdTopoPerf gdaTopoPerf gdmTopoPerf rpTopoPerf





