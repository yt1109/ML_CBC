function [perf] = PlotTopoGraph(n, trainingFcn, x2, y2)

    X = 1:n;
    Y = 1:n;
    Z = zeros(size(X,2),size(Y,2));

    perf = 0;
    for i=X
       for j=Y
           net = feedforwardnet(repmat(j, 1, i), trainingFcn);
           net.inputs{1}.processFcns = {};
           net.trainParam.epochs = 100;
           net = configure(net, x2, y2);
           net.trainParam.showWindow = false;
           net.trainParam.showCommandLine = false;
           [~, tr] = train(net, x2, y2);
           Z(i,j) = 1 - tr.best_vperf;
           perf = perf + Z(i,j);
       end
    end
    perf = perf / (size(X,2) * size(Y,2));
    filename = strcat(trainingFcn, '_Topo');

    mesh( X, Y, Z);
    xlabel('Layers');
    ylabel('Neurons/Layer');
    zlabel('Performance');
    
    saveas(gcf, filename, 'png');

end