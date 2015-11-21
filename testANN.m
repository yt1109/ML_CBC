function predictions = testANN(net, x2)
%{
net = a neural network, x2 = examples x2 
produces a vector of label predictions
%}

   Y = sim(net, x2);  
   predictions = NNout2labels(Y);
end

